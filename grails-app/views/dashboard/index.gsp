<%@ page import="grails.converters.JSON" contentType="text/html;charset=UTF-8" %>
<%@page expressionCodec="none" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="ala-main"/>
    <meta name="breadcrumb" content="Dashboard"/>
    <title>Dashboard | ${grailsApplication.config.skin.orgNameLong}</title>
    <link href="${grailsApplication.config.skin?.favicon?:'https://www.ala.org.au/wp-content/themes/ala2011/images/favicon.ico'}" rel="shortcut icon" type="image/x-icon"/>
    <gvisualization:apiImport/>
    <asset:stylesheet src="dashboard.css" />

</head>

<div class="dashboard">
    <div id="pageHeader" class="row">
        <div id="pageHeaderLeft" class="col-sm-6 col-md-6">
            <ul class="breadcrumb hide">
                <li><a href="${grailsApplication.config.ala.baseURL ?: 'https://www.ala.org.au'}">Home</a></li>
                <li class="active">
                    Dashboard <i id="show-error-button" data-html="true" data-title="Panel errors" data-trigger="hover" data-content="" class="fa fa-times-circle fa-lg initiallyHidden link"></i>
                </li>
            </ul>
            <p><i class="fa fa-exclamation-circle fa-lg"></i> ${message(code:'basic.info.label', default:'You can rearrange topics by clicking on the panel headers and dragging them.')}</p>
        </div>
        <div id="buttonGroup" class="pull-right col-sm-6 col-md-6">
            <div id="headerButtons">
                <a class="btn btn-primary " id="resetLayout"><i class="fa fa-refresh fa-inverse"></i> ${message(code:'basic.reset.button', default:'Reset layout')}</a>
                <a class="btn btn-primary " id="downloadCsv"><i class="fa fa-download fa-inverse"></i> ${message(code:'basic.download.button', default:'Download as CSV')}</a>
                <a class="btn btn-primary " id="showJson"><i class="fa fa-code fa-inverse"></i> ${message(code:'basic.rawdata.button', default:'Show raw data')}</a>
            </div>
        </div>
    </div>
    <!-- style only temporary -->
    <style>
    .panel {
        border: 1px solid #dddddd;
    }
    </style>
    <div id="floatContainer">

    <g:if test="${grailsApplication.config.getProperty("panels.recordsPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="recordsPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.datasetsPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="datasetsPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.basisRecordsPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="basisRecordsPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.collectionPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="collectionPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.dateRecordsPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="dateRecordsPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.nslPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="nslPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.spatialPanel", Boolean, true)}" >
       <g:include controller="dashboard" action="spatialPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.statePanel", Boolean, true)}" >
       <g:include controller="dashboard" action="statePanel"/>
    </g:if>

        %{--    <g:include controller="dashboard" action="identifyLifePanel"/>--}%

    <g:if test="${grailsApplication.config.getProperty("panels.mostRecordedSpeciesPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="mostRecordedSpeciesPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.typeSpecimensPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="typeSpecimensPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.barcodeOfLifePanel", Boolean, true)}" >
        <g:include controller="dashboard" action="barcodeOfLifePanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.bhlPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="bhlPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.volunteerPortalPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="volunteerPortalPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.conservationStatusPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="conservationStatusPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.recordsByDataProviderPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="recordsByDataProviderPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.recordsByInstitutionPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="recordsByInstitutionPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.occurrenceTreePanel", Boolean, true)}" >
        <g:include controller="dashboard" action="occurrenceTreePanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.recordsByLifeFormPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="recordsByLifeFormPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.recordsAndSpeciesByDecadePanel", Boolean, true)}" >
        <g:include controller="dashboard" action="recordsAndSpeciesByDecadePanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.usageStatisticsPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="usageStatisticsPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.downloadsByReasonPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="downloadsByReasonPanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.downloadsBySourcePanel", Boolean, true)}" >
        <g:include controller="dashboard" action="downloadsBySourcePanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.downloadsByUserTypePanel", Boolean, true)}" >
        <g:include controller="dashboard" action="downloadsByUserTypePanel"/>
    </g:if>
    <g:if test="${grailsApplication.config.getProperty("panels.speciesImagesPanel", Boolean, true)}" >
        <g:include controller="dashboard" action="speciesImagesPanel"/>
    </g:if>

</div>
</div>

<asset:javascript src="application.js"/>

<asset:script type="text/javascript">

var GRAILS_CONFIG = {
      biocacheWebappUrl: "${grailsApplication.config.biocache.webappURL}",
      bieWebappUrl: "${grailsApplication.config.bieUI.baseURL}",
};

var alaWsUrls = {
collections: '${grailsApplication.config.collectory.baseURL}',
biocache: '${grailsApplication.config.biocache.baseURL}',
biocacheUI: '${grailsApplication.config.biocache.webappURL}',
bie: '${grailsApplication.config.bie.baseURL}',
bieUI: '${grailsApplication.config.bie.webappURL}',
app: '${request.contextPath}'
}

var collectionPanelTranslations = {
    tr_plants: '${message(code:"panels.collectionPanel.plants",default:"plants")}',
    tr_insects: '${message(code:"panels.collectionPanel.insects", default:"Insects")}',
    tr_otherFauna: '${message(code:"panels.collectionPanel.otherFauna", default:"Other fauna")}',
    tr_microbes: '${message(code:"panels.collectionPanel.microbes", default:"Microbes")}'
}
var moreLessTranslations = {
    tr_more: '${message(code:"panels.button.more",default:"More")}',
    tr_less: '${message(code:"panels.button.less",default:"Less")}',
}
var occurrenceTreePanelTranslations = {
    tr_kingdom: '${message(code:"panels.occurrenceTreePanel.node.kingdom",default:"Kingdom")}',
    tr_showRecords: '${message(code:"panels.occurrenceTreePanel.label.showRecords",default:"Show records")}',
    tr_showInformation: '${message(code:"panels.occurrenceTreePanel.label.showInformation",default:"Show information")}',
}

<g:applyCodec encodeAs="none">
var panelInfo = ${panelInfo?:'{}'};
</g:applyCodec>

$(function() {
dashboard.init({
    urls: alaWsUrls
});

$('#floatContainer > div > div.panel').matchHeight();
$.fn.matchHeight._maintainScroll = true;
});
</asset:script>
</body>
</html>
