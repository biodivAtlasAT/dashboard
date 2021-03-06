/*
 * Copyright (C) 2012 Atlas of Living Australia
 * All Rights Reserved.
 *
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 */

package au.org.ala.dashboard

import au.com.bytecode.opencsv.CSVWriter
import grails.converters.JSON
import org.apache.commons.io.FileUtils
import org.springframework.context.i18n.LocaleContextHolder
import org.springframework.context.MessageSource


class DashboardController {

    def metadataService, cacheService
    MessageSource messageSource

    /**
     * Show main dashboard page.
     */
    def index = {
        [panelInfo: metadataService.getPanelInfo() as JSON]
    }

    def collectionPanel = {
        render view: 'panels/collectionPanel', model: [collections: metadataService.getCollectionsByCategory()]
    }

    def recordsPanel = {
        render view: 'panels/recordsPanel', model: [totalRecords: metadataService.getTotalAndDuplicates()]
    }

    def datasetsPanel = {
        render view: 'panels/datasetsPanel', model: [datasets: metadataService.getDatasets()]
    }

    def basisRecordsPanel = {
        render view: 'panels/basisRecordsPanel', model: [basisOfRecord: metadataService.getBasisOfRecord()]
    }

    def dateRecordsPanel = {
        render view: 'panels/dateRecordsPanel', model: [dateStats: metadataService.getDateStats()]
    }

    def nslPanel = {
        render view: 'panels/nslPanel', model: [taxaCounts: metadataService.getTaxaCounts()]
    }

    def spatialPanel = {
        render view: 'panels/spatialPanel', model: [spatialLayers: metadataService.getSpatialLayers()]
    }

    def statePanel = {
        render view: 'panels/statePanel', model: []
    }

    def identifyLifePanel = {
        render view: 'panels/identifyLifePanel', model: [identifyLifeCounts: metadataService.getIdentifyLifeCounts()]
    }

    def mostRecordedSpeciesPanel = {
        Map groups = [:]
        List listOfGroups =['all_lifeforms', 'Plants', 'Animals', 'Birds', 'Reptiles', 'Arthropods', 'Mammals', 'Fishes', 'Insects', 'Amphibians', 'Fungi']
        listOfGroups.each {
            groups.put(it, messageSource.getMessage("panels.mostRecordedSpeciesPanel.dropdownBox.${it}",null, "Not defined", LocaleContextHolder.getLocale()))
        }
        def sortedGroups = groups.sort({m1, m2 -> m1.value <=> m2.value})
        render view: 'panels/mostRecordedSpeciesPanel', model: [mostRecorded: metadataService.getMostRecordedSpecies('all'), sortedGroups: sortedGroups]
    }

    def typeSpecimensPanel = {
        render view: 'panels/typeSpecimensPanel', model: [typeCounts: metadataService.getTypeStats()]
    }

    def barcodeOfLifePanel = {
        render view: 'panels/barcodeOfLifePanel', model: [boldCounts: metadataService.getBoldCounts()]
    }

    def bhlPanel = {
        render view: 'panels/bhlPanel', model: [bhlCounts: metadataService.getBHLCounts()]
    }

    def volunteerPortalPanel = {
        render view: 'panels/volunteerPortalPanel', model: [volunteerPortalCounts: metadataService.getVolunteerStats()]
    }

    def conservationStatusPanel = {
        render view: 'panels/conservationStatusPanel', model: [stateConservation: metadataService.getSpeciesByConservationStatus()]
    }

    def recordsByDataProviderPanel = {
        render view: 'panels/recordsByDataProviderPanel', model: [dataProviders: metadataService.getDataProviders()]
    }

    def recordsByInstitutionPanel = {
        render view: 'panels/recordsByInstitutionPanel', model: [institutions: metadataService.getInstitutions()]
    }

    def recordsByLifeFormPanel = {
        render view: 'panels/recordsByLifeFormPanel', model: [records: metadataService.getRecordsByLifeForm()]
    }

    def recordsAndSpeciesByDecadePanel = {
        render view: 'panels/recordsAndSpeciesByDecadePanel'
    }

    def occurrenceTreePanel = {
        render view: 'panels/occurrenceTreePanel'
    }

