package au.org.ala.dashboard

class ChartsController {

    def MetadataService metadataService

    def collections() {
        Map collections = metadataService.getCollectionsByCategory()

        def columns = [['string', 'category'], ['number', 'collections']]
        def plants = message(code: "panels.collectionPanel.plants", default:"Plants")
        def insects = message(code: "panels.collectionPanel.insects", default:"Insects")
        def otherFauna = message(code: "panels.collectionPanel.otherFauna", default:"Other fauna")
        def microbes = message(code: "panels.collectionPanel.microbes", default:"Microbes")
        def data = [
                [plants, collections.plants],
                [insects, collections.insects],
                [otherFauna, collections.otherFauna],
                [microbes, collections.micro]
        ]
        [columns: columns, data: data]
    }

    def stateAndTerritoryRecords() {
        List stateAndTerritoryRecords = metadataService.getStateAndTerritoryRecords()
        def columns = [['string', 'state'], ['number', 'records']]
/*        def data = stateAndTerritoryRecords.collect { record ->
            [record.label, record.count]
        }*/
        def data = stateAndTerritoryRecords.collect { record ->
            [message(code:"panels.statePanel."+record.i18nCode, default:record.label) , record.count]
        }
        [columns: columns, data: data]
    }

    def recordsAndSpeciesByDecade = {
        List recordsAndSpeciesByDecade = metadataService.getSpeciesByDecade()
        def tr_Records = message(code:"panels.recordsAndSpeciesByDecadePanel.column.records", default:"Records")
        def tr_Species = message(code:"panels.recordsAndSpeciesByDecadePanel.column.species", default:"Species")
        def columns = [['string', 'Decade'], ['number', tr_Records], ['number', tr_Species]]
        def data =recordsAndSpeciesByDecade.collect {[it.decade, it.records, it.species]}

        [columns: columns, data: data]
    }
}
