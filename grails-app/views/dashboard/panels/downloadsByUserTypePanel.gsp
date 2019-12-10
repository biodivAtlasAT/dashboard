<div class="col-sm-4 col-md-4" id="email-breakdown-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">${message(code:'panels.downloadsByUserTypePanel.title', default:'Occurrence downloads by user type')}<i class="fa fa-info-circle pull-right hidden"></i></div>
        </div>
        <div class="panel-body">
            <div id="emailBreakdown">
                <table class="table table-condensed table-striped table-hover">
                    <tr><td>${message(code:'panels.downloadsByUserTypePanel.item.edu', default:'Education')}</td><td>${loggerEmailBreakdown?.edu?.events} ${message(code:'panels.downloadsByUserTypePanel.column.events', default:'events')}</td><td>${loggerEmailBreakdown?.edu?.records} ${message(code:'panels.downloadsByUserTypePanel.column.records', default:'records')}</td></tr>
                    <tr><td>${message(code:'panels.downloadsByUserTypePanel.item.gov', default:'Government')}</td><td>${loggerEmailBreakdown?.gov?.events} ${message(code:'panels.downloadsByUserTypePanel.column.events', default:'events')}</td><td>${loggerEmailBreakdown?.gov?.records} ${message(code:'panels.downloadsByUserTypePanel.column.records', default:'records')}</td></tr>
                    <tr><td>${message(code:'panels.downloadsByUserTypePanel.item.other', default:'Other')}</td><td>${loggerEmailBreakdown?.other?.events} ${message(code:'panels.downloadsByUserTypePanel.column.events', default:'events')}</td><td>${loggerEmailBreakdown?.other?.records} ${message(code:'panels.downloadsByUserTypePanel.column.records', default:'records')}</td></tr>
                    <tr><td>${message(code:'panels.downloadsByUserTypePanel.item.unspecified', default:'Unspecified')}</td><td>${loggerEmailBreakdown?.unspecified?.events} ${message(code:'panels.downloadsByUserTypePanel.column.events', default:'events')}</td><td>${loggerEmailBreakdown?.unspecified?.records} ${message(code:'panels.downloadsByUserTypePanel.column.records', default:'records')}</td></tr>
                    <tr><td>TOTAL</td><td>${loggerEmailBreakdown?.total?.events} ${message(code:'panels.downloadsByUserTypePanel.column.events', default:'events')}</td><td>${loggerEmailBreakdown?.total?.records} ${message(code:'panels.downloadsByUserTypePanel.column.records', default:'records')}</td></tr>
                </table>
            </div>
        </div>
    </div>
</div>