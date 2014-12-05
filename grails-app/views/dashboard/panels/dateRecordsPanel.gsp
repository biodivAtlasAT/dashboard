<div class="span4" id="date-topic">
  <div class="panel">
    <div class="panel-heading">
      <div class="panel-title">Records by date<i class="fa fa-info-circle pull-right hidden"></i></div>
    </div>
    <div class="panel-body">
      <table class="table table-condensed table-striped table-hover">
        <!--<tr><td id="${dateStats.earliest.uuid}">Earliest record</td><td><span class="count">${dateStats.earliest.display}</span></td>-->
        <tr><td id="${dateStats.latest.uuid}">Latest record</td><td><span
                class="count">${dateStats.latest.display}</span></td>
        <tr><td id="${dateStats.latestImage.uuid}">Last image added</td><td><span
                class="count">${dateStats.latestImage.display}</span></td>
        <tr><td id="1600">1600s</td><td><span class="count"><db:formatNumber value="${dateStats.c1600}"/></span>
        </td>
        <tr><td id="1700">1700s</td><td><span class="count"><db:formatNumber value="${dateStats.c1700}"/></span>
        </td>
        <tr><td id="1800">1800s</td><td><span class="count"><db:formatNumber value="${dateStats.c1800}"/></span>
        </td>
        <tr><td id="1900">1900s</td><td><span class="count"><db:formatNumber value="${dateStats.c1900}"/></span>
        </td>
        <tr><td id="2000">2000s</td><td><span class="count"><db:formatNumber value="${dateStats.c2000}"/></span>
        </td>
      </table>
    </div>
  </div>
</div>