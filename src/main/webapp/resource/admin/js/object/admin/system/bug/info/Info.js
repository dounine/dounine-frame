var Info = (function() {

	function Info() {
	}
	
	function getModuleName(){
		return "BUG";
	}
	
	Info.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Info.prototype.success_refresh = true;//操作成功后刷新列表
	
	Info.prototype.Data_Id = function (row){
		return {'scheduleJobGroupId':row['scheduleJobGroupId']};
	}
	
	Info.prototype.load = function($Bug) {
		$Info.type.combogrid({
			width:300,
			url:$Info.bugTypeUrl,
			idField:'bugTypeId',
			textField:'bugTypeName',
			fitColumns:true,
			required:true,
			editable:false,
			onLoadSuccess:function(){
				if(!$Bug.button){
					var row = $Bug.row;
					$Info.type.combogrid('setValue',row.bugType.bugTypeId);
				}
			},
			columns:[[
			          {
			        	  field:'bugTypeName',
			        	  width:300
			          }
			   ]]
		});
		$("#bugButton").html('&nbsp;&nbsp;发&nbsp;&nbsp;布&nbsp;&nbsp;')
		if(!$Bug.button){
			$("#bugButton").html('&nbsp;&nbsp;编&nbsp;&nbsp;辑&nbsp;&nbsp;')
			var row = $Bug.row;
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
				if (data == 'success') {
					msgShow($Info.Messager_Title(), getModuleName() + successInfo +'成功.');
				} else {
					$.messager.alert($Info.Messager_Title(), data, 'error');
				}
			}
		});
	}

	Info.prototype.save = function($Bug) {
		if ($Bug.button) {
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
