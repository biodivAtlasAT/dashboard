<div class="col-sm-4 col-md-4" id="date-topic">
  <div class="panel">
    <div class="panel-heading">
      <div class="panel-title">${message(code:'panels.dateRecordsPanel.title', default:'Records by date')}<i class="fa fa-info-circle pull-right hidden"></i></div>
    </div>
    <div class="panel-body">
      <table class="table table-condensed table-striped table-hover link">
        <!--<tr><td id="${dateStats?.earliest?.uuid}">Earliest record</td><td><span class="count">${dateStats?.earliest?.display}</span></td>-->
        <tr><td id="${dateStats?.latest?.uuid}">${message(code:'panels.dateRecordsPanel.latestRecord', default:'Latest record')}</td>
          <td class="numberColumn"><span
                  class="count">${dateStats?.latest?.display}</span></td></tr>
        <g:if test="${dateStats.latestImage.uuid != '-1'}">
          <tr><td id="${dateStats?.latestImage?.uuid}">${message(code:'panels.dateRecordsPanel.lastImage', default:'Last image added')}</td>
            <td class="numberColumn"><span
                    class="count">${dateStats?.latestImage?.display}</span></td></tr>
        </g:if>
        <tr><td id="1600">${message(code:'panels.dateRecordsPanel._1600', default:'1600s')}</td><td class="numberColumn"><span class="count"><db:formatNumber value="${dateStats?.c1600}"/></span>
        </td></tr>
        <tr><td id="1700">${message(code:'panels.dateRecordsPanel._1700', default:'1700s')}</td><td class="numberColumn"><span class="count"><db:formatNumber value="${dateStats?.c1700}"/></span>
        </td></tr>
        <tr><td id="1800">${message(code:'panels.dateRecordsPanel._1800', default:'1800s')}</td><td class="numberColumn"><span class="count"><db:formatNumber value="${dateStats?.c1800}"/></span>
        </td></tr>
        <tr><td id="1900">${message(code:'panels.dateRecordsPanel._1900', default:'1900s')}</td><td class="numberColumn"><span class="count"><db:formatNumber value="${dateStats?.c1900}"/></span>
        </td></tr>
        <tr><td id="2000">${message(code:'panels.dateRecordsPanel._2000', default:'2000s')}</td><td class="numberColumn"><span class="count"><db:formatNumber value="${dateStats?.c2000}"/></span>
        </td></tr>
      </table>
    </div>
  </div>
</div>