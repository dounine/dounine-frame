<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="easyui-layout" id="asdf" style="height: 100%;">

	<div data-options="region:'center',fit:true" style="height: 100%;">

		<div id="lox-tabs" data-options="fit:true">

			<shiro:hasPermission name="system:quartz:schedulejob:*"><div title="定时器列表" lox-data-options="href:'${base}/admin/system/quartz/schedulejob/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-type'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="system:quartz:schedulejobgroup:*"><div title="定时器类型" lox-data-options="href:'${base}/admin/system/quartz/schedulejobgroup/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-time'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>

		</div>

	</div>

</div>
<script type="text/javascript">
	if($("#lox-tabs div").length){
		(new EasyuiTabs()).init($('#lox-tabs'));
	}
</script>

