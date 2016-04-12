var Bug = (function() {

	function Bug() {
	}
	
	function getModuleName(){
		return "BUG";
	}
	
	Bug.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Bug.prototype.success_refresh = true;//操作成功后刷新列表
	
	Bug.prototype.Data_Id = function (row){
		return {'bugId':row['bugId']};
	}
	
	Bug.prototype.load = function() {
		$Bug.datagrid.datagrid({
			url : arguments.length==0?null:$Bug.loadUrl,
			rownumbers : true,
			lines:true,
			fitColumns : true,
			singleSelect : true,
			pagination : true,
			border:false,
		    onSelect:rowClick,
			columns : [ [ {
				field : 'bugId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'bugName',
				title : '名称',
				sortable:true,
				width : 100
			}, {
				field : 'user',
				title : '创建人',
				width : 100,
				formatter:function(val,row){
					return val.userName;
				}
			}, {
				field : 'bugType',
				title : '类型',
				sortable:true,
				width : 100,
				formatter:function(val,row){
					return val.bugTypeName;
				}
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			}, {
				field : 'status',
				title : '状态',
				sortable:true,
				width : 100,
				formatter:function(val,row){
					if(val=='NORMAL'){
						return '已解决';
					}
					return '<font style="color:red">未解决</font>';
				}
			}] ],
			toolbar : $Bug.datagrid_menu
		});
		
		function rowClick(){
			var row = $Bug.datagrid.datagrid('getSelected');
			$Bug.row = row;
			if (row.status == 'NORMAL') {
				$('#sbdm-menu-edit').linkbutton('disable');
				$('#sbdm-menu-remove').linkbutton('disable');
				$('#sbdm-menu-congeal').linkbutton('enable');
				$('#sbdm-menu-thaw').linkbutton('disable');
			} else {
				$('#sbdm-menu-edit').linkbutton('enable');
				$('#sbdm-menu-remove').linkbutton('enable');
				$('#sbdm-menu-congeal').linkbutton('disable');
				$('#sbdm-menu-thaw').linkbutton('enable');
			}
		}
	}
	
	Bug.prototype.search = function() {
		$Bug.datagrid.datagrid('reload', $Bug.searchForm.serializeObject());
	}
	
	Bug.prototype.del = function() {
		var row = $Bug.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($Bug.delUrl, $Bug.Data_Id(row), function(data) {
					if (data == "success") {
						msgShow('操作成功', getModuleName()+'删除成功.');
						dataGridReload();
					} else {
						$.messager.alert('删除错误', data, 'error');
					}
					$.messager.progress('close');
				});
			}
		});
	}

	Bug.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $Bug.datagrid.datagrid('getSelected');
		$.post($Bug.congealUrl, $Bug.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改未解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Bug.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $Bug.datagrid.datagrid('getSelected');
		$.post($Bug.thawUrl, $Bug.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Bug.prototype.del = function() {
		var row = $Bug.datagrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.post($Bug.delUrl, $Bug.Data_Id(row), function(data) {
						if (data == "success") {
							msgShow('操作成功', getModuleName()+'删除成功.');
							dataGridReload();
							initButtons();
						} else {
							$.messager.alert('删除错误', data, 'error');
						}
					});
				}
			});
			return;
		}
		$.messager.alert('请选择', "请选择要删除的"+getModuleName()+".", 'error');
	}
	
	Bug.prototype.add = function() {
		$Bug.button = true;
		$Bug.show_editor();
	}
	
	Bug.prototype.edit = function() {
		$Bug.button = false;
		$Bug.show_editor();
	}
	
	Bug.prototype.save = function() {
		if ($Bug.button) {
			formSubmit($Bug.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Bug.editUrl,'编辑');// 表单编辑
		}
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
				} else {
					$.messager.alert($BugType.Messager_Title(), data, 'error');
				}
			}
		});
	}

	function dataGridReload(){
		$Bug.datagrid.datagrid('options').url=$Bug.loadUrl;
		$Bug.datagrid.datagrid('reload');
		$Bug.datagrid.datagrid('unselectAll');
		initButtons();
	}
	
	
	function initButtons() {
		$('#sbdm-menu-edit').linkbutton('disable');
		$('#sbdm-menu-remove').linkbutton('disable');
		$('#sbdm-menu-congeal').linkbutton('disable');
		$('#sbdm-menu-thaw').linkbutton('disable');
	}
	
	function dialogClose() {
		$Bug.dialog.dialog('close');
	}
	
	Bug.prototype.close = function(url) {
		dialogClose();
	}

	Bug.prototype.save = function() {
		if ($Bug.button) {
			formAdd();// 表单添加
		} else {
			formEdit();// 表单编辑
		}
	}

	return Bug;
})();
