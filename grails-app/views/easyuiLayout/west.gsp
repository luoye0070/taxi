<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" charset="utf-8">
    var tree;
    var menuPanel;
    $(function() {
        menuPanel = $('#menuPanel').panel({
            tools : [ {
                iconCls : 'icon-reload',
                handler : function() {
                    tree.tree('reload');
                }
            }, {
                iconCls : 'icon-redo',
                handler : function() {
                    var node = tree.tree('getSelected');
                    if (node) {
                        tree.tree('expandAll', node.target);
                    } else {
                        tree.tree('expandAll');
                    }
                }
            }, {
                iconCls : 'icon-undo',
                handler : function() {
                    var node = tree.tree('getSelected');
                    if (node) {
                        tree.tree('collapseAll', node.target);
                    } else {
                        tree.tree('collapseAll');
                    }
                }
            } ]
        });

        tree = $('#menu').tree({
            url:"${resource()}/easyuiLayout/ctrltree",
            lines : true,
            onClick : function(node) {
                if (node.state == 'closed') {
                    $(this).tree('expand', node.target);
                    attUrl(node.attributes)
                } else {
                    $(this).tree('collapse', node.target);
                }

                if(node.attributes)
                {
                    console.info(node)
                    addTab(node);
                }
            },
            onDblClick : function(node) {
                if (node.state == 'closed') {
                    $(this).tree('expand', node.target);
                } else {
                    $(this).tree('collapse', node.target);
                }
            }
        });
    });
</script>

<style type="text/css">
#menu{
    padding:0px;
    margin:0px;
}
</style>



<div class="easyui-accordion" fit="true" border="false">
    <div title="菜单">
        <div id="menuPanel" fit="true" border="false" title="功能菜单" style="padding: 0px;margin: 0px;">
            <ul id="menu"></ul>
        </div>
    </div>
    <div title="其他示例"></div>
</div>