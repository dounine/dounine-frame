<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script src="${base}/resource/admin/js/object/admin/system/rbac/permission/Permission.js" type="text/javascript" charset="utf-8"></script>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<table style="height:100%;" id="system_user_permission_treegrid"></table>

<div id="system_user_permission_treegrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:rbac:permission:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$Permission.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permission:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="suptm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$Permission.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permission:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="suptm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Permission.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permission:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="suptm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$Permission.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:permission:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="suptm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$Permission.thaw();">解冻</a></shiro:hasPermission>
	</span>
</div>

<div id="system_user_permission_dialog" style="display:none;">
	<form id="system_user_permission_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>权限名称:</td>
				<td>
					<input style="width: 134px;" name="permissionName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="permissionId" type="text" />
				</td>
				<td>权限类型:</td>
				<td>
					<input style="width: 134px;" name="permissionType.permissionTypeId" class="form-for-data" id="permissionTypeId" type="text" />
				</td>
			</tr>
			<tr>
				<td>权限资源:</td>
				<td>
					<input style="width: 134px;" name="permissionResource" id="permissionResource" type="text" class="easyui-textbox" required="required" />
				</td>
				<td>权限描述:</td>
				<td>
					<input style="width: 134px;" name="permissionDescription" type="text" class="easyui-textbox" />
				</td>
			</tr>
			<tr>
				<td>上级权限:</td>
				<td id="permissionParentBox" colspan="3">
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_权限类型管理(){//命名规则  delete_(+)所在tab名称
		$('#system_user_permission_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Permission = new Permission();
	$Permission.treegrid = $("#system_user_permission_treegrid");
	$Permission.treegrid_menu = "#system_user_permission_treegrid_menu";
	$Permission.dialog = $("#system_user_permission_dialog");
	$Permission.type = $("input[class=form-for-data][id=permissionTypeId]");
	$Permission.form = $("#system_user_permission_dialog_form");
	$Permission.permissionParent = "#permissionParent";
	$Permission.permissionParentBox = $("#permissionParentBox");
	$Permission.permissionResource = $("#permissionResource");
	
	$Permission.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/list.action" />'+_userUrl;
	$Permission.typeUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permissiontype/all.action" />'+_userUrl;
	$Permission.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/add.action" />'+_userUrl;//添加
	$Permission.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/del.action" />'+_userUrl;//删除
	$Permission.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/edit.action" />'+_userUrl;//编辑
	$Permission.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/congeal.action" />'+_userUrl;//冻结
	$Permission.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/permission/thaw.action" />'+_userUrl;//解冻
	
	$Permission.load(<shiro:hasPermission name="system:rbac:permission:list">true</shiro:hasPermission>);//加载显示列表信息

</script>