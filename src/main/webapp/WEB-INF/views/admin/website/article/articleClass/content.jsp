<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script src="${base}/resource/admin/js/object/admin/website/article/articleClass/ArticleClass.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="website_article_articleClass_datagrid"></table>

<div id="website_article_articleClass_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="website:article:articleClass:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$ArticleClass.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="website:article:articleClass:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="waacdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$ArticleClass.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="website:article:articleClass:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="waacdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$ArticleClass.del();">删除</a></shiro:hasPermission>
	</span>
</div>

<div id="website_article_articleClass_dialog" style="display:none;">
	<form id="website_article_articleClass_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>分类名称:</td>
				<td>
					<input iconCls="icon-d-name" style="width: 134px;" name="name" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="id" type="text" />
				</td>
				<td>分类描述:</td>
				<td>
					<input iconCls="icon-d-description" style="width: 134px;" name="description" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_文章分类管理(){//命名规则  delete_(+)所在tab名称
		$('#website_article_articleClass_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $ArticleClass = new ArticleClass();
	$ArticleClass.datagrid = $("#website_article_articleClass_datagrid");
	$ArticleClass.datagrid_menu = "#website_article_articleClass_datagrid_menu";
	$ArticleClass.dialog = $("#website_article_articleClass_dialog");
	$ArticleClass.form = $("#website_article_articleClass_dialog_form");
	
	$ArticleClass.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/articleClass/list.action" />'+_userUrl;
	$ArticleClass.addUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/articleClass/add.action" />'+_userUrl;//添加
	$ArticleClass.delUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/articleClass/del.action" />'+_userUrl;//删除
	$ArticleClass.editUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/articleClass/edit.action" />'+_userUrl;//编辑
	$ArticleClass.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/articleClass/congeal.action" />'+_userUrl;//冻结
	$ArticleClass.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/articleClass/thaw.action" />'+_userUrl;//解冻
	
	$ArticleClass.load(<shiro:hasPermission name="website:article:articleClass:list">true</shiro:hasPermission>);//加载显示列表信息

</script>