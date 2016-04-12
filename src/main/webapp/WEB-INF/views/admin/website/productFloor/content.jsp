<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<link rel="stylesheet" type="text/css" href="${base_url}/resource/admin/css/floor/index.css"/>
<script src="${base_url}/resource/admin/js/jscolor/jscolor.js" type="text/javascript"></script>
<div class="easyui-layout" style="height:100%;">
	<div data-options="region:'north',height:40">
		<a href="javascript:void(0);" style="margin-top:4px;" class="easyui-linkbutton" onclick="create_floor();">创建楼层</a>
	</div>
	<div data-options="region:'center'" style="position:relative;">
		<div id="product-floor">
			<div class="floors"></div>
		</div>
		
		<div id="floor-cell-dialog" title="图片信息" class="easyui-dialog" data-options="width:700,closed:true,buttons:'#floor-cell-dialog-buttons'">
			<form onsubmit="return false;" method="post">
				<table class="easyui-grid not-b">
					<tr>
						<td>图片/颜色 :</td>
						<td>
							<input type="hidden" name="productFloor.floor_id" />
							<img style="cursor:pointer;" onclick="cell_picture_or_color_click_yes_no(this);" src="${base_url}/resource/admin/images/no.jpg" />
							<input name="cell_picture_or_color" type="hidden" value="false" />
						</td>
						<td>背景颜色:</td>
						<td>
							<input name="cell_bg_color" class="dounine-color" />
						</td>
					</tr>
					<tr>
						<td>文字垂直显示:</td>
						<td>
							<img style="cursor:pointer;" onclick="cell_vertical_click_yes_no(this);" src="${base_url}/resource/admin/images/no.jpg" />
							<input name="cell_vertical" value="false" type="hidden" />
						</td>
						<td>链接地址:</td>
						<td>
							<input name="cell_url" value="" class="easyui-textbox" />
						</td>
					</tr>
					<tr>
						<td>标题文字:</td>
						<td>
							<input name="cell_text" value="" class="easyui-textbox" />
						</td>
						<td>css样式:</td>
						<td>
							<input name="cell_css_style" value="" class="easyui-textbox" />
						</td>
					</tr>
					<tr>
						<td>背景图片地址 :</td>
						<td>
							<input type="hidden" name="cell_row_count" />
							<input type="hidden" name="cell_column_count" />
							<input type="hidden" name="cell_row_index" />
							<input type="hidden" name="cell_column_index" />
							<input type="hidden" name="productFloor.floor_id" />
							<input type="hidden" name="cell_id" />
							<input name="cell_picture" id="cell_picture" value="" class="easyui-textbox" />
						</td>
						<td>图片预览 :</td>
						<td>
							<img id="productPictureUrl" src="${base}/resource/admin/css/themes/icons/dounine-icon-picture.png"  width="80" height="80" />
						</td>
					</tr>
				</table>
			</form>
			<form target="UpIframe_1" id="UpIframe_1_form_id" action="${base}/resource/admin/js/ueditor/jsp/controller.jsp?action=uploadimage&compression=true" enctype="multipart/form-data" method="post">
				<input id="UpIframe_1_value" style="margin:10px;float:left;" onclick="upIframeImgClick();" class="edui-image-file" type="file" name="图片上传" accept="image/jpeg,image/png,image/jpg,image/bmp" />
				<iframe name="UpIframe_1" style="display: none;" id="UpIframe_1_iframe_id"></iframe>
				<span id="nothis" style="margin:6px;">
					<strong class="q"></strong>
					<strong class="w">提示：背景图片地址可以手填,也可上传.</strong>
					<strong class="c"></strong>
				</span>
			</form>
			
		</div>
		<div id="floor-cell-dialog-buttons">
			<a href="javascript:void(0);" iconCls="icon-d-save" onclick="save_floor_cell();" class="easyui-linkbutton">保存</a>
			<a href="javascript:void(0);" iconCls="icon-d-close" onclick="cancel_floor_cell();" class="easyui-linkbutton">取消</a>
		</div>
		
		<div title="楼层信息" id="floor-info-dialog" iconCls="icon-d-info" class="easyui-dialog" data-options="width:700,closed:true,buttons:'#floor-info-dialog-buttons'">
			<form onsubmit="return false;" method="post">
				<table class="easyui-grid">
					<tr>
						<td>楼层名称 :</td>
						<td>
							<input type="hidden" name="floor_id" />
							<input required="true" name="floor_name" value="" class="easyui-textbox" />
						</td>
						<td>是否显示 :</td>
						<td>
							<img style="cursor:pointer;" id="show_floor_is" onclick="isShowFloor(this);" src="${base_url}/resource/admin/images/yes.jpg" />
							<input type="hidden" name="status" value="NORMAL" />
						</td>
					</tr>
					<tr>
						<td>楼层单元格高度:</td>
						<td>
							<input name="floor_cell_width" required="true" value="100" class="easyui-numberspinner"/>
						</td>
						<td>楼层单元格宽度:</td>
						<td>
							<input name="floor_cell_height" required="true" value="100" class="easyui-numberspinner" />
						</td>
					</tr>
					<tr>
						<td>楼层列数:</td>
						<td>
							<input name="floor_column_count" id="floor_column_count" value="10" class="easyui-numberspinner" />
						</td>
						<td>楼层行数 :</td>
						<td>
							<input name="floor_row_count" id="floor_row_count" value="3" class="easyui-numberspinner" />
						</td>
					</tr>
					<tr>
						<td>排序:</td>
						<td>
							<input name="sequence" value="0" class="easyui-numberspinner" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="floor-info-dialog-buttons">
			<a href="javascript:void(0);" iconCls="icon-d-save" onclick="save_floor_info();" class="easyui-linkbutton">保存</a>
			<a href="javascript:void(0);" iconCls="icon-d-close" onclick="$('#floor-info-dialog').dialog('close');" class="easyui-linkbutton">取消</a>
		</div>
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
			$("#cell_picture").textbox('setValue',json.url);
			$("#UpIframe_1_form_id").form('clear');
		}
	});
	
});	
</script>
<script type="text/javascript">

