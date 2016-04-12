var BugType = (function() {

	function BugType() {
	}
	
	function getModuleName(){
		return "BUG类型";
	}
	
	BugType.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	BugType.prototype.success_refresh = true;//操作成功后刷新列表
	
	BugType.prototype.Data_Id = function (row){
		return {'bugTypeId':row['bugTypeId']};
	}
	
	BugType.prototype.load = function() {
		$BugType.datagrid.datagrid({
			url : arguments.length==0?null:$BugType.loadUrl,
			rownumbers : true,
			lines:true,
			fitColumns : true,
			singleSelect : true,
			pagination : true,
			border:false,
		    onSelect:rowClick,
			columns : [ [ {
				field : 'bugTypeId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'bugTypeName',
				title : '类型名称',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			}, {
				field : 'bugTypeDescription',
				title : '类型描述',
				width : 100
			}] ],
			toolbar : $BugType.datagrid_menu
		});
		
		function rowClick(){
			var row = $BugType.datagrid.datagrid('getSelected');
			if(row){
				$('#sbtdm-menu-edit').menubutton('enable');
				$('#sbtdm-menu-del').menubutton('enable');
			}else{
				$('#sbtdm-menu-edit').menubutton('disable');
				$('#sbtdm-menu-del').menubutton('disable');
			}
		}
	}
	
	BugType.prototype.add = function() {
		dialogOpen('添加');
		$BugType.button = true;
		$BugType.form.form('clear');
	}
	
	BugType.prototype.edit = function() {
		dialogOpen('编辑');
		$BugType.button = false;
		$BugType.form.form('load',$BugType.datagrid.datagrid('getSelected'));
	}
	
	BugType.prototype.search = function() {
		$BugType.datagrid.datagrid('reload', $BugType.searchForm.serializeObject());
	}

	BugType.prototype.del = function() {
		var row = $BugType.datagrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.messager.progress();
					$.post($BugType.delUrl, 
						$BugType.Data_Id(row), function(data) {
						if (data == "success") {
							msgShow($BugType.Messager_Title(), getModuleName()+'删除成功.');
							dataGridReload();
							initButtons();
						} else {
							$.messager.alert($BugType.Messager_Title(), data, 'error');
						}
						$.messager.progress('close');
					});
				}
			});
			return;
		}
		$.messager.alert($BugType.Messager_Title(), "请选择要删除的"+getModuleName()+".", 'error');
	}

	
	function dataGridReload(){
		$BugType.datagrid.datagrid('options').url=$BugType.loadUrl;
		$BugType.datagrid.datagrid('reload');
		$BugType.datagrid.datagrid('unselectAll');
		initButtons();
	}
	
	
	function initButtons() {
		$('#slodm-menu-remove').linkbutton('disable');
	}
	
	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($BugType.success_refresh){
			tex = '<font style="color:#B1B1B1;" class="check_font_for_refresh">操作成功后刷新</font> <input class="check_input_for_refresh" type="checkbox" style="display:none;vertical-align: middle;" disabled="disabled" checked="checked"/>';
		}else{
			tex = '<font style="color:#B1B1B1;" class="check_font_for_refresh">操作成功后不刷新</font> <input class="check_input_for_refresh" type="checkbox" style="display:none;vertical-align: middle;" disabled="disabled"/>';
		}
		var ref_title = {
			plain:true,
			text : tex,
			handler:function(){
				var input1 = $(this).find('input');
				if(input1.attr('checked')){
					$BugType.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$BugType.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $BugType.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $BugType.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$BugType.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$BugType.form.form('submit', {
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
					msgShow($BugType.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($BugType.success_refresh);
					if($BugType.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					$.messager.alert($BugType.Messager_Title(), data, 'error');
				}
			}
		});
	}

	BugType.prototype.save = function() {
		if ($BugType.button) {
			formSubmit($BugType.addUrl,'添加');// 表单添加
		} else {
			formSubmit($BugType.editUrl,'编辑');// 表单编辑
		}
	}

	BugType.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$BugType.dialog.dialog('close');
	}

	return BugType;
})();
