<div class="col-sm-6 col-md-6" id="reason-breakdown-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">${message(code:'panels.downloadsByReasonPanel.title', default:'Occurrence downloads by reason')}<i class="fa fa-info-circle pull-right hidden"></i></div>
        </div>
        <div class="panel-body">
            <div id="reasonBreakdown">
                <table id="loggerReasonBreakdownTable" class="table table-condensed table-striped table-hover">
                    <g:each in="${loggerReasonBreakdown}" var="r" status="rIdx">
                        <tr id="loggerReasonBreakdown-${r[0] == 'TOTAL' ? 'TOTAL' : rIdx}"
                            class="${rIdx >= 6 && r[0] != 'TOTAL' ? 'hideableRow' : ''} ${r[0] == 'TOTAL' ? 'total-highlight' : ''}">
                            <td>${message(code:'panels.downloadsByReasonPanel.'+r[0], default:''+r[0])}</td>
                            <td class="numberColumn">${r[1]} ${message(code:'panels.downloadsByReasonPanel.column.events', default:'events')}</td>
                            <td class="numberColumn">${r[2]} ${message(code:'panels.downloadsByReasonPanel.column.records', default:'records')}</td>
                        </tr>
                    </g:each>
                </table>

                <p class="paragraph"><a href="javascript:void(0);" id="showAllLoggerReasons" class="btn btn-default btn-small">${message(code:'panels.button.more', default:'More')}</a></p>
            </div>
        </div>
    </div>
</div>