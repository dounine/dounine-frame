<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/rbac/permission/type/PermissionType.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_user_permission_type_treegrid"></table>

<div id="system_user_permission_type_treegrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:rbac:permissiontype:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$PermissionType.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permissiontype:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="supttm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$PermissionType.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permissiontype:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="supttm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$PermissionType.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permissiontype:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="supttm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$PermissionType.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permissiontype:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="supttm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$PermissionType.thaw();">解冻</a></shiro:hasPermission>
	</span>
</div>

<div id="system_user_permission_type_dialog" style="display:none;">
	<form id="system_user_permission_type_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>权限类型名称:</td>
				<td>
					<input style="width: 134px;" name="permissionTypeName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="permissionTypeId" type="text" />
				</td>
				<td>权限类型描述:</td>
				<td>
					<input style="width: 134px;" name="permissionTypeDescription" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_权限类型管理(){//命名规则  delete_(+)所在tab名称
		$('#system_user_permission_type_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $PermissionType = new PermissionType();
	$PermissionType.datagrid = $("#system_user_permission_type_treegrid");
	$PermissionType.datagrid_menu = "#system_user_permission_type_treegrid_menu";
	$PermissionType.dialog = $("#system_user_permission_type_dialog");
	$PermissionType.form = $("#system_user_permission_type_dialog_form");
	
	$PermissionType.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permissiontype/list.action" />'+_userUrl;
	$PermissionType.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permissiontype/add.action" />'+_userUrl;//添加
	$PermissionType.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permissiontype/del.action" />'+_userUrl;//删除
	$PermissionType.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permissiontype/edit.action" />'+_userUrl;//编辑
	$PermissionType.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permissiontype/congeal.action" />'+_userUrl;//冻结
	$PermissionType.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permissiontype/thaw.action" />'+_userUrl;//解冻
	
	$PermissionType.load(<shiro:hasPermission name="system:rbac:permissiontype:list">true</shiro:hasPermission>);//加载显示列表信息

</script>