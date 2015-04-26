

<script type="text/javascript" charset="utf-8">
    var portal;
    var panels;
    $(function() {

        portal = $('#portal').portal({
            border : false,
            fit : true,
            onStateChange : function() {
                $.cookie('portal-state', getPortalState(), {
                    expires : 7
                });
            }
        });
        var state = $.cookie('portal-state');
        if (!state) {
            state = 'p1';/*冒号代表列，逗号代表行*/
        }
        addPanels(state);
        portal.portal('resize');

    });

    function getPanelOptions(id) {
        for ( var i = 0; i < panels.length; i++) {
            if (panels[i].id == id) {
                return panels[i];
            }
        }
        return undefined;
    }
    function getPortalState() {
        var aa=[];
        for(var columnIndex=0;columnIndex<2;columnIndex++) {
            var cc=[];
            var panels=portal.portal('getPanels',columnIndex);
            for(var i=0;i<panels.length;i++) {
                cc.push(panels[i].attr('id'));
            }
            aa.push(cc.join(','));
        }
        return aa.join(':');
    }
    function addPanels(portalState) {
        var columns = portalState.split(':');
        for (var columnIndex = 0; columnIndex < columns.length; columnIndex++) {
            var cc = columns[columnIndex].split(',');
            for (var j = 0; j < cc.length; j++) {
                var options = getPanelOptions(cc[j]);
                if (options) {
                    var p = $('<div/>').attr('id', options.id).appendTo('body');
                    p.panel(options);
                    portal.portal('add', {
                        panel : p,
                        columnIndex : columnIndex
                    });
                }
            }
        }
    }
</script>
<style type="text/css">
    img{
        width:100%;
        height:750px;
    }
</style>
<div id="portal" style="position:relative"><img src="${resource()}/images/myImages/backstage.jpg" alt=""></div>