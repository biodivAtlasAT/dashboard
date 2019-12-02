<div class="col-sm-4 col-md-4" id="conservation-topic">
    <div class="panel">
        <div class="panel-heading">
            <div class="panel-title">${message(code:'panels.conservationStatusPanel.title', default:'Conservation status')}<i class="fa fa-info-circle pull-right hidden"></i></div>
        </div>
        <div class="panel-body">
            <table class="click-thru table table-condensed table-striped table-hover">
                <thead>
                <tr><th>Status</th><th class="numberColumn">${message(code:'panels.conservationStatusPanel.amountSpecies', default:'# species')}</th></tr>
                </thead>
                <tbody>
                <g:each in="${stateConservation[0..(stateConservation.size() - 1)]}" var="b">
                    <tr>
                        <td id="sc-${b.status}">${message(code:"panels.conservationStatusPanel."+b.status.toLowerCase().replace(' ','').replace('/','').replace('(','').replace(')',''), default:b.status)}</td>
                        <td class="numberColumn"><span class="count">${g.formatNumber(number:  b.species, type: 'number')}</span></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>