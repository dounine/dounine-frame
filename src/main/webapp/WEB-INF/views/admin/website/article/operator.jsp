<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="easyui-layout" id="main-layout" style="height: 100%;">

	<div data-options="region:'center',fit:true" style="height: 100%;">

		<div id="lox-tabs" data-options="fit:true">

			<shiro:hasPermission name="website:article:article:*"><div title="文章管理" lox-data-options="href:'${base}/admin/website/article/article/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-article'" style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
			<shiro:hasPermission name="website:article:articleClass:*"><div title="文章分类管理" lox-data-options="href:'${base}/admin/website/article/articleClass/content.html?USERNAME=<shiro:principal/>'" data-options="iconCls:'icon-d-type'"  style="height: 100%;overflow: hidden;"></div></shiro:hasPermission>
			
		</div>

	</div>

</div>

<script type="text/javascript">
	if($("#lox-tabs div").length){
		(new EasyuiTabs()).init($('#lox-tabs'));
	}
</script>