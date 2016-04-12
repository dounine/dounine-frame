<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/website/article/article/Article.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="website_article_datagrid"></table>

<div id="website_article_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="website:article:article:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$Article.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="website:article:article:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wadm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$Article.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="website:article:article:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wadm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$Article.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="website:article:article:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wadm-menu-congeal" data-options="iconCls:'icon-d-unsolve'" onclick="$Article.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="website:article:article:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wadm-menu-thaw" data-options="iconCls:'icon-d-solve'" onclick="$Article.thaw();">解冻</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="website_article_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="articleName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">解冻</option>
						<option value="CONGEAL">冻结</option>
					</select>
			<shiro:hasPermission name="website:article:article:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$Article.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<script type="text/javascript">
	function delete_文章管理(){//命名规则  delete_(+)所在tab名称
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $Article = new Article();
	$Article.datagrid = $("#website_article_datagrid");
	$Article.datagrid_menu = "#website_article_datagrid_menu";
	$Article.searchForm = $("#website_article_search_form");
	$Article.button;
	
	$Article.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/article/maps.action" />'+_userUrl;//列表
	$Article.addUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/article/add.action" />'+_userUrl;//添加
	$Article.editUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/article/edit.action" />'+_userUrl;//编辑
	$Article.delUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/article/del.action" />'+_userUrl;//删除
	$Article.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/article/congeal.action" />'+_userUrl;//未解决
	$Article.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/website/article/article/thaw.action" />'+_userUrl;//已解决
	
	$Article.load(<shiro:hasPermission name="website:article:article:list">true</shiro:hasPermission>);//加载显示列表信息

	var me_tab_children_url = '${base}/admin/website/article/article/info.html'+userUrl;
	
	$Article.show_editor = function(){
		var select_tab = $('#lox-tabs').tabs('getSelected');
		$(select_tab).attr("lox-data-options","href:'"+me_tab_children_url+"'").css('style','hidden');
		$('#lox-tabs').tabs('update',{
			tab:select_tab,
			title:'文章管理',
			options:{
				href:me_tab_children_url,
				method:'post'
			}
		});
	}
</script>