<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/bug/type/BugType.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_bugtype_datagrid"></table>

<div id="system_bugtype_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:bug:bugtype:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$BugType.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:bug:bugtype:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sbtdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$BugType.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:bug:bugtype:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sbtdm-menu-del" data-options="iconCls:'icon-d-del'" onclick="$BugType.del();">删除</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="system_bugtype_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="bugTypeName" style="width: 140px;"/>
			<shiro:hasPermission name="system:bug:bugtype:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$BugType.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<div id="system_bugtype_dialog" style="display:none;">
	<form id="system_bugtype_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>类型名称:</td>
				<td>
					<input style="width: 134px;" name="bugTypeName" type="text" class="easyui-textbox" iconCls="icon-d-name" required="required" />
					<input type="hidden" name="bugTypeId" type="text" />
				</td>
				<td>类型描述:</td>
				<td>
					<input style="width: 134px;" name="bugTypeDescription" type="text" class="easyui-textbox" iconCls="icon-d-description"/>
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_BUG类型管理(){//命名规则  delete_(+)所在tab名称
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $BugType = new BugType();
	$BugType.datagrid = $("#system_bugtype_datagrid");
	$BugType.datagrid_menu = "#system_bugtype_datagrid_menu";
	$BugType.searchForm = $("#system_bugtype_search_form");
	$BugType.dialog = $("#system_bugtype_dialog");
	$BugType.form = $("#system_bugtype_dialog_form");
	
	$BugType.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugType/maps.action" />'+_userUrl;//列表
	$BugType.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugType/add.action" />'+_userUrl;//添加
	$BugType.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugType/edit.action" />'+_userUrl;//编辑
	$BugType.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/bug/bugType/del.action" />'+_userUrl;//删除
	
	$BugType.load(<shiro:hasPermission name="system:bug:bugType:list">true</shiro:hasPermission>);//加载显示列表信息

</script>