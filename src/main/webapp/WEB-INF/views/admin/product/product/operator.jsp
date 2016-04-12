<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="easyui-layout" id="main-layout" style="height: 100%;">

	<div data-options="region:'center',fit:true" style="height: 100%;">

		<div id="lox-tabs" data-options="fit:true">

			<shiro:hasPermission name="product:product:*"><div title="框架管理" lox-data-options="href:'${base}/admin/product/product/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-article'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="product:productClass:*"><div title="框架分类管理" lox-data-options="href:'${base}/admin/product/productClass/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-class'"  style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="product:productClass:*"><div title="框架导航管理" lox-data-options="href:'${base}/admin/product/productNav/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-nav'"  style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
		</div>

	</div>

</div>

<script type="text/javascript">
	if($("#lox-tabs div").length){
		(new EasyuiTabs()).init($('#lox-tabs'));
	}
</script>