function delete_楼层管理(){//命名规则  delete_(+)所在tab名称
	$("#floor-info-dialog").dialog('destroy');
	$("#floor-cell-dialog").dialog('destroy');
}

	var floor_add_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/add.action" />'+_userUrl;
	var floor_edit_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/edit.action" />'+_userUrl;
	var floor_all_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/all.action" />'+_userUrl;
	var floor_del_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/del.action" />'+_userUrl;
	var floor_add_row_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/add_row.action" />'+_userUrl;
	var floor_add_column_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/add_column.action" />'+_userUrl;
	var floor_clear_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/clear.action" />'+_userUrl;
	var floor_del_row_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/del_row.action" />'+_userUrl;
	var floor_del_column_action = '<dounine-csrf:token-value uri="${base}/admin/website/productFloor/del_column.action" />'+_userUrl;
	
	var floor_cell_all_action = '<dounine-csrf:token-value uri="${base}/admin/website/floorCell/all.action" />'+_userUrl;
	var floor_cell_add_action = '<dounine-csrf:token-value uri="${base}/admin/website/floorCell/add.action" />'+_userUrl;
	var floor_cell_edit_action = '<dounine-csrf:token-value uri="${base}/admin/website/floorCell/edit.action" />'+_userUrl;
	var floor_cell_del_action = '<dounine-csrf:token-value uri="${base}/admin/website/floorCell/del.action" />'+_userUrl;
	

	var $floors = null,$floors_list=null,$floor_cell_width=100,$floor_cell_height=100,$floor_init_row=3,$floor_init_cell=10,$floor_click_cells=[],$floor_click_index=null,$floor_cell_operator_div_width=40,$floor_cell_operator_div_height=24;
	
	var content_html = '<div class="floor-list"><div class="floor-info"><div class="floor-info-title"><a href="javascript:void(0);" style="cursor: default;">%{floor_name}</a></div><div class="floor-info-menu"><ul><li><a href="javascript:void(0);" onclick="create_floor_row(this.parentElement.parentElement.parentElement.parentElement.parentElement);">新增一行</a></li><li><a href="javascript:void(0);" onclick="create_floor_columns(this.parentElement.parentElement.parentElement.parentElement.parentElement);">新增一列</a></li><li><a href="javascript:void(0);" onclick="clean_floor_datas(this);">清空楼层</a></li><li><a href="javascript:void(0);" onclick="delete_floor(this);">删除楼层</a></li><li><a href="javascript:void(0);" onclick="edit_floor(this);">修改楼层</a></li></ul></div><div class="floor-info-form" style="display: none;"><form onsubmit="return false"><input type="hidden" name="floor_id" /><input type="hidden" name="floor_name" /><input type="hidden" name="status" /><input type="hidden" name="sequence" /><input type="hidden" name="floor_cell_width" /><input type="hidden" name="floor_cell_height" /><input type="hidden" name="floor_column_count" /><input type="hidden" name="floor_row_count" /></form></div></div><div class="floor-not-allowed" style="cursor: not-allowed;z-index: 5;" onclick="floor_not_allowed_click(this);"></div><div class="floor-click-operator" style="z-index:10;"><a href="javascript:void(0);" onclick="floor_click_operator_edit(null,this);">编辑</a><a href="javascript:void(0);" onclick="floor_click_operator_cancel(this);">取消</a></div><div class="floor-img-click-operator"><a href="javascript:void(0);" onclick="floor_img_edit_operator(this);">编辑</a><a href="javascript:void(0);" onclick="floor_img_del_operator(this);">删除</a><a href="javascript:void(0);" onclick="floor_img_cancel_operator(this);">取消</a></div><div class="floor-row-operator"><a href="javascript:void(0);" onclick="floor_row_or_col_click(this);">删除</a></div><div class="floor-content-values" style="left:%{floor-content-values-left}px;"></div><div class="floor-locked-button" style="z-index: 10;"><a href="javascript:void(0);" onclick="floor_locked_click(this);" class="floor-locked">点击解锁</a><input type="hidden" name="floor-locked" id="floor-locked" value="true" /></div><div class="floor-column"><ul><li style="width:%{floor-cell-width}px;"></li></ul></div><div class="floor-row"><ul></ul></div><div class="floor-content" style="left:%{floor-content-left}px;"><ul style="top:0px;height:%{floor-content-ul-height}px;"></ul></div></div>';
	
	var floor_button_status = 'create';
	
	$floors = $("div.floors");
	
	$(function(){
		inits_floors();
	});
	
	function inits_floors(){
		$('div.floors').empty();
		$("#lox-tabs").mask({'maskMsg':'楼层加载中...'});
		$.post(floor_all_action,function(data){
			var list = data;
			for(var ii in list){
				var $item = list[ii];
				
				var _data = content_html.format({
					"floor_name":$item.floor_name,
					"floor-cell-width":$item.floor_cell_width,
					"floor-content-left":$item.floor_cell_width,
					"floor-content-values-left":$item.floor_cell_width,
					"floor-content-ul-height":$item.floor_cell_height
				});
				
				var $floor = $(_data).appendTo($floors);
				var $ul = $floor.find('div.floor-column ul');
				var $ul_lis = $ul.find('li');
				var $content = $floor.find('div.floor-content');
				var $content_title = $floor.find('div.floor-row');
				for(var j =1;j<=$item.floor_row_count;j++){
					$('<li onclick="click_floor_row(this);" enter="no" style="width:'+$item.floor_cell_width+'px;height:'+$item.floor_cell_height+'px;line-height:'+$item.floor_cell_height+'px;">'+j+'</li>').appendTo($content_title.find('ul'));//添加行序号
					if(j<$item.floor_row_count){//此处判断是为了减少多增的一行
						var cont = ['<ul style="top:'+(($item.floor_cell_height*j)+j)+'px;">'];
						cont.push('</ul>');
						$(cont.join('')).appendTo($content);
					}
				}
				for(var i =1;i<=$item.floor_column_count;i++){
					$('<li onclick="click_floor_row(this);" enter="no" style="left:'+(($item.floor_cell_width*i)+i)+'px;width:'+$item.floor_cell_width+'px;">'+$ul.find('li').length+'</li>').appendTo($ul);//添加列序号
					if($item.floor_row_count>0){
						$content.find('ul').each(function(){
							$('<li id="floor_cell_f'+($floor.index()+1)+'_r'+($(this).index()+1)+'_c'+i+'" click="no" onclick="floor_cell_click(this);" style="left:'+(($item.floor_cell_width*(i-1))+(i-1))+'px;width:'+$item.floor_cell_width+'px;height:'+$item.floor_cell_height+'px;"></li>').appendTo($(this));//创建单元格
						});
					}
				}
				for(var i in $item.floorCells){
					var _floor_product = $item.floorCells[i];
					
					var min_val_obj_0 = _floor_product.cell_row_index;
					var min_val_obj_1 = _floor_product.cell_column_index; 
					var _add_div_height = parseInt($item.floor_cell_height)*parseInt(_floor_product.cell_row_count);
					var _add_div_width = parseInt($item.floor_cell_width)*parseInt(_floor_product.cell_column_count);
					
					
					var $add_div = $('<div click="no" onclick="floor_img_click_operator(this);" id="floor_cell_info_f'+$floor.index()+'_r'+min_val_obj_0+'_c'+min_val_obj_1+'_rcount'+_floor_product.cell_row_count+'_ccount'+_floor_product.cell_column_count+'" style="background:red;width:'+_add_div_width+'px;height:'+_add_div_height+'px;position: absolute;left:'+((parseInt($item.floor_cell_width)*(min_val_obj_1-1))+parseInt(min_val_obj_1))+'px;top:'+(parseInt($item.floor_cell_height)*(min_val_obj_0-1)+parseInt(min_val_obj_0)-1)+'px;"></div>').appendTo($floor.find("div.floor-content-values"));//添加处于顶层数据
					
					$('<img width="'+_add_div_width+'" height="'+_add_div_height+'" src="'+_floor_product.cell_picture+'" />').appendTo($add_div);
					var $form = $('<form onsubmit="return false;"><input type="hidden" name="cell_row_count" /><input type="hidden" name="cell_column_count" /><input type="hidden" name="cell_row_index" /><input type="hidden" name="cell_column_index" /><input type="hidden" name="cell_text" /><input type="hidden" name="cell_css_style" /><input type="hidden" name="cell_bg_color" /><input type="hidden" name="cell_id" /><input type="hidden" name="cell_picture" /><input type="hidden" name="cell_vertical" /><input type="hidden" name="cell_picture_or_color" /></form>').appendTo($add_div);
					console.info(_floor_product);
					$form.form('load',_floor_product);//绑定数据是单元格中
				}
				
				/*初始化楼层的高度*/
				var row_count = $floor.find('div.floor-row li');
				var column_count = $floor.find('div.floor-column li');
				$floor.height(row_count.length*parseInt($item.floor_cell_height)+30+row_count.length);
				$floor.find('div.floor-not-allowed').height(row_count.length*parseInt($item.floor_cell_height)+30+row_count.length);
				$floor.find('div.floor-not-allowed').width(column_count.length*parseInt($item.floor_cell_width)+column_count.length);
				/*为楼层填充表单数据*/
				$floor.find('div.floor-info-form form').form('load',$item);
				$floor.find('div.floor-not-allowed').css('opacity',0.3);
				
				
				$.ajax({url:floor_cell_all_action,async:false,method:'post',data:{'productFloor.floor_id':$item.floor_id},success:function(data){
					for(var ii in data){
						var oo_b = data[ii];
						var $add_div = $('<div click="no" onclick="floor_img_click_operator(this);" id="floor_cell_info_f'+$floor.index()+'_r'+oo_b.cell_row_index+'_c'+oo_b.cell_column_index+'_rcount'+oo_b.cell_row_count+'_ccount'+oo_b.cell_column_count+'" style="background:red;width:'+($item.floor_cell_width*oo_b.cell_column_count)+'px;height:'+($item.floor_cell_height*oo_b.cell_row_count+1)+'px;position: absolute;left:'+(($item.floor_cell_width*(oo_b.cell_column_index-1))+oo_b.cell_column_index)+'px;top:'+($item.floor_cell_height*(oo_b.cell_row_index-1)+oo_b.cell_row_index-1)+'px;"></div>').appendTo($floor.find("div.floor-content-values"));//添加处于顶层数据
						if(oo_b.cell_picture_or_color){
							$add_div.css('opacity',0.8);
							$('<img width="'+($item.floor_cell_width*oo_b.cell_column_count+(oo_b.cell_column_count-1))+'" height="'+($item.floor_cell_height*oo_b.cell_row_count+(oo_b.cell_row_count-1))+'" src="'+oo_b.cell_picture+'" />').appendTo($add_div);
						}else{
							if(oo_b.cell_vertical){//文字是否竖显示
								var sArray = oo_b.text.split('');
								var afterArray = [];
								for(var s in sArray){
									afterArray.push(sArray[s]+'<br/>');
								}
								$add_div.css({
									'background-color':oo_b.cell_bg_color,
									'text-align':'center'
								}).html(afterArray.join(''));
							}else{
								$add_div.css('background-color',oo_b.cell_bg_color).html(oo_b.cell_text);
							}
						}
						if($.trim(oo_b.cell_css_style)!=''){
							$add_div.attr('style',($add_div.attr('style')+";"+oo_b.cell_css_style));
						}
						var $form = $('<form onsubmit="return false;"><input type="hidden" name="cell_url" /><input type="hidden" name="productFloor.floor_id" /><input type="hidden" name="cell_picture" /><input type="hidden" name="cell_id" /><input type="hidden" name="cell_column_index" /><input type="hidden" name="cell_row_index" /><input type="hidden" name="cell_column_count" /><input type="hidden" name="cell_row_count" /><input type="hidden" name="cell_vertical" /><input type="hidden" name="cell_picture_or_color" /><input type="hidden" name="cell_text" /><input type="hidden" name="cell_css_style" /><input type="hidden" name="cell_bg_color" /></form>').appendTo($add_div);
						$.extend(oo_b,{'cell_bg_color':oo_b.cell_bg_color.slice(1)})
						$form.form('load',oo_b);//绑定数据是单元格中
					}
				}});
				
				$floor = null;
			}
			$("#lox-tabs").mask('hide');
		});
		
	}
	
	function edit_floor(self){//修改楼层信息
		floor_button_status='edit';
		$floor_click_index = $(self).parents('div.floor-list').index();
		var $floor_from_obj = get_floor_for_index().find('div.floor-info-form form').serializeObject();
		$("#floor-info-dialog").dialog('open');
		$("#floor-info-dialog").find('form').form('load',$floor_from_obj);
		$("#floor-info-dialog").find('#floor_column_count').textbox('disable');
		$("#floor-info-dialog").find('#floor_row_count').textbox('disable');
		if($floor_from_obj.status=='NORMAL'){
			$("#show_floor_is").attr('src','${base_url}/resource/admin/images/yes.jpg');
		}else{
			$("#show_floor_is").attr('src','${base_url}/resource/admin/images/no.jpg');
		}
	}
	
	function floor_locked_click(self){//解锁与锁定
		var $floor = $(self).parents('div.floor-list');
		$floor_click_index = $floor.index();
		var lock_floor = $floor.find('div.floor-locked-button input[name=floor-locked]');
		if(lock_floor.val()=='true'){
			lock_floor.val('false');
			$(self).text('锁定');
			$floor.find('div.floor-not-allowed').css({
				'opacity':0,
				'cursor':'default',
				'z-index':0
			});
			$floor.find('div.floor-info-menu').fadeIn();
			
			$("div.floors").find('div.floor-list').not($floor).each(function(){
				var $ff = $(this);
				var bbox = $ff.find('div.floor-locked-button');
				bbox.find('a').text('解锁');
				bbox.find('input[name=floor-locked]').val('true');
				$ff.find('div.floor-not-allowed').css({
					'opacity':0.3,
					'cursor':'not-allowed',
					'z-index':5
				});
				$ff.find('div.floor-info-menu').fadeOut();
			});
		}else{
			lock_floor.val('true');
			$(self).text('解锁');
			$floor.find('div.floor-not-allowed').css({
				'opacity':0.3,
				'cursor':'not-allowed',
				'z-index':5
			});
			$floor.find('div.floor-info-menu').fadeOut();
		}
		clean_floor_cell_infos($floor_click_index);
	}
	
	var floor_not_allowed_click_time_count = 0;
	var color_time = null;
	function floor_not_allowed_click(self){//锁定楼层情况下点击
		var $floor = $(self).parents('div.floor-list');
		if($floor.find('div.floor-locked-button input[name=floor-locked]').val()=='true'){
			var $floor_color = $floor.find('div.floor-locked-button a.floor-locked');
			var color = null;
			clearInterval(color_time);
			color_time = setInterval(function(){
				if(floor_not_allowed_click_time_count%2==0){
					color = 'red';
				}else{
					color = 'white';
				}
				if(floor_not_allowed_click_time_count>=6){
					$floor_color.removeAttr('style');
					floor_not_allowed_click_time_count =0;
					clearInterval(color_time);
				}else{
					floor_not_allowed_click_time_count++;
					$floor_color.css('color',color);
				}
			},50);
		}
	}
	
	function save_floor_info(){//保存楼层信息
		var $form_data = $("#floor-info-dialog").find('form').serializeObject();
		if(floor_button_status=='edit'){
			$("#floor-info-dialog").find('form').form('submit',{
				url:floor_edit_action,
				onSubmit : function() {
					var isValid = $(this).form('validate');
					if (isValid) {
						$.messager.progress('close');
					}
					if (isValid) {
						$.messager.progress();
					}
					return $(this).form('validate');
				},
				success:function(data){
					$.messager.progress('close');
					if(data=='success'){
						$("#floor-info-dialog").dialog('close');
						msgShow('温馨提示','楼层修改成功.');
						get_floor_for_index().find('div.floor-info-form form').form('load',$form_data);
						inits_floors();
					}else{
						$.messager.alert('温馨提示',data,'error');
					}
				}
			});
		}else{
			$("#floor-info-dialog").find('form').form('submit',{
				url:floor_add_action,
				onSubmit : function() {
					var isValid = $(this).form('validate');
					if (isValid) {
						$.messager.progress('close');
					}
					if (isValid) {
						$.messager.progress();
					}
					return $(this).form('validate');
				},
				success:function(data){
					$.messager.progress('close');
					if(data=='success'){
						$("#floor-info-dialog").dialog('close');
						msgShow('温馨提示','楼层添加成功.');
						inits_floors();
					}else{
						$.messager.alert('温馨提示',data,'error');
					}
				}
			});
		}
	}
	
	function create_floor(){//创建楼层
		floor_button_status = 'create';
		$("#floor-info-dialog").dialog('open');
		$("#floor-info-dialog").find('form').form('clear').form('load',{
			'floor_id':'',
			'floor_name':'',
			'floor_cell_width':100,
			'floor_cell_height':100,
			'floor_row_count':3,
			'floor_column_count':10,
			'status':'NORMAL',
			'sequence':0
		});
		$("#floor-info-dialog").find('#floor_column_count').textbox('enable');
		$("#floor-info-dialog").find('#floor_row_count').textbox('enable');
		$("#show_floor_is").attr('src','${base_url}/resource/admin/images/yes.jpg');
	}
	
	function clean_floor_datas(self){//清空楼层数据
		$floor_click_index = $(self).parents('div.floor-list').index();
		$floor = get_floor_for_index();
		$.messager.confirm('温馨提示','确定要清空此楼层的数据吗?',function(r){
			if(r){
				$.messager.progress();
				$.post(floor_clear_action,{'floor_id':$floor.find('div.floor-info-form form:first').find('input[name=floor_id]').val()},function(data){
					$.messager.progress('close');
					if(data=='success'){
						msgShow('温馨提示','清空成功.');
						inits_floors();
					}else{
						$.messager.alert('温馨提示',data,'error');
					}
				});
			}
		});
	}
	
	
	function delete_floor(self){
		var $floor_from = $(self).parents('div.floor-list').find('div.floor-info-form form').serializeObject();
		$.messager.confirm('温馨提示','确定要删除此楼层吗?',function(r){
			if(r){
				$.messager.progress();
				$.post(floor_del_action,{'floor_id':$floor_from.floor_id},function(data){
					$.messager.progress('close');
					if(data=='success'){
						msgShow('温馨提示','楼层删除成功.');
						$(self).parents('div.floor-list').remove();
					}else{
						$.messager.alert('温馨提示',data,'error');
					}
				});
			}
		});
	}

	
	function save_floor_cell(){//保存楼层单元格信息
		/*************************/
		var serializeData = $("#floor-cell-dialog").find('form:first').serializeObject();
		$('.dounine-color').val('#'+$('.dounine-color').val());
		if(floor_cell_sort_groups.length>0){
			var min_val_obj = floor_cell_sort_groups[0];
			var max_val_obj = floor_cell_sort_groups[floor_cell_sort_groups.length-1];
			
			var min_val_obj_0 = min_val_obj[0].split('-')[0];
			var min_val_obj_1 = min_val_obj[0].split('-')[1];
			
			var max_val_obj_0 = max_val_obj[0].split('-')[0];
			var max_val_obj_1 = max_val_obj[max_val_obj.length-1].split('-')[1];
			
			var _add_div_height = $floor_cell_height*((max_val_obj_0-min_val_obj_0)+1);
			var _add_div_width = $floor_cell_width*((parseInt(max_val_obj_1)-parseInt(min_val_obj_1))+1);
			
			var _from = $("#floor-cell-dialog").find('form:first');
			_from.find('input[name=cell_column_index]').val(min_val_obj_1);
			_from.find('input[name=cell_row_index]').val(min_val_obj_0);
			_from.find('input[name=cell_column_count]').val(((parseInt(max_val_obj_1)-parseInt(min_val_obj_1))+1));
			_from.find('input[name=cell_row_count]').val(((max_val_obj_0-min_val_obj_0)+1));
			$('.dounine-color').val('#'+$('.dounine-color').val());
			$.messager.progress();
			$("#floor-cell-dialog").find('form:first').form('submit',{
				url:floor_cell_add_action,
				success:function(data){
					$.messager.progress('close');
					var $add_div = $('<div id="floor_cell_info_f'+$floor_click_index+'_r'+min_val_obj_0+'_c'+min_val_obj_1+'_rcount'+((max_val_obj_0-min_val_obj_0)+1)+'_ccount'+((parseInt(max_val_obj_1)-parseInt(min_val_obj_1))+1)+'" style="background:red;width:'+_add_div_width+'px;height:'+_add_div_height+'px;position: absolute;left:'+(($floor_cell_width*(min_val_obj_1-1))+parseInt(min_val_obj_1))+'px;top:'+($floor_cell_height*(min_val_obj_0-1)+parseInt(min_val_obj_0)-1)+'px;"></div>').appendTo($('div.floor-list').eq($floor_click_index).find("div.floor-content-values"));//添加处于顶层数据
					
					$('<img width="'+_add_div_width+'" height="'+_add_div_height+'" src="'+serializeData.cell_picture+'" />').appendTo($add_div);
					var $form = $('<form onsubmit="return false;"><input type="hidden" name="cell_url" /><input type="hidden" name="productFloor.floor_id" /><input type="hidden" name="cell_picture" /><input type="hidden" name="cell_id" /><input type="hidden" name="cell_ajax" /><input type="hidden" name="cell_ajax_url" /><input type="hidden" name="cell_ajax_method" /><input type="hidden" name="cell_column_index" /><input type="hidden" name="cell_row_index" /><input type="hidden" name="cell_column_count" /><input type="hidden" name="cell_row_count" /></form>').appendTo($add_div);
					
					$form.form('load',serializeData);//绑定数据是单元格中
					clean_floor_cell_infos();
					$("#floor-cell-dialog").find('form').form('clear');
					
					msgShow('温馨提示','添加成功.');
					
					setTimeout(function(){
						inits_floors();
					},1000);
				}
			});
			
		}else{
			var img_click_yes = get_floor_for_index().find('div.floor-content-values').find('img[click=yes]').parent();
			$.messager.progress();
			$("#floor-cell-dialog").find('form:first').form('submit',{
				url:floor_cell_edit_action,
				success:function(data){
					$.messager.progress('close');
					if(data=='success'){
						clean_floor_cell_infos();
						img_click_yes.find('img').attr('click','no');
						img_click_yes.find('form').form('load',serializeData);
						img_click_yes.find('img[click!=""]').attr('src',serializeData.cell_picture);
						get_floor_for_index().find('div.floor-img-click-operator').hide();
						
						msgShow('温馨提示','修改成功.');
						setTimeout(function(){
							inits_floors();
						},1000);
					}else{
						$.messager.alert('温馨提示',data,'error');
					}
				}
			});
			
		}
		cancel_floor_cell();
	}
	
	function floor_img_click_operator(self){
		var $self = $(self);
		$floor_click_index = $self.parents('div.floor-list').index();
		
		var $floor_from_obj = get_floor_for_index().find('div.floor-info-form form').serializeObject();
		
		var $self_img = $self.find('img');
		var _id = $self.attr('id').slice(16);
		var _f_index = _id.split('_')[0].slice(1);
		var _r_index = _id.split('_')[1].slice(1);
		var _c_index = _id.split('_')[2].slice(1);
		var _rcount = _id.split('_')[3].slice(6);
		var _ccount = _id.split('_')[4].slice(6);
		
		if($self.attr('click')=='no'){
			$self.attr('click','yes');
		}else{
			$self.attr('click','no');
		}
		var floor_img_operator = get_floor_for_index().find('div.floor-img-click-operator');
		get_floor_for_index().find('div.floor-content-values div[click=yes]').not($self).attr('click','no');
		if($self.attr('click')=='yes'){
			floor_img_operator.css({
				'left':parseInt($self.css('left'))+parseInt($self.width())/2+parseInt(floor_img_operator.width())/2,
				'top':parseInt($self.css('top'))+parseInt($self.height())/2+parseInt(floor_img_operator.height())/2
			}).show();
		}else{
			floor_img_operator.hide();
		}
		
		clean_floor_cell_infos();
	}
	
	function floor_img_cancel_operator(self){
		var $self = $(self);
		$floor_click_index = $self.parents('div.floor-list').index();
		
		var floor_img_operator = get_floor_for_index().find('div.floor-img-click-operator');
		get_floor_for_index().find('div.floor-content-values img[click=yes]').attr('click','no');
		floor_img_operator.hide();
	}
	
	function floor_img_edit_operator(self){
		var $self = $(self);
		$floor_click_index = $self.parents('div.floor-list').index();
		var click_node = get_floor_for_index().find('div.floor-content-values div[click=yes]');
		var serializeData = click_node.find('form').serializeObject();
		floor_click_operator_edit(serializeData);
		
		clean_floor_cell_infos();
	}
	
	function floor_img_del_operator(self){//删除楼层单元格信息
		var $self = $(self);
		$floor = $self.parents('div.floor-list');
		$floor_click_index = $floor.index();
		var img_node = $floor.find('div.floor-content-values').find('img[click=yes]');
		
		$.messager.confirm('温馨提示','确定要删除此楼层吗?',function(r){
			if(r){
				$.messager.progress();
				$.post(floor_cell_del_action,{'cell_id':img_node.find('form').find('input[name=cell_id]').val()},function(data){
					$.messager.progress('close');
					if(data=='success'){
						msgShow('温馨提示','删除成功.');
						img_node.parent().remove();
						$floor.find('div.floor-img-click-operator').hide();
					}else{
						$.messager.alert('温馨提示',data,'error');
					}
				});
			}
		});
		
	}
	
	function clean_floor_cell_infos(index){//清空单元格所有数据（初始化）
		floor_cell_sort_groups = [];
		$floor_click_cells = [];
		$floor_click_index = null;
		_$row_val = null;//行数据
		_$col_val = null;//列数据
		_$row_exit_val = [];//已经存在的行序号
		_$col_exit_val = [];//已经存在的列序号
		var $floor = null;
		if(index){
			$floor = $('div.floor-list').eq(index);
		}else{
			$floor = get_floor_for_index();
		}
		hide_click_operator($floor.find('div.floor-click-operator'));
		$floor.find('div.floor-content li[click=yes]').attr('click','no').removeClass('floor-click-color');
	}
	
	function clean_floor_cell_img(){
		var $floor = get_floor_for_index();
		$floor.find('div.floor-content-values').find('img[click=yes]').attr('click','no');
		$floor.find('div.floor-img-click-operator').hide();
	}
	
	function cancel_floor_cell(){//取消保存楼层单元格信息
		$("#floor-cell-dialog").dialog('close');
	}
	
	function create_floor_columns(floor){
		var $floor = $(floor);
		$floor_click_index = $floor.index();
		var $floor_from_obj = $floor.find('div.floor-info-form form').serializeObject();
		
		$.messager.progress();
		$.post(floor_add_column_action,{'floor_id':$floor_from_obj.floor_id},function(data){
			$.messager.progress('close');
			if(data=='success'){
				msgShow('温馨提示','楼层添加列成功.');
				
				var $row = $floor.find('div.floor-row').find('ul');
				var $row_lis = $row.find('li');
				var $content = $floor.find('div.floor-content');
				var $content_uls = $content.find('ul');
				var $column = $floor.find('div.floor-column').find('ul');//查找列序号对象
				var $column_lis = $column.find('li');
				$('<li onclick="click_floor_row(this);" enter="no" style="left:'+((parseInt($floor_from_obj.floor_cell_width)*($column_lis.length))+$column_lis.length)+'px;width:'+$floor_from_obj.floor_cell_width+'px;">'+($column_lis.length)+'</li>').appendTo($column);
				$content_uls.each(function(){
					$('<li id="floor_cell_f'+($floor.index()+1)+'_r'+($(this).index()+1)+'_c'+$column_lis.length+'" click="no" onclick="floor_cell_click(this);" style="left:'+((($column_lis.length-1)*parseInt($floor_from_obj.floor_cell_width))+($column_lis.length-1))+'px;width:'+$floor_from_obj.floor_cell_width+'px;height:'+$floor_from_obj.floor_cell_height+'px;"></li>').appendTo($(this));
				});
				
				var row_count = $floor.find('div.floor-row li');
				var column_count = $floor.find('div.floor-column li');
				$floor.find('div.floor-not-allowed').width(column_count.length*parseInt($floor_from_obj.floor_cell_width)+column_count.length);
				$floor.find('div.floor-not-allowed').css('opacity',0.3);
			}else{
				$.messager.alert('温馨提示',data,'error');
			}
		});
		
	}
	
	function create_floor_row(floor){
		var $floor = $(floor);
		$floor_click_index = $floor.index();
		var $floor_from_obj = $floor.find('div.floor-info-form form').serializeObject();
		
		$.messager.progress();
		$.post(floor_add_row_action,{'floor_id':$floor_from_obj.floor_id},function(data){
			$.messager.progress('close');
			if(data=='success'){
				msgShow('温馨提示','楼层添加行成功.');
				
				var $columns = $floor.find('div.floor-column').find('li');
				var $row = $floor.find('div.floor-row').find('ul');
				var $row_lis = $row.find('li');//得到行数
				var _row = $('<li onclick="click_floor_row(this);" enter="no" style="width:'+$floor_from_obj.floor_cell_width+'px;height:'+$floor_from_obj.floor_cell_height+'px;line-height:'+$floor_from_obj.floor_cell_height+'px;">'+($row_lis.length+1)+'</li>').appendTo($row);//添加新一行
				var conte = ['<ul style="top:'+((_row.index()*parseInt($floor_from_obj.floor_cell_height))+_row.index())+'px;">'];//添加新行的数组
				for(var i =0;i<$columns.length-1;i++){//减一是为了除去序列行号
					conte.push('<li id="floor_cell_f'+($floor.index()+1)+'_r'+($row_lis.length+1)+'_c'+(i+1)+'" click="no" onclick="floor_cell_click(this);" style="left:'+((i*$floor_cell_width)+i)+'px;width:'+$floor_from_obj.floor_cell_width+'px;height:'+$floor_from_obj.floor_cell_height+'px;"></li>');
				}
				conte.push('</ul>');
				$(conte.join('')).appendTo($floor.find('div.floor-content'));
				
				var row_count = $floor.find('div.floor-row li');
				$floor.height(row_count.length*parseInt($floor_from_obj.floor_cell_height)+30+row_count.length);
				$floor.find('div.floor-not-allowed').height(row_count.length*parseInt($floor_from_obj.floor_cell_height)+30+row_count.length);
			}else{
				$.messager.alert('温馨提示',data,'error');
			}
		});
		
	}
	
	function floor_cell_click(self){
		change_cell_bgcolor(self);//改变选中单元格的颜色
		push_cell_position(self);//把选中的单元格位置放入数组中
		clean_floor_cell_img();//还原带数据的单元格
	}
	
	function change_cell_bgcolor(self){//修变单元格颜色
		var $self = $(self);
		if($self.attr('click')=='no'){
			$self.attr('click','yes');
		}else{
			$self.attr('click','no');
		}
		
		if($self.attr('click')=='yes'){//双重保障
			$self.addClass('floor-click-color');
		}else{
			$self.removeClass('floor-click-color');
		}
	}
	
	function push_cell_position(self){
		var $self = $(self);
		$floor_click_cells = [];
		var $floor = $self.parents('div.floor-list');
		$floor_click_index = $floor.index();//把楼层索引放到公共变量中
		var $row = $floor.find('div.floor-content');
		var $clicks = $row.find('li[click=yes]');//查询当前楼层所选中的li
		$clicks.each(function(){
			var $myself = $(this);
			var $id = $myself.attr('id');
			var $id_rcs = $id.slice(14).split('_');
			var $id_row = $id_rcs[0].slice(1);
			var $id_column = $id_rcs[1].slice(1);
			$floor_click_cells.push([$id_row,$id_column]);
		});
		check_cell_point_yes($floor_click_cells);//检查选中的位置是否符合要求
	}
	
	var _$row_val = null;//行数据
	var _$col_val = null;//列数据
	var _$row_exit_val = [];//已经存在的行序号
	var _$col_exit_val = [];//已经存在的列序号
	function check_cell_point_yes(cells){
		if(cells.length>0){
			var ass_row = false;
			var ass_col = false;
			_$row_exit_val = [];//清空原有值
			_$col_exit_val = [];//清空原有值
			for(var cell in cells){
				_$row_val = cells[cell][0];//获取行数据
				_$col_val = cells[cell][1];//获取列数据
				
				floor_push_cell_row_index(_$row_val);//将行序列号压入数组中
				floor_push_cell_col_index(_$row_val,_$col_val);//将列序列号组合后压入数组中
			}
			
			floor_push_cell_sort_group();//将列号分组排序后压入数组中
			
			if(check_floor_push_cell_row_index()&&check_floor_push_cell_col_index()){
				show_floor_cell_operaotr();//根据规则是否显示单元格
				floor_cell_verity_yes();//'符合规则';
			}else{
				floor_cell_verity_not();//'不符合规则';
			}
		}else{
			hide_click_operator($("div.floor-list").eq($floor_click_index).find('div.floor-click-operator'));//当前点击的单元格为空的时候隐藏单元格操作
		}
	}
	
	function floor_click_operator_edit(serializeData,self){
		$("#floor-cell-dialog").dialog('open');
		if(!serializeData){
			$floor = $(self).parents('div.floor-list');
			$floor_click_index = $floor.index();
			serializeData = {};
			$.extend(serializeData,{
				'productFloor.floor_id':$floor.find('div.floor-info-form').find('form').find('input[name=floor_id]').val(),
				'cell_vertical':'false',
				'cell_picture_or_color':'false'
				});
		}
		$("#floor-cell-dialog").find('form').form('clear').form('load',serializeData);
		if(serializeData&&serializeData.cell_picture){
			$("#productPictureUrl").attr('src',serializeData.cell_picture);
		}else{
			$("#productPictureUrl").attr('src','${base}/resource/admin/css/themes/icons/dounine-icon-picture.png');
		}
		
		if(serializeData.cell_vertical=='false'){
			$("#floor-cell-dialog").find('form').find('input[name=cell_vertical]').parent().find('img').attr('src','${base_url}/resource/admin/images/no.jpg');
		}else{
			$("#floor-cell-dialog").find('form').find('input[name=cell_vertical]').parent().find('img').attr('src','${base_url}/resource/admin/images/yes.jpg');
		}
		
		if(serializeData.cell_picture_or_color=='false'){
			$("#floor-cell-dialog").find('form').find('input[name=cell_picture_or_color]').parent().find('img').attr('src','${base_url}/resource/admin/images/no.jpg');
		}else{
			$("#floor-cell-dialog").find('form').find('input[name=cell_picture_or_color]').parent().find('img').attr('src','${base_url}/resource/admin/images/yes.jpg');
		}
		$('.dounine-color').css('background-color','#'+serializeData.cell_bg_color);
		$('.dounine-color').focus();
	}
	
	function floor_click_operator_cancel(self){
		var $floor = $(self).parents('div.floor-list');//获取楼层jquery对象
		var $click_node = $floor.find('div.floor-content li[click=yes]');
		$click_node.attr('click','no').removeClass('floor-click-color');
		hide_click_operator($floor.find('div.floor-click-operator'));
	}
	
	function show_click_operator(self){//显示单元格操作
		self.show();
	}
	
	function hide_click_operator(self){//隐藏单元格操作
		self.hide();
	}
	
	function floor_cell_verity_yes(){//单元格点击位置验证通过
		var $floor = $('div.floor-list').eq($floor_click_index);//获取楼层jquery对象
		var $click_node = $floor.find('div.floor-click-operator');
		show_click_operator($click_node);
	}
	
	function floor_cell_verity_not(){//单元格点击位置验证不通过
		var $floor = $('div.floor-list').eq($floor_click_index);//获取楼层jquery对象
		var $click_node = $floor.find('div.floor-click-operator');
		hide_click_operator($click_node);
	}
	
	function show_floor_cell_operaotr(){
		var $floor_click_operator = $('div.floor-list').eq($floor_click_index).find(".floor-click-operator");
		
		var $floor_from_obj = get_floor_for_index().find('div.floor-info-form form').serializeObject();
		if(floor_cell_sort_groups.length>0){
			if(floor_cell_sort_groups.length==1){
				var gs = floor_cell_sort_groups[0];
				if(gs.length>1){
					var min_val = gs[0];
					var max_val = gs[gs.length-1];
					var column_width = (max_val.split('-')[1]-min_val.split('-')[1]+1);
					
					var min_val_0 = min_val.split('-')[0];
					var min_val_1 = min_val.split('-')[1];
					var max_val_0 = max_val.split('-')[0];
					var max_val_1 = max_val.split('-')[1];
					
					var id_obj = get_floor_for_index().find('div.floor-content').find('li#floor_cell_f'+(get_floor_for_index().index()+1)+'_r'+min_val_0+'_c'+min_val_1);
					var left = parseInt(id_obj.css('left'));
					var top = parseInt(id_obj.parent().css('top'));
					
					
					var $cell_obj = $('div.floor-content li#floor_cell_f'+($floor_click_index+1)+'_r'+min_val_0+'_c'+max_val_0);
					$floor_click_operator.css({
						'left':(parseInt($floor_from_obj.floor_cell_width)*min_val_1)+(parseInt($floor_from_obj.floor_cell_width)*(max_val_1-min_val_1)/2)+$floor_cell_operator_div_width/2,
						'top':(parseInt($floor_from_obj.floor_cell_height)*min_val_0)+(parseInt($floor_from_obj.floor_cell_height)*(max_val_0-min_val_0)/2)+$floor_cell_operator_div_height/2
					});
				}else{
					var min_val = gs[0];
					var min_val_0 = min_val.split('-')[0];
					var min_val_1 = min_val.split('-')[1];
					var id_obj = get_floor_for_index().find('div.floor-content').find('li#floor_cell_f'+(get_floor_for_index().index()+1)+'_r'+min_val_0+'_c'+min_val_1);
					var left = parseInt(id_obj.css('left'));
					var top = parseInt(id_obj.parent().css('top'));
					$floor_click_operator.css({
						'left':(left+parseInt($floor_from_obj.floor_cell_width))+$floor_cell_operator_div_width/2,
						'top':(top+parseInt($floor_from_obj.floor_cell_height)/2)-29/2
					});
				}
			}else{
				var min_gs = floor_cell_sort_groups[0];
				var max_gs = floor_cell_sort_groups[floor_cell_sort_groups.length-1];
				
				var min_val = min_gs[0];
				var max_val = max_gs[max_gs.length-1];
				
				var min_val_0 = min_val.split('-')[0];
				var min_val_1 = min_val.split('-')[1];
				
				var max_val_0 = max_val.split('-')[0];
				var max_val_1 = max_val.split('-')[1];
				
				$floor_click_operator.css({
					'left':parseInt($floor_from_obj.floor_cell_width)*min_val_1+((max_val_1-min_val_1)*$floor_from_obj.floor_cell_width)/2+$floor_cell_operator_div_width/2,
					'top':parseInt($floor_from_obj.floor_cell_height)*min_val_0+((max_val_0-min_val_0)*$floor_from_obj.floor_cell_height)/2-29/2+parseInt($floor_click_operator.height())/2
				});
				
			}
		}
	}
	
	function floor_push_cell_row_index(row_val){//把选中的行号压入数组中
		var _pass_row_exit_val = true;
		for(var _excell in _$row_exit_val){
			if(_$row_exit_val[_excell]==row_val){
				_pass_row_exit_val = false;
				break;
			}
		}
		if(_pass_row_exit_val||_$row_exit_val.length==0){
			_$row_exit_val.push(row_val);
		}
	}
	
	function floor_push_cell_col_index(row_val,col_val){//把选中的列号压入数组中
		var _pass_col_exit_val = true;
		for(var _excell in _$col_exit_val){
			if(_$col_exit_val[_excell]==(row_val+'-'+col_val)){
				_pass_col_exit_val = false;
				break;
			}
		}
		if(_pass_col_exit_val||_$col_exit_val.length==0){
			_$col_exit_val.push((row_val+'-'+col_val));
		}
	}
	
	function check_floor_push_cell_col_index(){//检查列号是否符合规则
		/* 进行一轮简单判断(每行长度) */
		var first_length = floor_cell_sort_groups[0].length;
		for(var item in floor_cell_sort_groups){
			if(first_length!=floor_cell_sort_groups[item].length){
				return false;
			}
		}
		/* 进行第二轮判断(每行的索引数据) */
		var first_groups = floor_cell_sort_groups[0];
		for(var item in floor_cell_sort_groups){
			var ggs = floor_cell_sort_groups[item];
			for(var i =0;i<first_groups.length;i++){
				if(first_groups[i].split('-')[1]!=ggs[i].split('-')[1]){
					return false;
				}
			}
		}
		/* 第行第三轮判断(索引连续) */
		for(var item in floor_cell_sort_groups){
			var ggs = floor_cell_sort_groups[item];
			var ggs_min_val = ggs[0].split('-')[1];
			var ggs_max_val = ggs[ggs.length-1].split('-')[1];
			if((ggs_max_val-ggs_min_val)!=(ggs.length-1)){
				return false;
			}
		}
		return true;
	}
	
	var floor_cell_sort_groups = [];//分行排序单元格位置
	function floor_push_cell_sort_group(){//将列号分组排序后压入数组中
		floor_cell_sort_groups = [];
		var _groups = [];
		var _first_val = null;
		for(var item in _$col_exit_val){
			var val = _$col_exit_val[item];
			if(_first_val&&_first_val!=val.split('-')[0]){
				floor_cell_sort_groups.push(_groups);
				_groups = [];
			}
			_groups.push(val);
			if(val){
				_first_val = val.split('-')[0];
			}
		}
		floor_cell_sort_groups.push(_groups);
	}
	
	function check_floor_push_cell_row_index(){//检查行号是否符合规则
		var _$row_exit_val_length = _$row_exit_val.length;
		if(_$row_exit_val_length.length!=1){
			var arr_min_val = _$row_exit_val[0];//数组中最小的值
			var arr_max_val = _$row_exit_val[_$row_exit_val.length-1];//数组中最大的值
			if((arr_max_val-arr_min_val)!=(_$row_exit_val.length-1)){//最大值减去最小值等于长度证明符号规则
				return false;
			}
		}
		return true;
	}
	
	var click_floor_row_time = null;
	var click_floor_row_time_y = false;
	function click_floor_row(self){//点击序列号
		click_floor_row_time_y = false;
		var $self = $(self);
		$floor_click_index = $self.parents('div.floor-list').index();
		$floor = get_floor_for_index();
		var $floor_from_obj = $floor.find('div.floor-info-form form').serializeObject();
		clearTimeout(click_floor_row_time);
		click_floor_row_time = setTimeout(function(){
			if(!click_floor_row_time_y){
				$floor.find('div.floor-row-operator').hide();
				$floor.find('div.floor-column').find('li[enter=yes]').attr('enter','no');//清除列
				$floor.find('div.floor-row').find('li[enter=yes]').attr('enter','no');//清除行
			}
		},3000);
		
		if($self.parents('div.floor-column').length==1){
			$floor.find('div.floor-row-operator').css({
				'top':4,
				'left':parseInt($floor_from_obj.floor_cell_width)*$self.index()+$self.index()
			}).show().find('a').text('删列');
			$floor.find('div.floor-column').find('li[enter=yes]').attr('enter','no');//清除列
			$floor.find('div.floor-row').find('li[enter=yes]').attr('enter','no');//清除行
			$self.attr('enter','yes');
		}else if($self.parents('div.floor-row').length==1){
			$floor.find('div.floor-row-operator').css({
				'top':parseInt($floor_from_obj.floor_cell_height)*$self.index()+30+parseInt($floor_from_obj.floor_cell_height)/2-22/2+$self.index(),
				'left':4
			}).show().find('a').text('删行');
			$floor.find('div.floor-column').find('li[enter=yes]').attr('enter','no');//清除列
			$floor.find('div.floor-row').find('li[enter=yes]').attr('enter','no');//清除行
			$self.attr('enter','yes');
		}
		
	}
	
	function floor_row_or_col_click(self){//删除楼层的列或行
		click_floor_row_time_y = true;
		var $self = $(self);
		$floor_click_index = $self.parents('div.floor-list').index();
		$floor = get_floor_for_index();
		var $floor_from_obj = $floor.find('div.floor-info-form form').serializeObject();
		var delete_ids = [];//删除列或行中有关联的图片数据
		var contents = get_floor_for_index().find('div.floor-content-values div');
		if($floor.find('div.floor-column').find('li[enter=yes]').length==1){//删除列
			var click_obj = $floor.find('div.floor-column').find('li[enter=yes]');
			
			//以下是对已经保存的图片数据对行操作
			
			contents.each(function(){
				var my = $(this);
				var _id = my.attr('id');
				//进行一层判断（相同列）
				var _ids = _id.slice(16).split('_');
				var f_index = _ids[0].slice(1);//楼层索引
				var r_index = _ids[1].slice(1);//楼层行索引
				var c_index = _ids[2].slice(1);//楼层列索引
				var rcount_index = _ids[3].slice(6);//楼层行占宽
				var ccount_index = _ids[4].slice(6);//楼层列占宽
				if(c_index<=click_obj.index()&&click_obj.index()<=(parseInt(c_index)+parseInt(ccount_index)-1)){
					delete_ids.push(_id);
				}
			});
			var tip_text = null;
			if(delete_ids.length>0){
				tip_text = '确定要删除关联此列中的数据吗?';
			}
			
			$.messager.confirm('提示',tip_text?tip_text:'确定要删除这列吗?',function(r){
				if(r){
					$.messager.progress();
					
					var _ids = [];
					for(var id_index in delete_ids){
						_ids.push($('#'+delete_ids[id_index]).find('form:first').find('input[name=cell_id]').val());
					}
					
					$.post(floor_del_column_action,{'floor_id':$floor_from_obj.floor_id,'ids':_ids.join(',')},function(data){
						$.messager.progress('close');
						if(data=='success'){
							msgShow('温馨提示','删除列成功.');
							for(var id_index in delete_ids){
								$('#'+delete_ids[id_index]).remove();
							}
							if(click_obj.index()==$floor.find('div.floor-column li').length-1){//删除最后一行
								$floor.find('div.floor-content ul').each(function(){
									$(this).find('li:last').remove();
									$(this).find('li').eq(click_obj.index()).remove();
								});
							}else{
								$floor.find('div.floor-content ul').each(function(){
									$(this).find('li').eq(click_obj.index()).nextAll().each(function(){
										$(this).css({
											'left':parseInt($(this).css('left'))-$floor_cell_width-1
										});
									});
									$(this).find('li').eq(click_obj.index()).remove();
									$(this).find('li').each(function(){//对ID编号从新编排
										var _id = $(this).attr('id');
										$(this).attr('id',_id.slice(0,_id.lastIndexOf('_c')+2)+($(this).index()+1));
									});
								});
							}
							click_obj.nextAll().each(function(){
								$(this).css({
									'left':parseInt($(this).css('left'))-$floor_cell_width-1
								});
							});
							click_obj.remove();
							$floor.find('div.floor-column li:gt(0)').each(function(){//对列序号从新排序
								$(this).text($(this).index());
							});
						}else{
							$.messager.alert('温馨提示',data,'error');
						}
					});
					
				}else{
					return false;
				}
			});
			
			
			
			
		}else{//删除行
			var click_obj = $floor.find('div.floor-row').find('li[enter=yes]');
			
			//以下是对已经保存的图片数据对行操作
			
			contents.each(function(){
				var my = $(this);
				var _id = my.attr('id');
				//进行一层判断（相同列）
				var _ids = _id.slice(16).split('_');
				var f_index = _ids[0].slice(1);//楼层索引
				var r_index = _ids[1].slice(1);//楼层行索引
				var c_index = _ids[2].slice(1);//楼层列索引
				var rcount_index = _ids[3].slice(6);//楼层行占宽
				var ccount_index = _ids[4].slice(6);//楼层列占宽
				
				if(r_index<=(click_obj.index()+1)&&(click_obj.index()+1)<=(parseInt(r_index)+parseInt(rcount_index)-1)){
					delete_ids.push(_id);
				}
			});
			
			var tip_text = null;
			if(delete_ids.length>0){
				tip_text = '确定要删除关联此行中的数据吗?';
			}
			
			$.messager.confirm('提示',tip_text?tip_text:'确定要删除这行吗?',function(r){
				if(r){
					$.messager.progress();
					
					var _ids = [];
					for(var id_index in delete_ids){
						_ids.push($('#'+delete_ids[id_index]).find('form:first').find('input[name=cell_id]').val());
					}
					
					$.post(floor_del_row_action,{'floor_id':$floor_from_obj.floor_id,'ids':_ids.join(',')},function(data){
						$.messager.progress('close');
						
						if(data=='success'){
							msgShow('温馨提示','删除行成功.');
							for(var id_index in delete_ids){
								$('#'+delete_ids[id_index]).remove();
							}
							$floor.find('div.floor-content ul').eq(click_obj.index()).remove();//删除content数据
							$floor.find('div.floor-row li').eq(click_obj.index()).remove();
							
							$floor.find('div.floor-content ul').each(function(){//重新排序
								$(this).css({
									'top':$floor_cell_height*$(this).index()+$(this).index()
								});
							});
							$floor.find('div.floor-row li').each(function(){
								$(this).text($(this).index()+1);
							});
						}else{
							$.messager.alert('温馨提示',data,'error');
						}
					});
				}else{
					return false;
				}
			});
		}
		
		$floor.find('div.floor-content li[click=yes]').attr('click','no').removeClass('floor-click-color');
		$floor.find('div.floor-click-operator').hide();
		$floor.find('div.floor-row-operator').hide();
		
	}
	
	
	function get_floor_for_index(){
		return $('div.floor-list').eq($floor_click_index);
	}
	
	function floor_info_title_enter(self){//鼠标滑过楼层标题
		$(self).find('div.floor-info-menu').fadeIn();
	}
	function floor_info_title_leave(self){//鼠标滑过楼层标题
		$(self).find('div.floor-info-menu').hide();
	}
	
	function isShowFloor(self){//是否显示楼层
		var $self = $(self);
		var $input = $self.parent().find('input[name=status]');
		if($input.val()=='NORMAL'){
			$input.val('CONGEAL');
			$self.attr('src','${base}/resource/admin/images/no.jpg');
		}else{
			$input.val('NORMAL');
			$self.attr('src','${base}/resource/admin/images/yes.jpg');
		}
	}
	
	function cell_vertical_click_yes_no(self){
		var $self = $(self);
		var _input = $self.parent().find('input[name=cell_vertical]');
		if(_input.val()=='false'){
			_input.val('true');
			$self.attr('src','${base_url}/resource/admin/images/yes.jpg');
		}else{
			_input.val('false');
			$self.attr('src','${base_url}/resource/admin/images/no.jpg');
		}
	}
	
	function cell_picture_or_color_click_yes_no(self){
		var $self = $(self);
		var _input = $self.parent().find('input[name=cell_picture_or_color]');
		if(_input.val()=='false'){
			_input.val('true');
			$self.attr('src','${base_url}/resource/admin/images/yes.jpg');
		}else{
			_input.val('false');
			$self.attr('src','${base_url}/resource/admin/images/no.jpg');
		}
	}
</script>
