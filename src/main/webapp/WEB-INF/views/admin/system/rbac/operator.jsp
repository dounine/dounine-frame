<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="easyui-layout" id="main-layout" style="height: 100%;">

	<div data-options="region:'center',fit:true" style="height: 100%;">

		<div id="lox-tabs" data-options="fit:true">

			<shiro:hasPermission name="system:rbac:department:*"><div title="部门管理" lox-data-options="href:'${base}/admin/system/rbac/department/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-department'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="system:rbac:permissiontype:*"><div title="权限类型管理" lox-data-options="href:'${base}/admin/system/rbac/permissiontype/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-type'"  style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="system:rbac:permission:*"><div title="权限资源管理" lox-data-options="href:'${base}/admin/system/rbac/permission/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-permission'"   style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="system:rbac:role:*"><div title="角色管理" lox-data-options="href:'${base}/admin/system/rbac/role/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-role'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="system:rbac:user:*"><div title="用户管理" lox-data-options="href:'${base}/admin/system/rbac/user/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-user'"  style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>

		</div>

	</div>

</div>

<script type="text/javascript">
	if($("#lox-tabs div").length){
		(new EasyuiTabs()).init($('#lox-tabs'));
	}
</script>