    def usageStatisticsPanel = {
        render view: 'panels/usageStatisticsPanel', model: [loggerTotals: metadataService.getLoggerTotals()]
    }

    def downloadsByReasonPanel = {
        render view: 'panels/downloadsByReasonPanel', model: [loggerReasonBreakdown: metadataService.getLoggerReasonBreakdown()]
    }

    def downloadsBySourcePanel = {
        render view: 'panels/downloadsBySourcePanel', model: [loggerSourceBreakdown: metadataService.getLoggerSourceBreakdown()]
    }

    def downloadsByUserTypePanel = {
        render view: 'panels/downloadsByUserTypePanel', model: [loggerEmailBreakdown: metadataService.getLoggerEmailBreakdown()]
    }

    def speciesImagesPanel = {
        render view: 'panels/speciesImagesPanel', model: [imagesBreakdown: metadataService.getImagesBreakdown()]
    }

    def mostRecorded(String group) {
        def facets = metadataService.getMostRecordedSpecies(group)
        render facets as JSON
    }
    
    /**
     * Do logouts through this app so we can invalidate the session.
     *
     * @param casUrl the url for logging out of cas
     * @param appUrl the url to redirect back to after the logout
     */
    def logout = {
        session.invalidate()
        redirect(url:"${params.casUrl}?url=${params.appUrl}")
    }

    def clearCache() {
        if (params.key) {
            cacheService.clear(params.key)
        }
        else {
            cacheService.clear()
        }
        render 'Done.'
    }

    /* ---------------------------- data services ---------------------------------*/

    def downloadAsCsv = {
        File dir = new File(grailsApplication.config.csv.temp.dir)
        if (!dir.exists()) {
            dir.mkdirs()
        } else {
            // remove old files from directory in case that the configuration of the panels to present has changed
            // otherwise the old files would be zipped too
            FileUtils.cleanDirectory(dir)
        }
        /* build files as csv */

        // by decade
        if(grailsApplication.config.getProperty("panels.recordsAndSpeciesByDecadePanel", Boolean, true))
            writeCsvFile('by-decade', metadataService.getSpeciesByDecade().collect {
                [it.decade, it.records, it.species] }, ['Decade','Records','Species'])

        // total + dups
        if(grailsApplication.config.getProperty("panels.recordsPanel", Boolean, true))
            writeCsvFile('total-records', metadataService.getTotalAndDuplicates().findAll({it.key != 'error'}), [])

        // basis of record
        if(grailsApplication.config.getProperty("panels.basisRecordsPanel", Boolean, true))
            writeCsvFile('basis-of-record', facetCount('basis_of_record'), ['basisOfRecord','number of records'])

        // records by state
        if(grailsApplication.config.getProperty("panels.statePanel", Boolean, true))
            recordsBy('state')

        // records by kingdom
        if(grailsApplication.config.getProperty("panels.occurrenceTreePanel", Boolean, true))
            recordsBy('kingdom')

        if(grailsApplication.config.getProperty("panels.conservationStatusPanel", Boolean, true))
            recordsBy('state_conservation')

        if(grailsApplication.config.getProperty("panels.recordsByLifeFormPanel", Boolean, true))
            recordsByOtherName('species_group','lifeform')

        // collections
        if(grailsApplication.config.getProperty("panels.collectionPanel", Boolean, true))
            writeCsvFile('collections', metadataService.getCollectionsByCategory(), ['category','number of collections per category'])

        // data providers
        if(grailsApplication.config.getProperty("panels.recordsByDataProviderPanel", Boolean, true))
            writeCsvFile('data-providers', metadataService.getDataProviders().collectEntries {[it.name, it.count]},
                ['data provider','number of records'])

        // spatial layers
        if(grailsApplication.config.getProperty("panels.spatialPanel", Boolean, true)) {
            def md = metadataService.getSpatialLayers()
            def spMap = [Total: md.total] + md.groups + md.classification
            writeCsvFile('spatial-layers', spMap, ['type', 'number'])
        }

        // datasets
        if(grailsApplication.config.getProperty("panels.datasetsPanel", Boolean, true)) {
            def ds = metadataService.getDatasets()
            def dsMap = [Total: ds.total] + ds.groups
            writeCsvFile('datasets', dsMap, ['type', 'number'])
        }

        // records by century

        if(grailsApplication.config.getProperty("panels.dateRecordsPanel", Boolean, true)) {
            def rc = metadataService.getDateStats()
            def rcList =
                    ['c1600', 'c1700', 'c1800', 'c1900', 'c2000'].collect { [it, rc[it]] }
            writeCsvFile('records-by-century', rcList, ['century', 'number'])
        }

        // records for types

        if(grailsApplication.config.getProperty("panels.typeSpecimensPanel", Boolean, true)) {
            def ty = metadataService.getTypeStats()
            def tyList = ty.collectEntries { k, v ->
                if (k == 'withImage') {
                    v.collectEntries { l, w -> [(l + ' (with image)'): w] }
                } else {
                    ["${k}": v]
                }
            }
            writeCsvFile('type-status', tyList, ['type status', 'number'])
        }

        // taxa counts
        if(grailsApplication.config.getProperty("panels.nslPanel", Boolean, true))
            writeCsvFile('names', metadataService.getTaxaCounts(), [])

        // bhl counts
        if(grailsApplication.config.getProperty("panels.bhlPanel", Boolean, true))
            writeCsvFile('biodiversity-heritage-library', metadataService.getBHLCounts(), [])

        // identify life counts
        // not shown in panels --> therefore also excluded!
        // writeCsvFile('identify-life', metadataService.getIdentifyLifeCounts(), [])

        // vp counts
        if(grailsApplication.config.getProperty("panels.volunteerPortalPanel", Boolean, true)) {

            writeCsvFile('biodiversity-volunteer-portal', metadataService.get('volunteerPortalCounts'), [])
        }
        /* zip files */
        new AntBuilder().zip(destfile: grailsApplication.config.zip.temp.dir+"dashboard.zip", basedir: grailsApplication.config.csv.temp.dir, includes: '**/*.csv')

        /* render zip */
        response.setHeader("Content-disposition", "attachment; filename=dashboard.zip");
        byte[] zip = new File(grailsApplication.config.zip.temp.dir+"dashboard.zip").bytes
        response.contentType = "application/zip"
        response.outputStream << zip
    }

