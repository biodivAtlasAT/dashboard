/************************************************************\
 * Go to occurrence records for selected node
 \************************************************************/
function showRecords(node, query) {
    var rank = node.attr('rank');
    if (rank == 'kingdoms') return;
    var name = node.attr('id');
    // url for records list
    var recordsUrl = urlConcat(GRAILS_CONFIG.biocacheWebappUrl, "/occurrences/search?q=") + query +
        "&fq=" + rank + ":\"" + name + "\"";
    document.location.href = recordsUrl;
}
/************************************************************\
 * Go to 'species' page for selected node
 \************************************************************/
function showBie(node) {
    var rank = node.attr('rank');
    if (rank == 'kingdoms') return;
    var name = node.attr('id');
    var sppUrl = GRAILS_CONFIG.bieWebappUrl + "/species/" + name;
    //var sppUrl = GRAILS_CONFIG.bieWebappUrl + "/search?q=" + name;
    //if (rank != 'species') { sppUrl += "_(" + rank + ")"; }
    document.location.href = sppUrl;
}
/*------------------------- TAXON TREE -----------------------------*/
/************************************************************\
 * Concatenate url fragments handling stray slashes
 \************************************************************/
function urlConcat(base, context) {
    // remove any trailing slash from base
    base = base.replace(/\/$/, '');
    // remove any leading slash from context
    context = context.replace(/^\//, '');
    // join
    return base + "/" + context;
}

/**
 * Extracted from charts2.js in the ala-charts plugin for modification
 * @param treeOptions
 */
function initTaxonTree(treeOptions) {
    var query = treeOptions.query ? treeOptions.query : buildQueryString(treeOptions.instanceUid);
    var targetDivId = treeOptions.targetDivId ? treeOptions.targetDivId : 'tree';
    var $container = $('#' + targetDivId);
    var title = treeOptions.title || 'Explore records by taxonomy';
    if (treeOptions.title !== "") {
        $container.append($('<h4>' + title + '</h4>'));
    }
    var $treeContainer = $('<div id="treeContainer"></div>').appendTo($container);
    $treeContainer.resizable({
        maxHeight: treeOptions.maxHeight ? treeOptions.maxHeight : 900,
        minHeight: treeOptions.minHeight ? treeOptions.minHeight : 100,
        maxWidth: treeOptions.maxWidth ? treeOptions.maxWidth : 900,
        minWidth: treeOptions.minWidth ? treeOptions.minWidth : 340
    });
    var $tree = $('<div id="taxaTree"></div>').appendTo($treeContainer);
    var tr_kingdom = occurrenceTreePanelTranslations.tr_kingdom;
    var tr_showRecords = occurrenceTreePanelTranslations.tr_showRecords;
    var tr_showInformation = occurrenceTreePanelTranslations.tr_showInformation;
    $tree
        .bind("after_open.jstree", function(event, data) {
            var children = $.jstree._reference(data.rslt.obj)._get_children(data.rslt.obj);
            // automatically open if only one child node
            if (children.length == 1) {
                $tree.jstree("open_node",children[0]);
            }
            // adjust container size
            var fullHeight = $tree[0].scrollHeight;
            jQuery.fn.matchHeight._update();
            if (fullHeight > $tree.height()) {
                fullHeight = Math.min(fullHeight, 700);
                $treeContainer.animate({height:fullHeight});
            }
        })
        .bind("select_node.jstree", function (event, data) {
            // click will show the context menu
            if (data.rslt.obj.attr('rank') != "kingdoms")
                $tree.jstree("show_contextmenu", data.rslt.obj);
        })
        .bind("loaded.jstree", function (event, data) {
            // get rid of the anchor click handler because it hides the context menu (which we are 'binding' to click)
            //$tree.undelegate("a", "click.jstree");
            $tree.jstree("open_node","#top");
        })
        .jstree({
            json_data: {
                data: {"data":tr_kingdom, "state":"closed", "attr":{"rank":"kingdoms", "id":"top"}},
                ajax: {
                    url: function(node) {
                        var rank = $(node).attr("rank");
                        var u = urlConcat(treeOptions.biocacheServicesUrl, "/breakdown.json?q=") + query + "&rank=";
                        if (rank == 'kingdoms') {
                            u += 'kingdom';  // starting node
                        }
                        else {
                            u += rank + "&name=" + $(node).attr('id');
                        }
                        return u;
                    },
                    dataType: 'jsonp',
                    success: function(data) {
                        var nodes = [];
                        var rank = data.rank;
                        $.each(data.taxa, function(i, obj) {
                            // RW: Workaround for non-specified taxa
                            if(obj.label != "") {
                                var label = obj.label + " - " + obj.count;
                                if (rank == 'species') {
                                    nodes.push({"data": label, "attr": {"rank": rank, "id": obj.label}});
                                } else {
                                    nodes.push({
                                        "data": label,
                                        "state": "closed",
                                        "attr": {"rank": rank, "id": obj.label}
                                    });
                                }
                            }
                        });
                        return nodes;
                    },
                    error: function(xhr, text_status) {
                        //alert(text_status);
                    }
                }
            },
            core: { animation: 200, open_parents: true },
            themes:{
                theme: treeOptions.theme || 'default',
                icons: treeOptions.icons || false,
                url: treeOptions.serverUrl + "/assets/themes/" + (treeOptions.theme || 'default') + "/style.css"
                //url: treeOptions.serverUrl + "/js/themes/" + (treeOptions.theme || 'default') + "/style.css"
            },
            checkbox: {override_ui:true},
            contextmenu: {
                select_node: false, show_at_node: false, items: function ($node) {
                    myDisabled = false;
                    if($node.attr('rank') == "kingdom")
                        myDisabled = true;
                    return {
                        "records": {label: tr_showRecords, action: function(obj) {showRecords(obj, query);}},
                        "bie": {_disabled: myDisabled, label: tr_showInformation, action: function(obj) {showBie(obj);}},
                    };
                },
            },

            plugins: ['json_data','themes','ui','contextmenu']
        });
}

