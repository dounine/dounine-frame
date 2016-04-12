<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<div class="easyui-layout" id="main-layout" style="height: 100%;">

	<div data-options="region:'center',fit:true" style="height: 100%;">

		<div id="lox-tabs" data-options="fit:true">

			<shiro:hasPermission name="website:productFloor:*"><div title="楼层管理" lox-data-options="href:'${base}/admin/website/productFloor/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-article'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
		</div>

	</div>

</div>

<script type="text/javascript">
	if($("#lox-tabs div").length){
		(new EasyuiTabs()).init($('#lox-tabs'));
	}
</script>