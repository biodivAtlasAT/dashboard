<div class="col-sm-4 col-md-4" id="datasets-topic_tmp">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">
                <a href="${grailsApplication.config.collectory.baseURL}/datasets"><span class="count">${g.formatNumber(number:datasets.total,format:'###,##0')}</span></a>
                ${message(code:'panels.datasetsPanel.title', default:'Data sets')}
                <i class="fa fa-info-circle pull-right hidden"></i>
            </div>
        </div>
        <div class="panel-body">
            <table class="table table-condensed table-striped table-hover">
                <tr class="link">
                    <td id="partners">
                        <a href="${grailsApplication.config.collectory.baseURL}">${message(code:'panels.datasetsPanel.partners', default:'Partner')}</a>
                    </td>
                    <td class="numberColumn">
                        <span class="count">
                            <a href="${grailsApplication.config.collectory.baseURL}"><db:formatNumber value="${datasets.partnerCount}"/></a>
                        </span>
                    </td>
                </tr>
                <tr class="link">
                    <td id="records">${message(code:'panels.datasetsPanel.dataResources', default:'Data Resources')}</td>
                    <td class="numberColumn"><span class="count"><db:formatNumber
                            value="${datasets.groups?.records}"/></span>
                    </td>
                </tr>
                <tr class="link">
                    <td class="text-indent" id="dataAvailable">&#8226; ${message(code:'panels.datasetsPanel.dataAvailable', default:'Data Available')}</td>
                    <td class="numberColumn"><span class="count"><db:formatNumber
                            value="${datasets.dataAvailableCount}"/></span>
                    </td>
                </tr>
                <tr class="link">
                    <td class="text-indent" id="description">&#8226; ${message(code:'panels.datasetsPanel.descriptionOnly', default:'Description only')}</td>
                    <td class="numberColumn"><span class="count"><db:formatNumber
                            value="${datasets.descriptionOnlyCount}"/></span>
                    </td>
                </tr>
               <tr class="link">
                   <td id="species-list"><a href="${grailsApplication.config.lists.baseURL}/public/speciesLists">${message(code:'panels.datasetsPanel.speciesListsSets', default:'Species List sets')}</a></td>
                    <td class="numberColumn"><a href="${grailsApplication.config.lists.baseURL}/public/speciesLists"><span class="count"><db:formatNumber
                            value="${datasets.listsCount}"/></span></a>
                    </td>
               </tr>
                <g:each in="${datasets.listTypesMap}"  var="entry">
                    <tr class="link">
                        <td class="text-indent" id="listTypes">&#8226; <a href="${grailsApplication.config.lists.baseURL}/public/speciesLists?&controller=public&action=speciesLists&max=25&sort=listName&order=asc&listType=eq:${entry.key}">${message(code:'panels.datasetsPanel.listType.'+entry.key, default:entry.key)}</a></td>
                        <td class="numberColumn">
                            <a href="${grailsApplication.config.lists.baseURL}/public/speciesLists?&controller=public&action=speciesLists&max=25&sort=listName&order=asc&listType=eq:${entry.key}"><span class="count"><db:formatNumber value="${entry.value}"/></span></a>
                        </td>
                    </tr>
                </g:each>



               <g:if test="${datasets.groups.document}">
                    <tr class="link">
                        <td id="document">${message(code:'panels.datasetsPanel.documentSets', default:'Document sets')}</td>
                        <td class="numberColumn"><span class="count"><db:formatNumber
                                value="${datasets.groups.document}"/></span>
                        </td>
                    </tr>
                </g:if>
                <g:if test="${datasets.groups.website}">
                    <tr class="link">
                       <td id="website">${message(code:'panels.datasetsPanel.harvestedWebsites', default:'Harvested websites')}</td>
                       <td class="numberColumn">
                           <span class="count"><db:formatNumber
                                   value="${datasets.groups.website}"/></span>
                       </td>
                    </tr>
                </g:if>
                <g:if test="${datasets.groups.uploads}">
                    <tr class="link">
                        <td id="uploads">${message(code:'panels.datasetsPanel.uploadedRecordSets', default:'Uploaded record sets')}</td>
                        <td class="numberColumn"><span class="count"><db:formatNumber
                                value="${datasets.groups.uploads}"/></span>
                        </td>
                    </tr>
                </g:if>
            </table>

            <p class="paragraph">
                ${message(code:'panels.datasetsPanel.mostRecentlyadded', default:'Most recently added dataset is:')}<br/>
            </p>
            <div class="text-center">
                <a href="${grailsApplication.config.collectory.baseURL}/public/show/${datasets.last.uid}">
                    <h4>"<em><db:shorten text="${datasets.last.name}" size="66"/></em>"</h4>
                </a>
            </div>

        </div>
    </div>
</div>
