<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/log/operation/Operation.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_log_operation_datagrid"></table>

<div id="system_log_operation_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:log:operation:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="slodm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Operation.del();">删除</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="system_log_operation_search_form" onsubmit="return false;">
			操作者: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="userName" style="width: 140px;"/>
			&nbsp;事务名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="story" style="width: 140px;"/>
			&nbsp;操作时间: <input type="text" class="easyui-datebox" editable="false" name="createTimeC" style="width: 140px;"/>
			<shiro:hasPermission name="system:log:operation:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$Operation.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<div id="system_log_operation_dialog" >
	<form id="system_log_operation_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>操作者:</td>
				<td>
					<input style="width: 134px;" editable="false" name="userName" type="text" class="easyui-textbox" required="required" />
				</td>
				<td>事务名称:</td>
				<td>
					<input style="width: 134px;" editable="false" name="story" type="text" class="easyui-textbox" />
				</td>
				<td>创建时间:</td>
				<td>
					<input style="width: 134px;" editable="false" name="createTimeC" type="text" class="easyui-textbox" />
				</td>
			</tr>
			<tr>
				<td>操作数据:</td>
				<td colspan="5">
					<textarea  disabled="disabled" style="width:100%;height:180px;" name="afterContent"></textarea>
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_操作日志(){//命名规则  delete_(+)所在tab名称
		$Operation.dialog.dialog('destroy');
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Operation = new Operation();
	$Operation.datagrid = $("#system_log_operation_datagrid");
	$Operation.datagrid_menu = "#system_log_operation_datagrid_menu";
	$Operation.searchForm = $("#system_log_operation_search_form");
	$Operation.dialog = $("#system_log_operation_dialog");
	$Operation.form = $("#system_log_operation_dialog_form");
	
	$Operation.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/log/operation/maps.action" />'+_userUrl;
	$Operation.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/log/operation/del.action" />'+_userUrl;//删除
	
	$Operation.load(<shiro:hasPermission name="system:log:operation:list">true</shiro:hasPermission>);//加载显示列表信息

</script>