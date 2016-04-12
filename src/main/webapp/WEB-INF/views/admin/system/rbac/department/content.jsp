<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/rbac/department/Department.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_user_department_treegrid"></table>

<div id="system_user_department_treegrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:rbac:department:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$Department.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:department:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudtm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$Department.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:department:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudtm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Department.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:department:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudtm-menu-congeal" data-options="iconCls:'icon-d-congeal'" onclick="$Department.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="system:rbac:department:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="sudtm-menu-thaw" data-options="iconCls:'icon-d-thaw'" onclick="$Department.thaw();">解冻</a></shiro:hasPermission>
	</span>
</div>

<div id="system_user_department_dialog" style="display:none;">
	<form id="system_user_department_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>部门名称:</td>
				<td>
					<input data-options="maxLength:5"  style="width: 134px;" name="departmentName" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="departmentId" type="text" />
				</td>
				<td>部门描述:</td>
				<td>
					<input style="width: 134px;" name="departmentDescription" type="text" class="easyui-textbox" />
				</td>
			</tr>
			<tr>
				<td>上级部门:</td>
				<td id="departmentParentBox" colspan="3">
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_部门管理(){//命名规则  delete_(+)所在tab名称
		$('#system_user_department_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
		
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Department = new Department();
	$Department.treegrid = $("#system_user_department_treegrid");
	$Department.treegrid_menu = "#system_user_department_treegrid_menu";
	$Department.dialog = $("#system_user_department_dialog");
	$Department.form = $("#system_user_department_dialog_form");
	$Department.departmentParent = "#departmentParent";
	$Department.departmentParentBox = $("#departmentParentBox");
	
	$Department.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/list.action" />'+_userUrl;
	$Department.addUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/add.action" />'+_userUrl;//添加
	$Department.delUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/del.action" />'+_userUrl;//删除
	$Department.editUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/edit.action" />'+_userUrl;//编辑
	$Department.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/congeal.action" />'+_userUrl;//冻结
	$Department.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/system/rbac/department/thaw.action" />'+_userUrl;//解冻
	
	$Department.load(<shiro:hasPermission name="system:rbac:department:list">true</shiro:hasPermission>);//加载显示列表信息

</script>