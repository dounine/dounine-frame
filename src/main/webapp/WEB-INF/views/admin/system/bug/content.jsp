<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/bug/Bug.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_bug_datagrid"></table>

<div id="system_bug_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:bug:bugm:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$Bug.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:bug:bugm:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sbdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$Bug.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:bug:bugm:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sbdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Bug.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="system:bug:bugm:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sbdm-menu-congeal" data-options="iconCls:'icon-d-unsolve'" onclick="$Bug.congeal();">未解决</a></shiro:hasPermission>
		<shiro:hasPermission name="system:bug:bugm:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sbdm-menu-thaw" data-options="iconCls:'icon-d-solve'" onclick="$Bug.thaw();">已解决</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="system_bug_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="bugName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">已解决</option>
						<option value="CONGEAL">未解决</option>
					</select>
			<shiro:hasPermission name="system:bug:bugm:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$Bug.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<script type="text/javascript">
	function delete_BUG管理(){//命名规则  delete_(+)所在tab名称
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Bug = new Bug();
	$Bug.datagrid = $("#system_bug_datagrid");
	$Bug.datagrid_menu = "#system_bug_datagrid_menu";
	$Bug.searchForm = $("#system_bug_search_form");
	$Bug.button;
	
	$Bug.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/maps.action" />'+_userUrl;//列表
	$Bug.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/add.action" />'+_userUrl;//添加
	$Bug.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/edit.action" />'+_userUrl;//编辑
	$Bug.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/del.action" />'+_userUrl;//删除
	$Bug.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/congeal.action" />'+_userUrl;//未解决
	$Bug.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugm/thaw.action" />'+_userUrl;//已解决
	
	$Bug.load(<shiro:hasPermission name="system:bug:bugm:list">true</shiro:hasPermission>);//加载显示列表信息

	var me_tab_children_url = '${base}/admin/system/bug/bugm/info.html'+userUrl;
	
	$Bug.show_editor = function(){
		var select_tab = $('#lox-tabs').tabs('getSelected');
		$(select_tab).attr("lox-data-options","href:'"+me_tab_children_url+"'").css('style','hidden');
		$('#lox-tabs').tabs('update',{
			tab:select_tab,
			title:'BUG管理',
			options:{
				href:me_tab_children_url,
				method:'post'
			}
		});
	}
</script>