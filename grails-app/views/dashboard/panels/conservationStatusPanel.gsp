<div class="span4" id="conservation-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">Conservation status<i class="fa fa-info-circle pull-right hidden"></i></div>
        </div>
        <div class="panel-body">
            <table class="click-thru table table-condensed table-striped table-hover">
                <thead>
                <tr><th>Status</th><th># species</th></tr>
                </thead>
                <tbody>
                <g:each in="${stateConservation[0..Math.min(6, stateConservation.size() - 1)]}" var="b">
                    <tr>
                        <td id="sc-${b.status}">${b.status}</td>
                        <td><span class="count">${b.species}</span></td>
                    </tr>
                </g:each>
                </tbody>
                <g:if test="${stateConservation.size() > 7}">
                    <tbody id="moreConservation">
                    <g:each in="${stateConservation[7..-1]}" var="b">
                        <tr>
                            <td id="sc-${b.status}"><div style="display:none;">${b.status}</div></td>
                            <td><div style="display:none;"><span class="count">${b.species}</span></div></td>
                        </tr>
                    </g:each>
                    </tbody>
                </g:if>
            </table>
            <g:if test="${stateConservation.size() > 7}">
                <p style="padding-top: 2px;"><span id="moreConservationLink" class="link">more..</span></p>
            </g:if>
        </div>
    </div>
</div>