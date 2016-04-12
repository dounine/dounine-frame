<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/system/keyboard/KeyBoard.js" type="text/javascript" charset="utf-8"></script>
<table style="height:100%;" id="system_keyboard_datagrid"></table>

<div id="system_keyboard_datagrid_menu" style="position: relative;height: 30px;vertical-align: middle;">
	<span style="position: absolute;left: 4px;">
		<shiro:hasPermission name="system:keyboard:add"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" data-options="iconCls:'icon-d-add'" onclick="$KeyBoard.add();">添加</a></shiro:hasPermission>
		<shiro:hasPermission name="system:keyboard:edit"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="skdm-menu-edit" data-options="iconCls:'icon-d-edit'" onclick="$KeyBoard.edit();">编辑</a></shiro:hasPermission>
		<shiro:hasPermission name="system:keyboard:del"><a href="javascript:void(0);" disabled="true" plain="true" class="easyui-linkbutton" id="skdm-menu-remove" data-options="iconCls:'icon-d-remove'" onclick="$KeyBoard.del();">删除</a></shiro:hasPermission>
	</span>
	<span style="position: absolute;right: 10px;">
		<form id="system_keyboard_search_form" onsubmit="return false;">
			名称: <input type="text" class="easyui-textbox" iconCls="icon-d-name" name="name" style="width: 140px;"/>
			<shiro:hasPermission name="system:cache:keyboard:search"><a href="javascript:void(0);" plain="true" class="easyui-linkbutton" onclick="$KeyBoard.search();" data-options="iconCls:'icon-d-search'">&nbsp;&nbsp;搜&nbsp;索&nbsp;</a></shiro:hasPermission>
		</form>
	</span>
</div>

<div id="system_keyboard_dialog" style="display:none;">
	<form id="system_keyboard_dialog_form" method="post">
		<table class="easyui-grid">
			<tr>
				<td>名称:</td>
				<td>
					<input style="width: 134px;" name="name" type="text" class="easyui-textbox" required="required" />
					<input type="hidden" name="keyBoardId" />
					<input type="hidden" name="userId" id="keyBoardUserId" />
				</td>
				<td>链接:</td>
				<td>
					<input style="width: 134px;" name="url" type="text" class="easyui-textbox" required="required" />
				</td>
			</tr>
			<tr>
				<td>图片:</td>
				<td>
					<input name="picture" type="hidden" id="keyBoardUrl" value=""/>
					<img id="dounineImgUp1" src="${base}/resource/admin/css/themes/icons/dounine-icon-picture.png"  width="32" height="32" />
 				</td>
				<td>描述:</td>
				<td>
					<input style="width: 134px;" name="description" type="text" class="easyui-textbox" />
				</td>
			</tr>
		</table>
	</form>
	<form class="image-file-upload-button-box" target="UpIframe_1" id="UpIframe_1_form_id" action="${base}/resource/admin/js/ueditor/jsp/controller.jsp?action=uploadimage&compression=true" enctype="multipart/form-data" method="post">
	 	<input id="UpIframe_1_value" onclick="upIframeImgClick();" class="image-file-upload-button" type="file" name="图片上传" accept="image/jpeg,image/png,image/jpg,image/bmp" />
	 	<iframe name="UpIframe_1" style="display: none;" id="UpIframe_1_iframe_id"></iframe>
	</form>
</div>
<script type="text/javascript">//图片
var UpIframe_1_interval = null;//表单定时器对象
var uploadInputValue = "#UpIframe_1_value";//图片上传文件的id
var upImgForm = "#UpIframe_1_form_id";//表彰上传的id
var upImgIframe = "#UpIframe_1_iframe_id";//图片上传框架的id
function upIframeImgClick(){
	clearInterval(UpIframe_1_interval);
	UpIframe_1_interval = setInterval(function(){
		if($(uploadInputValue).val().length>0){
			clearInterval(UpIframe_1_interval);
			$(upImgForm).submit();
		}
	},200);
}
$(function(){
	$(upImgIframe).load(function() {//判断图片是否上传并加载到本地完毕
		var r = this.contentWindow.document.body.innerHTML;
		if (r){
			var json = eval('(' + r + ')');
			clearInterval(UpIframe_1_interval);
			$("#dounineImgUp1").attr("src","${base}"+json.url);
			$("#keyBoardUrl").val(json.url);
		}
	});
	
});	
</script>
<script type="text/javascript">

	/** 命名规则 （模块名+功能名+easyui组件名） **/
	var $KeyBoard = new KeyBoard();
	$KeyBoard.datagrid = $("#system_keyboard_datagrid");
	$KeyBoard.datagrid_menu = "#system_keyboard_datagrid_menu";
	$KeyBoard.searchForm = $("#system_keyboard_search_form");
	$KeyBoard.dialog = $("#system_keyboard_dialog");
	$KeyBoard.form = $("#system_keyboard_dialog_form");
	
	$KeyBoard.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/index/keyboard/maps.action" />'+_userUrl;//列表
	$KeyBoard.addUrl = '<dounine-csrf:token-value uri="${base}/admin/index/keyboard/add.action" />'+_userUrl;//添加
	$KeyBoard.editUrl = '<dounine-csrf:token-value uri="${base}/admin/index/keyboard/edit.action" />'+_userUrl;//编辑
	$KeyBoard.delUrl = '<dounine-csrf:token-value uri="${base}/admin/index/keyboard/del.action" />'+_userUrl;//删除
	
	$KeyBoard.load(<shiro:hasPermission name="system:cache:keyboard:maps">true</shiro:hasPermission>);//加载显示列表信息
	
</script>