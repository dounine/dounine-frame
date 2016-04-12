<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script src="${base}/resource/admin/js/object/admin/system/rbac/role/Role.js" type="text/javascript" charset="utf-8"></script>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<table style="height:100%;" id="system_user_role_treegrid"></table>

<div id="system_user_role_treegrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:rbac:role:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$Role.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:role:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="surtm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$Role.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:role:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="surtm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Role.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:role:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="surtm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$Role.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:role:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="surtm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$Role.thaw();">解冻</a></shiro:hasPermission>
	</span>
</div>

<div id="system_user_role_dialog" style="display:none;">
	<form id="system_user_role_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>角色名称:</td>
				<td>
					<input style="width: 134px;" name="roleName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="roleId" type="text" />
				</td>
				<td>角色描述:</td>
				<td>
					<input style="width: 134px;" name="roleDescription" type="text" class="easyui-textbox" />
				</td>
			</tr>
			<tr>
				<td>上级角色:</td>
				<td id="roleParentBox" colspan="3">
				</td>
			</tr>
			<tr>
				<td>角色权限:</td>
				<td id="rolePermissionsBox" colspan="3">
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_权限类型管理(){//命名规则  delete_(+)所在tab名称
		$('#system_user_role_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Role = new Role();
	$Role.treegrid = $("#system_user_role_treegrid");
	$Role.treegrid_menu = "#system_user_role_treegrid_menu";
	$Role.dialog = $("#system_user_role_dialog");
	$Role.type = $("input[class=form-for-data][id=roleTypeId]");
	$Role.form = $("#system_user_role_dialog_form");
	$Role.roleParent = "#roleParent";
	$Role.rolePermissions = "#rolePermissions";
	$Role.roleParentBox = $("#roleParentBox");
	$Role.rolePermissionsBox = $("#rolePermissionsBox");
	
	$Role.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/list.action" />'+_userUrl;
	$Role.permissionUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/list.action" />'+_userUrl;//用于查询role的权限层次
	$Role.findPermissionUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/find_by_role.action" />'+_userUrl;//用于查询role的权限层次
	$Role.rolePermissionUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/find.action" />'+_userUrl;//查找role的权限
	$Role.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/add.action" />'+_userUrl;//添加
	$Role.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/del.action" />'+_userUrl;//删除
	$Role.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/edit.action" />'+_userUrl;//编辑
	$Role.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/congeal.action" />'+_userUrl;//冻结
	$Role.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/thaw.action" />'+_userUrl;//解冻
	
	$Role.load(<shiro:hasPermission name="system:rbac:role:list">true</shiro:hasPermission>);//加载显示列表信息

</script>