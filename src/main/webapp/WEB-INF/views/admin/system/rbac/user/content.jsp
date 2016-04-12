<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/rbac/user/User.js" type="text/javascript" charset="utf-8"></script>

<div class="easyui-layout" style="height:100%;">
	<div title="&nbsp;部门组织机构" data-options="region:'west',width:240,iconCls:'icon-d-department',border:false" style="border-right:1px solid #D4D4D4;border-left:1px solid #D4D4D4">
		<table id="departmentParentSearch" style="width:230px;margin:0 4px 4px 4px;"></table>
	</div>
	<div data-options="region:'center',border:false">
		<table style="height:100%;" id="system_user_datagrid"></table>
	</div>
</div>


<div id="system_user_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
			<shiro:hasPermission name="system:rbac:user:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$User.add();">添加</a></shiro:hasPermission>
			<shiro:hasPermission name="system:rbac:user:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$User.edit();">编辑</a></shiro:hasPermission>
			<shiro:hasPermission name="system:rbac:user:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$User.del();">删除</a></shiro:hasPermission>
			<shiro:hasPermission name="system:rbac:user:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$User.congeal();">冻结</a></shiro:hasPermission>
			<shiro:hasPermission name="system:rbac:user:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$User.thaw();">解冻</a></shiro:hasPermission>
			<shiro:hasPermission name="system:rbac:user:export"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" id="sudm-menu-thaw" data-options="iconCls:'icon-d-export'" onclick="$User.export_excel('<dounine-csrf:token-value uri='${base}/admin/system/rbac/user/export.action' />');">导出</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="system_rbac_user_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="userName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">正常</option>
						<option value="CONGEAL">冻结</option>
					</select>
			<shiro:hasPermission name="system:rbac:user:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$User.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<div id="system_user_dialog" style="display:none;">
	<form id="system_user_dialog_form" method="post">
		
		<table class="easyui-grid">
			<tr>
				<td>用户名称:</td>
				<td>
					<input editable="false" style="width: 134px;" name="userName" id="userName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="userId" type="text" />
				</td>
				<td>用户密码:</td>
				<td>
					<input style="width: 134px;" required="true" name="userPassword" id="userPassword" type="password" class="easyui-textbox" />
				</td>
			</tr>
			<tr>
				<td>所属部门:</td>
				<td id="departmentBox" colspan="3">
				</td>
			</tr>
			<tr>
				<td>拥有角色:</td>
				<td id="userRolesBox" colspan="3">
				</td>
			</tr>
		</table>
	</form>
</div>

<div id="system_user_export_dialog" title="&nbsp;导出用户数据" class="easyui-dialog" data-options="closed:true,buttons:'#system_user_export_dialog_buttons',width:500">
	<form id="system_user_dialog_export_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>用户数据总条数:</td>
				<td colspan="3">
					<input style="width: 370px;" id="userCount" type="text" class="easyui-numberbox" required="required" />
				</td>
			</tr>
			<tr>
				<td>数据启始位置:</td>
				<td>
					<input style="width: 134px;" editable="false" name="offSet" id="userOffset" type="text" />
				</td>
				<td>导出数据条数:</td>
				<td>
					<input style="width: 134px;" editable="false" name="rows" id="exportCount" type="text" />
				</td>
			</tr>
		</table>
	</form>
</div>
<div id="system_user_export_dialog_buttons">
	<a class="easyui-linkbutton" data-options="iconCls:'icon-d-save'" onclick="$User.saveExport($User.exportUrl);" href="javascript:void(0);">提交</a>
	<a class="easyui-linkbutton" data-options="iconCls:'icon-d-close'" onclick="$User.closeExport();" href="javascript:void(0);">取消</a>
</div>

<script type="text/javascript">
	function delete_用户管理(){//命名规则  delete_(+)所在tab名称
		$('#system_user_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
		$('#system_user_export_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $User = new User();
	$User.datagrid = $("#system_user_datagrid");
	$User.datagrid_menu = "#system_user_datagrid_menu";
	$User.dialog = $("#system_user_dialog");
	$User.searchForm = $("#system_rbac_user_search_form");
	$User.form = $("#system_user_dialog_form");
	$User.department = "#department";
	$User.userRoles = "#userRoles";
	$User.userRolesBox = $("#userRolesBox");
	$User.departmentBox = $("#departmentBox");
	$User.searchName = $('input[id=scheduleJob_GroupName][name=scheduleJobGroupName]');
	$User.searchScheduleJob_GroupStatus = $('select[id=scheduleJob_GroupStatus][name=scheduleJobGroupStatus]');
	$User.dialog_buttons_addedit = $('#quartz_schedulejob_group_dialog_buttons_addedit');
	$User.userRolesBox = $("#userRolesBox");
	$User.userPassword = $("#userPassword");
	$User.departmentTree = $("#departmentParentSearch");
	$User.count = $("#userCount");
	
	
	$User.userCount = $("#userCount");
	$User.exportCount = $("#exportCount");
	$User.userOffset = $("#userOffset");
	
	$User.exportDialog = $("#system_user_export_dialog");
	$User.exportDialogForm = $("#system_user_dialog_export_form");
	
	
	$User.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/maps.action" />'+_userUrl;
	$User.exportUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/export.action" />'+_userUrl;
	
	$User.roleUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/list.action" />'+_userUrl;//用于查询role的权限层次
	$User.userRoleUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/find.action" />'+_userUrl;//用于查询user的角色
	$User.findRolesUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/role/find_by_role.action" />'+_userUrl;//用于查询role的权限层次
	$User.findDepartmentUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/find_by_user.action" />'+_userUrl;//用于查询用户所以部门（层次深所用）
	$User.departmentUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/list.action" />'+_userUrl;//用户添加加载部门用
	$User.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/add.action" />'+_userUrl;//添加
	$User.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/del.action" />'+_userUrl;//删除
	$User.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/edit.action" />'+_userUrl;//编辑
	$User.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/congeal.action" />'+_userUrl;//冻结
	$User.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/thaw.action" />'+_userUrl;//解冻
	$User.countUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/count.action" />'+_userUrl;//总数
	
	$User.searchDepartmentUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/list.action" />'+_userUrl;
	
	$User.load(<shiro:hasPermission name="system:rbac:user:list">true</shiro:hasPermission>);//加载显示列表信息

</script>