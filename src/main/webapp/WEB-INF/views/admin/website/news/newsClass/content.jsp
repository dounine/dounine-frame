<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script src="${base}/resource/admin/js/object/admin/website/news/newsClass/NewsClass.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="website_news_newsClass_datagrid"></table>

<div id="website_news_newsClass_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="website:news:newsClass:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$NewsClass.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="website:news:newsClass:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wnncdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$NewsClass.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="website:news:newsClass:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="wnncdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$NewsClass.del();">删除</a></shiro:hasPermission>
	</span>
</div>

<div id="website_news_newsClass_dialog" style="display:none;">
	<form id="website_news_newsClass_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>版块标题:</td>
				<td>
					<input iconCls="icon-d-name" style="width: 200px;" name="title" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="id" type="text" />
				</td>
				<td>版块排序:</td>
				<td>
					<input style="width: 134px;" name="sequence" type="text" class="easyui-numberspinner" />
				</td>
			</tr>
			<tr>
				<td>是否显示分页:</td>
				<td>
					<img style="cursor:pointer;" onclick="showPaging_click_yes_no(this);" src="${base_url}/resource/admin/images/no.jpg" />
					<input name="showPaging" url="${base_url}" id="showPaging" type="hidden" value="false" />
				</td>
				<td>每页条数:</td>
				<td>
					<input data-options="min:0,value:0,editable:false" style="width: 134px;" id="pagingCount" name="pagingCount" type="text" class="easyui-numberspinner" />
				</td>
			</tr>
			<tr>
				<td>显示时间格式:</td>
				<td>
					<select class="easyui-combobox" required="true" name="timeType" editable="false" panelHeight="auto" style="width:200px;">    
						<option value="DATETIME">日期&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;例：04/08</option>    
						<option value="TIMESTAMP">日期+时间&nbsp;&nbsp;例：2015/04/08 23:23</option>    
						<option value="TIME">精确分数&nbsp;&nbsp;&nbsp;&nbsp;例：20分钟前</option>    
					</select>
				</td>
				<td>排序方式:</td>
				<td>
					<select class="easyui-combobox" required="true" name="sortType" editable="false" panelHeight="auto" style="width:136px;">    
						<option value="DAY">天</option>    
						<option value="WEEK">周</option>    
						<option value="MONTH">月</option>    
						<option value="SEASON">季</option>    
						<option value="YEAR">年</option>    
						<option value="SEQUENCE">序号</option>    
						<option value="ID">编号</option>    
						<option value="HITS">热度</option>    
						<option value="NAME">名称</option>    
						<option value="NONE">随机</option>    
					</select>
				</td>
			</tr>
			<tr>
				<td>版块描述:</td>
				<td>
					<input iconCls="icon-d-description" style="width: 200px;" name="description" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
</div>

<script type="text/javascript">
	function delete_版块管理(){//命名规则  delete_(+)所在tab名称
		$('#website_news_newsClass_dialog').dialog('destroy');//凡是easyui dialog,window,panel组件,必需调用其destroy销毁方法。
	}

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $NewsClass = new NewsClass();
	$NewsClass.datagrid = $("#website_news_newsClass_datagrid");
	$NewsClass.datagrid_menu = "#website_news_newsClass_datagrid_menu";
	$NewsClass.dialog = $("#website_news_newsClass_dialog");
	$NewsClass.form = $("#website_news_newsClass_dialog_form");
	
	$NewsClass.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/newsClass/list.action" />'+_userUrl;
	$NewsClass.addUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/newsClass/add.action" />'+_userUrl;//添加
	$NewsClass.delUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/newsClass/del.action" />'+_userUrl;//删除
	$NewsClass.editUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/newsClass/edit.action" />'+_userUrl;//编辑
	$NewsClass.congealUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/newsClass/congeal.action" />'+_userUrl;//冻结
	$NewsClass.thawUrl = '<dounine-csrf:token-value uri="${base}/admin/website/news/newsClass/thaw.action" />'+_userUrl;//解冻
	
	$NewsClass.load(<shiro:hasPermission name="website:news:newsClass:list">true</shiro:hasPermission>);//加载显示列表信息

	
	function showPaging_click_yes_no(self){
		var $self = $(self);
		var _input = $self.parent().find('input[name=showPaging]');
		if(_input.val()=='false'){
			_input.val('true');
			$self.attr('src','${base_url}/resource/admin/images/yes.jpg');
		}else{
			_input.val('false');
			$self.attr('src','${base_url}/resource/admin/images/no.jpg');
		}
	}
</script>