    def writeCsvFile(filename, values, header) {
        File dir = new File(grailsApplication.config.csv.temp.dir)

        new File(dir.absolutePath + '/' + filename + '.csv').withWriter { out ->
            def csv = new CSVWriter(out/*, CSVWriter.DEFAULT_SEPARATOR, CSVWriter.NO_QUOTE_CHARACTER*/)
            if (header) { csv.writeNext(header as String[]) }
            if (values instanceof Map) {
                values.each { k,v ->
                    csv.writeNext([k,v] as String[])
                }
            }
            else if (values instanceof List) {
                values.each {
                    csv.writeNext(it as String[])
                }
            }
        }
    }

    def recordsByOtherName(String facet, String name) {
        def dashed = name.replaceAll('_','-')
        writeCsvFile('records-by-' + dashed, facetCount(facet), [dashed,'number of records'])
    }

    def recordsBy(String facet) {
        recordsByOtherName(facet, facet)
    }

    def most = { group ->
        def m = [:]
        metadataService.getMostRecordedSpecies(group)?.facets?.each() {
            m.put it.name, [count: it.count, common: it.common, lsid: it.facet]
        }
        m
    }

    def facetCount = { facet ->
        def r = [:]
        metadataService.getBiocacheFacet(facet).facets.each {
            r.put it.display, it.count
        }
        r
    }

