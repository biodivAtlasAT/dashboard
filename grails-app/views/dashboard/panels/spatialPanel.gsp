<div class="col-sm-4 col-md-4" id="spatial-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">
                <a href="${grailsApplication.config.spatial.baseURL}/layers/index"><span class="count">${spatialLayers.total}</span>
                </a> ${message(code:'panels.spatialPanel.title', default:'Spatial layers')}
                <i class="fa fa-info-circle pull-right hidden"></i>
            </div>
        </div>

        <div class="panel-body">
            <table class="table table-condensed table-striped table-hover">
                <tr>
                    <td width="80%">${message(code:'panels.spatialPanel.contextualLayers', default:'Contextual layers')}</td>
                    <td class="numberColumn"><span class="count">${spatialLayers.groups.contextual}</span></td>
                </tr>
                <tr>
                    <td>${message(code:'panels.spatialPanel.environmentalLayers', default:'Environmental/grided layers')}</td>
                    <td class="numberColumn"><span class="count">${spatialLayers.groups.environmental}</span></td>
                </tr>
            </table>
            <table class="table table-condensed table-striped table-hover">
                <tr>
                    <td width="80%">${message(code:'panels.spatialPanel.terrestrialLayers', default:'Terrestrial layers')}</td>
                    <td class="numberColumn"><span class="count">${spatialLayers.groups.terrestrial}</span></td>
                </tr>
                <tr>
                    <td>${message(code:'panels.spatialPanel.marineLayers', default:'Marine layers')}</td>
                    <td class="numberColumn"><span class="count">${spatialLayers.groups.marine}</span></td>
                </tr>
            </table>

            <div id="moreSpatial" style="display:none;">
                <table class="table table-condensed table-striped table-hover">
                    <g:each in="${spatialLayers.classification}" var="c">
                        <tr><td>${c.key}</td><td class="numberColumn"><span class="count">${c.value}</span></td></tr>
                    </g:each>
                </table>
            </div>

            <p class="paragraph"><button id="moreSpatialLink" class="btn btn-default btn-small">${message(code:'panels.button.more', default:'More')}</button></p>
        </div>
    </div>
</div>
