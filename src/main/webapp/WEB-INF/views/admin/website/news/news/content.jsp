<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/website/news/news/News.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="website_news_datagrid"></table>

<div id="website_news_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="website:news:news:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$News.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="website:news:news:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wndm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$News.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="website:news:news:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wndm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$News.del();">删除</a></shiro:hasPermission>
		<shiro:hasPermission name="website:news:news:congeal"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wndm-menu-congeal" data-options="iconCls:'icon-d-unsolve'" onclick="$News.congeal();">冻结</a></shiro:hasPermission>
		<shiro:hasPermission name="website:news:news:thaw"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wndm-menu-thaw" data-options="iconCls:'icon-d-solve'" onclick="$News.thaw();">解冻</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="website_news_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="newsName" style="width: 140px;"/>
			&nbsp;状态: <select name="status" editable="false" class="easyui-combobox" panelHeight="auto" style="width: 100px;">
						<option value="">请选择</option>
						<option value="NORMAL">解冻</option>
						<option value="CONGEAL">冻结</option>
					</select>
			<shiro:hasPermission name="website:news:news:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$News.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<script type="text/javascript">
	function delete_新闻管理(){//命名规则  delete_(+)所在tab名称
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $News = new News();
	$News.datagrid = $("#website_news_datagrid");
	$News.datagrid_menu = "#website_news_datagrid_menu";
	$News.searchForm = $("#website_news_search_form");
	$News.button;
	
	$News.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/maps.action" />'+_userUrl;//列表
	$News.addUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/add.action" />'+_userUrl;//添加
	$News.editUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/edit.action" />'+_userUrl;//编辑
	$News.delUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/del.action" />'+_userUrl;//删除
	$News.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/congeal.action" />'+_userUrl;//未解决
	$News.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/news/thaw.action" />'+_userUrl;//已解决
	
	$News.load(<shiro:hasPermission name="website:news:news:list">true</shiro:hasPermission>);//加载显示列表信息

	var me_tab_children_url = '${base}/admin/website/news/news/info.html'+userUrl;
	
	$News.show_editor = function(){
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