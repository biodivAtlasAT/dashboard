<div class="col-sm-4 col-md-4" id="event-summary-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">Usage statistics<i class="fa fa-info-circle pull-right hidden"></i></div>
        </div>
        <div class="panel-body">
            <div id="usageStats">
                <table class="table table-condensed table-striped table-hover">
                    <tbody>
                        <tr>
                            <td>Records downloaded</td>
                            <g:if test="${loggerTotals["1002"] != null}">
                                <td>${loggerTotals["1002"]["events"]} events</td>
                                <td>${loggerTotals["1002"]["records"]} records</td>
                            </g:if>
                            <g:else>
                                <td>Value not provided!</td>
                            </g:else>
                        </tr>
                        <tr></tr>
                        <tr>
                            <td>Records viewed</td>
                            <g:if test="${loggerTotals["1000"] != null}">
                                <td>${loggerTotals["1000"]["events"]} events</td>
                                <td>${loggerTotals["1000"]["records"]} records</td>
                            </g:if>
                            <g:else>
                                <td>Value not provided!</td>
                            </g:else>
                        </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>