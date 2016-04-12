var Operation = (function() {

	function Operation() {
	}
	
	function getModuleName(){
		return "操作日志";
	}
	
	Operation.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Operation.prototype.success_refresh = true;//操作成功后刷新列表
	
	Operation.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	Operation.prototype.load = function() {
		$Operation.datagrid.datagrid({
			url : arguments.length==0?null:$Operation.loadUrl,
			rownumbers : true,
			lines:true,
			fitColumns : true,
			singleSelect : true,
			pagination : true,
			border:false,
		    onSelect:rowClick,
		    onDblClickRow:dblClickRow,
			columns : [ [ {
				field : 'id',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'userName',
				title : '操作者',
				width : 100
			}, {
				field : 'story',
				title : '事务名称',
				sortable:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '操作时间',
				sortable:true,
				width : 100
			}, {
				field : 'afterContent',
				title : '操作数据',
				hidden : true,
				width : 200
			}] ],
			toolbar : $Operation.datagrid_menu
		});
		
		function rowClick(){
			var row = $Operation.datagrid.datagrid('getSelected');
			if(row){
				$('#slodm-menu-remove').menubutton('enable');
			}else{
				$('#slodm-menu-remove').menubutton('disable');
			}
		}
		
		function dblClickRow(){
			var row = $Operation.datagrid.datagrid('getSelected');
			dialogOpen('查看',true);
			$Operation.form.form('clear');
			$Operation.form.form('load',$Operation.datagrid.datagrid('getSelected'));
		}
	}
	
	Operation.prototype.search = function() {
		$Operation.datagrid.datagrid('reload', $Operation.searchForm.serializeObject());
	}

	Operation.prototype.del = function() {
		var row = $Operation.datagrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.messager.progress();
					$.post($Operation.delUrl,$Operation.Data_Id(row), function(data) {
						if (data == "success") {
							msgShow('操作成功', getModuleName()+'删除成功.');
							dataGridReload();
							initButtons();
						} else {
							$.messager.alert('删除错误', data, 'error');
						}
						$.messager.progress('close');
					});
				}
			});
			return;
		}
		$.messager.alert('请选择', "请选择要删除的"+getModuleName()+".", 'error');
	}

	
	function dataGridReload(){
		$Operation.datagrid.datagrid('options').url=$Operation.loadUrl;
		$Operation.datagrid.datagrid('reload');
		$Operation.datagrid.datagrid('unselectAll');
		initButtons();
	}
	
	
	function initButtons() {
		$('#slodm-menu-remove').linkbutton('disable');
	}
	
	function dialogOpen(title,read) {
		var tex = '';
		if($Operation.success_refresh){
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
					$Operation.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$Operation.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : '保存',
			iconCls : 'icon-d-save',
			handler : $Operation.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $Operation.close	
		};
		var buttons = [];
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$Operation.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			width : 700,
			iconCls : 'icon-d-info',
			modal : true,
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$Operation.form.form('submit', {
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
					msgShow($Operation.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($Operation.success_refresh);
					if($Operation.success_refresh){//成功后刷新
						dataGridReload();
					}
				} else {
					dialogOpen(successInfo);
					$.messager.alert($Operation.Messager_Title(), data, 'error');
				}
			}
		});
	}

	Operation.prototype.save = function() {
		if ($Operation.button) {
			formSubmit($Operation.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Operation.editUrl,'编辑');// 表单编辑
		}
	}

	Operation.prototype.close = function(url) {
		$Operation.dialog.dialog('close');
	}

	return Operation;
})();
