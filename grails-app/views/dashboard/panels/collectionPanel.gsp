<div class="col-sm-4 col-md-4" id="collections-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title"><a href="${grailsApplication.config.collectory.baseURL}"><span class="count">${collections?.allCount}</span></a>
                ${message(code:'panels.collectionPanel.title', default:'Collections')}<i class="fa fa-info-circle pull-right hidden"></i></div>
        </div>
        <div class="panel-body text-center">
            <p class="paragraph">${message(code:'panels.collectionPanel.clickInfo', default:'Click on a Collection for details:')}</p>
            <div id="collectionsByCategory">
                %{--<asset:image src="spinner.gif"/>--}%
                <g:include controller="charts" action="collections"/>
            </div>
        </div>
    </div>
</div>