    def data() {
        
        // build output
        def d = [:]

        if(grailsApplication.config.getProperty("panels.recordsPanel", Boolean, true))
            d.totalRecords = metadataService.getTotalAndDuplicates().findAll({it.key != 'error'})
        if(grailsApplication.config.getProperty("panels.basisRecordsPanel", Boolean, true))
            d.basisOfRecord = facetCount('basis_of_record')
        if(grailsApplication.config.getProperty("panels.collectionPanel", Boolean, true))
            d.collections = metadataService.getCollectionsByCategory()
        if(grailsApplication.config.getProperty("panels.datasetsPanel", Boolean, true))
            d.datasets = metadataService.getDatasets()
        if(grailsApplication.config.getProperty("panels.recordsByDataProviderPanel", Boolean, true))
            d.recordsByDataProvider = metadataService.getDataProviders().collectEntries {[it.display, it.count]}
        if(grailsApplication.config.getProperty("panels.recordsByInstitutionPanel", Boolean, true))
            d.recordsByInstitution = metadataService.getInstitutions().collectEntries {[it.display, it.count]}
        if(grailsApplication.config.getProperty("panels.dateRecordsPanel", Boolean, true))
            d.recordsByDate = metadataService.getDateStats()
        if(grailsApplication.config.getProperty("panels.statePanel", Boolean, true))
            d.recordsByState = facetCount('state')
        if(grailsApplication.config.getProperty("panels.occurrenceTreePanel", Boolean, true))
            d.recordsByKingdom = facetCount('kingdom')
        if(grailsApplication.config.getProperty("panels.conservationStatusPanel", Boolean, true))
            d.recordsByConservationStatus = facetCount('state_conservation')
        if(grailsApplication.config.getProperty("panels.recordsAndSpeciesByDecadePanel", Boolean, true))
            d.byDecade = metadataService.getSpeciesByDecade()
        if(grailsApplication.config.getProperty("panels.recordsByLifeFormPanel", Boolean, true))
            d.recordsByLifeform = facetCount('species_group')
        if(grailsApplication.config.getProperty("panels.spatialPanel", Boolean, true))
            d.spatialLayers = metadataService.getSpatialLayers()
        if(grailsApplication.config.getProperty("panels.typeSpecimensPanel", Boolean, true))
            d.typeCounts = metadataService.getTypeStats()
        if(grailsApplication.config.getProperty("panels.nslPanel", Boolean, true))
            d.taxaCounts = metadataService.getTaxaCounts()
        if(grailsApplication.config.getProperty("panels.bhlPanel", Boolean, true))
            d.bhlCounts = metadataService.getBHLCounts()
        if(grailsApplication.config.getProperty("panels.volunteerPortalPanel", Boolean, true))
            d.volunteerPortalCounts = metadataService.getVolunteerStats()
        if(grailsApplication.config.getProperty("panels.downloadsByReasonPanel", Boolean, true))
            d.occurrenceDownloadByReason = metadataService.getLoggerReasonBreakdown().collect {["Download Reason": it[0], "Events": it[1].trim(), "Records": it[2].trim()]}
        if(grailsApplication.config.getProperty("panels.mostRecordedSpeciesPanel", Boolean, true))
            ['All','Plants','Mammals','Reptiles','Birds','Animals','Arthropods', 'Fishes','Insects','Amphibians','Bacteria','Fungi'].each {
                d['mostRecorded' + it] = most(it)
            }

        render d as JSON
    }

    /**
     * JSON service to return combined set of data stats/metrics for display on the ALA homepage
     * Includes:
     *  - number of users (now and 1 year ago)
     *  - number of records (now and 1 year ago)
     *  - number of species (now and 1 year ago)
     *  - number of datasets (now and 1 year ago)
     *
     *  example output:
     *  {
     *    "userCounts": { "countNow": 1234, "count1YA": 1200 },
     *    "recordCounts": { "countNow": 123400, "count1YA": 120000 } ,
     *    "speciesCounts": { "countNow": 1234, "count1YA": 1200 }
     *  }
     *
     * @return
     */
    def homePageStats() {
        def combinedCounts = [
                userCounts: metadataService.getUserCounts(),
                recordCounts: metadataService.getRecordCounts(),
                speciesCounts:  metadataService.getSpeciesCounts(),
                datasetCounts: metadataService.getDatasetCounts(),
                downloadCounts: metadataService.getDownloadCounts()
        ]

        render combinedCounts as JSON
    }
    
    /* ---------------------------- test actions ---------------------------------*/
    def spatialLayers = {
        render metadataService.getSpatialLayers() as JSON
    }
    def datasets = {
        render metadataService.getDatasets() as JSON
    }

    def metadata = {
        def method = params.id
        def arg = params.arg
        if (arg) {
            render metadataService."$method"(arg) as JSON
        }
        else {
            render metadataService."$method"() as JSON
        }
    }
}
