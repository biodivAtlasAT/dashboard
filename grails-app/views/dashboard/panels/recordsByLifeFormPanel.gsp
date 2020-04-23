<div class="col-sm-4 col-md-4" id="lifeform-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">${message(code:'panels.recordsByLifeFormPanel.title', default:'Records by life form')}<i class="fa fa-info-circle pull-right hidden"></i></div>
        </div>
        <div class="panel-body">
            <table id="lifeformsTable-small" class="table table-condensed table-striped table-hover">
                <g:set var="rowsToDisplay" value="${5}"/>
                <g:each in="${0..rowsToDisplay}" var="index">
                    <tr class="link">
                        <td  i18n="${records[index + rowsToDisplay].i18nCode}" id="${records[index].label}">${message(code:'panels.recordsByLifeFormPanel.'+records[index].i18nCode, default:records[index].label)}</td>
                        <td class="numberColumn">${db.formatNumber(value: records[index].count)}</td>
                        <g:if test="${records[index + rowsToDisplay]}">
                            <td  i18n="${records[index + rowsToDisplay+1].i18nCode}" id="${records[index + rowsToDisplay+1].label}">${message(code:'panels.recordsByLifeFormPanel.'+records[(index + rowsToDisplay+1) as Integer].i18nCode, default:records[(index + rowsToDisplay+1) as Integer].label)}</td>
                            <td class="numberColumn">${db.formatNumber(value: records[(index + rowsToDisplay+1) as Integer].count)}</td>
                        </g:if>
                    </tr>
                </g:each>
            </table>
            <table id="lifeformsTable" class="table table-condensed table-striped table-hover" style="display: none;">
                <g:set var="halfCount" value="${(records.size()/2 as Float).trunc() as Integer}"/>
                <g:each in="${0..halfCount-1}" var="index">
                    <tr class="link">
                        <td i18n="${records[index].i18nCode}" id="${records[index].label}">${message(code:'panels.recordsByLifeFormPanel.'+records[index].i18nCode, default:records[index].label)}</td>
                        <td class="numberColumn">${db.formatNumber(value: records[index].count)}</td>
                        <g:if test="${records[index + halfCount]}">
                            <td i18n="${records[index + halfCount].i18nCode}" id="${records[index + halfCount].label}">${message(code:'panels.recordsByLifeFormPanel.'+records[(index + halfCount) as Integer].i18nCode, default:records[(index + halfCount) as Integer].label)}</td>
                            <td class="numberColumn">${db.formatNumber(value: records[(index + halfCount) as Integer].count)}</td>
                        </g:if>
                    </tr>
                </g:each>
            </table>
            <p class="paragraph"><a href="javascript:void(0);" id="showAllLifeforms" class="btn btn-default btn-small">${message(code:'panels.button.more', default:'More')}</a></p>
        </div>
    </div>
</div>