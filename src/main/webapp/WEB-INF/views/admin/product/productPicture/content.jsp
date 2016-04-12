<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<script src="${base}/resource/admin/js/object/admin/product/productPicture/ProductPicture.js" type="text/javascript" charset="utf-8"></script>
<div class="easyui-layout" style="height:100%;border-top:none;">
	<div region='center' id="articleCenter" style="border-top:none;position:relative;">
		<div class="nav-settab">
			<span class="nav-tab-one"></span> 
			<span class="nav-tabs">
				<a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/product/content.html'+userUrl);">框架列表</a> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/product/info.html'+userUrl)" id="publish_frame_a">发布框架</a> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/productPicture/content.html'+userUrl)" class="nav-tabs-select">图片列表</a> | <a href="javascript:void(0);" onclick="return_tab('${base}/admin/product/productDetail/content.html'+userUrl)">详细信息</a> </span>
			<span class="nav-tab-two"></span>
		</div>
	
			<table class="easyui-grid">
				<tr>
					<td colspan="2" style="border-left:none;text-align:left;font-size:14px;border-top:none;height:30px;"><b>框架图片</b></td>
				</tr>
				<tr>
					<td style="border-left:none;text-align:left;" colspan="2">
						<div class="publish_c" style="width:98%;margin:auto;">
							<li>
								<img id="productPictureUrl" src="${base}/resource/admin/css/themes/icons/dounine-icon-picture.png"  width="80" height="80" />
								<form target="UpIframe_1" id="UpIframe_1_form_id" action="${base}/resource/admin/js/ueditor/jsp/controller.jsp?action=uploadimage&compression=true" enctype="multipart/form-data" method="post">
								 	<input id="UpIframe_1_value" style="margin:4px;float:left;" onclick="upIframeImgClick();" class="edui-image-file" type="file" name="图片上传" accept="image/jpeg,image/png,image/jpg,image/bmp" />
								 	<iframe name="UpIframe_1" style="display: none;" id="UpIframe_1_iframe_id"></iframe>
									<span id="nothis">
										<strong class="q"></strong>
										<strong class="w">提示：未选择上传的图片无法进行添加或编辑操作.</strong>
										<strong class="c"></strong>
									</span>
								</form>
							</li>
							<form id="product_productPicture_form" method="post">
							<li>
									<input name="id" type="hidden" id="id" value=""/>
									<input name="product.id" type="hidden" id="productId" value=""/>
									<input name="smallPath" type="hidden" id="smallPath_id" value=""/>
									<input name="middlePath" type="hidden" id="middlePath_id" value=""/>
									<input name="originalPath" type="hidden" id="originalPath_id" value=""/>
									<span style="float:left;">
										<input type="text" required="true" class="easyui-textbox" name="name" style="width:300px;" />
									</span>
									<span id="nothis">
										<strong class="q"></strong>
										<strong class="w">名称：鼠标滑过图片显示的提示.</strong>
										<strong class="c"></strong>
									</span>
							</li>
							<li>
								<span style="float:left;">
									<input type="text" required="true" data-options="min:0,value:0,editable:false" class="easyui-numberspinner" name="sequence" style="width:300px;" />
								</span>
								<span id="nothis">
									<strong class="q"></strong>
									<strong class="w">排序：值越高,排名显示越靠前,默认时间排序.</strong>
									<strong class="c"></strong>
								</span>
								<a href="javascript:void(0);" disabled="disabled" iconCls="icon-d-save" id="productPictureButton" onclick="$ProductPicture.save($Product);" style="float:right;" class="easyui-linkbutton">&nbsp;&nbsp;添&nbsp;&nbsp;加&nbsp;&nbsp;</a>
							</li>
							</form>
							<li>
								<table style="height:200px;width:99%;" id="product_productPicture_datagrid"></table>
							</li>
						</div>
					</td>
				</tr>
			</table>
	</div>
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
			$("#productPictureUrl").attr("src",base+json.url);
			$("#product_productPicture_form").form('load',{
				'smallPath':json.url_compression_small,
				'middlePath':json.url_compression_middle,
				'originalPath':json.url
			});
			$("#productPictureButton").linkbutton('enable');
			$("#UpIframe_1_form_id").form('clear');
		}
	});
	
});	
</script>	
<script>
	
	function return_tab(_tab_operator_url){
		var select_tab = $('#lox-tabs').tabs('getSelected');
		$(select_tab).attr("lox-data-options","href:'"+_tab_operator_url+"'").css('style','hidden');
		$('#lox-tabs').tabs('update',{
			tab:select_tab,
			options:{
				href:_tab_operator_url,
				method:'post'
			}
		});
	}
	
	$(function(){
		$("#productId").val($Product.row.id);
	});
	
	var $ProductPicture = new ProductPicture();
	$ProductPicture.datagrid = $("#product_productPicture_datagrid");
	$ProductPicture.form = $("#product_productPicture_form");
	
	$ProductPicture.loadUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productPicture/maps.action" />'+_userUrl+'&product.id='+$Product.row.id;
	$ProductPicture.addUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productPicture/add.action" />'+_userUrl;//添加
	$ProductPicture.delUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productPicture/del.action" />'+_userUrl;//删除
	$ProductPicture.editUrl = '<dounine-csrf:token-value uri="${base}/admin/product/productPicture/edit.action" />'+_userUrl;//编辑
	
	$ProductPicture.load(<shiro:hasPermission name="product:productPicture:list">true</shiro:hasPermission>);
</script>
