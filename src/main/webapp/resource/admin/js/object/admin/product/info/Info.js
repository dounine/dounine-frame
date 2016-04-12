var Info = (function() {

	function Info() {
	}
	
	function getModuleName(){
		return "框架";
	}
	
	Info.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Info.prototype.success_refresh = true;//操作成功后刷新列表
	
	Info.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	Info.prototype.load = function($Product) {
		$Info.type.combogrid({
			width:300,
			url:$Info.productClassUrl,
			idField:'id',
			textField:'name',
			fitColumns:true,
			required:true,
			editable:false,
			onLoadSuccess:function(){
				if($Product.row){
					$Info.type.combogrid('setValue',$Product.row.productClass.id);
				}
			},
			columns:[[
			          {
			        	  field:'name',
			        	  width:300
			          }
			   ]]
		});
		$("#productButton").html('&nbsp;&nbsp;发&nbsp;&nbsp;布&nbsp;&nbsp;')
		if($Product.row){
			$("#productButton").html('&nbsp;&nbsp;编&nbsp;&nbsp;辑&nbsp;&nbsp;')
			var row = $Product.row;
			$Info.form.form('load',row);
		}
	}
	
	function formSubmit(url,successInfo,title) {
		$Info.form.form('submit', {
			url : url,
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
			success : function(data) {
				$.messager.progress('close');
				if (data.indexOf('success')>-1) {
					msgShow($Info.Messager_Title(), getModuleName() + successInfo +'成功.');
					$("#publish_frame_font").nextAll().show();
					if($Product.button){
						$Product.row = {};
						$("#productButton").linkbutton({
							text:'&nbsp;&nbsp;编&nbsp;&nbsp;辑&nbsp;&nbsp;'
						});
						$Product.button = false;//修改状态
					}
					var id = data.substring(8);
					var _id = id?id:$Product.row.id;
					$("#product_id").val(_id);
					$.extend($Product.row,{
						'id':_id,
						'name':$("#product_name").textbox('getValue'),
						'sequence':$("#product_sequence").numberspinner('getValue'),
						'productClass':{'id':$("#productClass").combogrid('getValue')}
					});
				} else {
					$.messager.alert($Info.Messager_Title(), data, 'error');
				}
			}
		});
	}

	Info.prototype.save = function($Product) {
		if ($Product.button) {
			formSubmit($Info.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Info.editUrl,'编辑');// 表单编辑
		}
	}

	Info.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$Info.form.form('reset');
	}
	
	function dataGridReload(){
		$ScheduleJob_Group.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#qsgdm-menu-remove').menubutton('disable');
		$('#qsgdm-menu-edit').menubutton('disable');
		$('#qsgdm-menu-congeal').menubutton('disable');
		$('#qsgdm-menu-thaw').menubutton('disable');
	}

	return Info;
})();
