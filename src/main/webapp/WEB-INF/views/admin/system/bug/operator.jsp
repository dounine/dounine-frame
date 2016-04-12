<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="easyui-layout" id="asdf" style="height: 100%;">

	<div data-options="region:'center',fit:true" style="height: 100%;">

		<div id="lox-tabs" data-options="fit:true">

			<shiro:hasPermission name="system:bug:bugm:*"><div title="BUG管理" lox-data-options="href:'${base}/admin/system/bug/bugm/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-login'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="system:bug:bugType:*"><div title="BUG类型管理" lox-data-options="href:'${base}/admin/system/bug/bugType/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-type'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
		</div>

	</div>

</div>
<script type="text/javascript">
	if($("#lox-tabs div").length){
		(new EasyuiTabs()).init($('#lox-tabs'));
	}
</script>

