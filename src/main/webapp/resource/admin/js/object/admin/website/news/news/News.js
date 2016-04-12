var News = (function() {

	function News() {
	}
	
	function getModuleName(){
		return "新闻";
	}
	
	News.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	News.prototype.success_refresh = true;//操作成功后刷新列表
	
	News.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	News.prototype.load = function() {
		$News.datagrid.datagrid({
			url : arguments.length==0?null:$News.loadUrl,
			rownumbers : true,
			lines:true,
			fitColumns : true,
			singleSelect : true,
			pagination : true,
			border:false,
		    onSelect:rowClick,
			columns : [ [ {
				field : 'id',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'title',
				title : '标题',
				sortable:true,
				width : 100
			}, {
				field : 'newsClass',
				title : '版块',
				sortable:true,
				width : 100,
				formatter:function(val,row){
					return val.title;
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
						return '正常';
					}
					return '<font style="color:red">冻结</font>';
				}
			}] ],
			toolbar : $News.datagrid_menu
		});
		
		function rowClick(){
			var row = $News.datagrid.datagrid('getSelected');
			$News.row = row;
			if (row.status == 'NORMAL') {
				$('#wndm-menu-edit').linkbutton('enable');
				$('#wndm-menu-remove').linkbutton('enable');
				$('#wndm-menu-congeal').linkbutton('enable');
				$('#wndm-menu-thaw').linkbutton('disable');
			} else {
				$('#wndm-menu-edit').linkbutton('disable');
				$('#wndm-menu-remove').linkbutton('disable');
				$('#wndm-menu-congeal').linkbutton('disable');
				$('#wndm-menu-thaw').linkbutton('enable');
			}
		}
	}
	
	News.prototype.search = function() {
		$News.datagrid.datagrid('reload', $News.searchForm.serializeObject());
	}
	
	News.prototype.del = function() {
		var row = $News.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($News.delUrl, $News.Data_Id(row), function(data) {
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

	News.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $News.datagrid.datagrid('getSelected');
		$.post($News.congealUrl, $News.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改未解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	News.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $News.datagrid.datagrid('getSelected');
		$.post($News.thawUrl, $News.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	News.prototype.del = function() {
		var row = $News.datagrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.post($News.delUrl, $News.Data_Id(row), function(data) {
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
	
	News.prototype.add = function() {
		$News.button = true;
		$News.show_editor();
	}
	
	News.prototype.edit = function() {
		$News.button = false;
		$News.show_editor();
	}
	
	News.prototype.save = function() {
		if ($News.button) {
			formSubmit($News.addUrl,'添加');// 表单添加
		} else {
			formSubmit($News.editUrl,'编辑');// 表单编辑
		}
	}
	
	
	function formSubmit(url,successInfo,title) {
		$NewsType.form.form('submit', {
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
					msgShow($NewsType.Messager_Title(), getModuleName() + successInfo +'成功.');
				} else {
					$.messager.alert($NewsType.Messager_Title(), data, 'error');
				}
			}
		});
	}

	function dataGridReload(){
		$News.datagrid.datagrid('options').url=$News.loadUrl;
		$News.datagrid.datagrid('reload');
		$News.datagrid.datagrid('unselectAll');
		initButtons();
	}
	
	
	function initButtons() {
		$('#wndm-menu-edit').linkbutton('disable');
		$('#wndm-menu-remove').linkbutton('disable');
		$('#wndm-menu-congeal').linkbutton('disable');
		$('#wndm-menu-thaw').linkbutton('disable');
	}
	
	function dialogClose() {
		$News.dialog.dialog('close');
	}
	
	News.prototype.close = function(url) {
		dialogClose();
	}

	News.prototype.save = function() {
		if ($News.button) {
			formAdd();// 表单添加
		} else {
			formEdit();// 表单编辑
		}
	}

	return News;
})();
