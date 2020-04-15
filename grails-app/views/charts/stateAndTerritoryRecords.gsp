<div id="stateAndTerritoryRecords-chart"></div>
<g:if test="${!data}">
    <asset:image src="spinner.gif" />
</g:if>
<gvisualization:pieCoreChart
        name="stateAndTerritoryRecords"
        dynamicLoading="${true}"
        elementId="stateAndTerritoryRecords-chart"
        title=""
        columns="${columns}"
        data="${data}"
        is3D="${true}"
        chartArea="${[width: '100%', height: '100%']}"
        legend="${[textStyle: [fontSize: '12']]}"
        pieSliceTextStyle="${[fontSize: '12']}"
        select="function() {dashboard.charts.state.showState(stateAndTerritoryRecords, stateAndTerritoryRecords_data)}"
        onmouseover="function() { jQuery('#stateAndTerritoryRecords-chart').css('cursor','pointer')}"
        backgroundColor="${[fill: 'transparent']}"/>