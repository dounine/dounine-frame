var Article = (function() {

	function Article() {
	}
	
	function getModuleName(){
		return "文章";
	}
	
	Article.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Article.prototype.success_refresh = true;//操作成功后刷新列表
	
	Article.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	Article.prototype.load = function() {
		$Article.datagrid.datagrid({
			url : arguments.length==0?null:$Article.loadUrl,
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
				field : 'alias',
				title : '别名',
				sortable:true,
				width : 100
			}, {
				field : 'articleClass',
				title : '分类',
				sortable:true,
				width : 100,
				formatter:function(val,row){
					return val.name;
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
			toolbar : $Article.datagrid_menu
		});
		
		function rowClick(){
			var row = $Article.datagrid.datagrid('getSelected');
			$Article.row = row;
			if (row.status == 'NORMAL') {
				$('#wadm-menu-edit').linkbutton('enable');
				$('#wadm-menu-remove').linkbutton('enable');
				$('#wadm-menu-congeal').linkbutton('enable');
				$('#wadm-menu-thaw').linkbutton('disable');
			} else {
				$('#wadm-menu-edit').linkbutton('disable');
				$('#wadm-menu-remove').linkbutton('disable');
				$('#wadm-menu-congeal').linkbutton('disable');
				$('#wadm-menu-thaw').linkbutton('enable');
			}
		}
	}
	
	Article.prototype.search = function() {
		$Article.datagrid.datagrid('reload', $Article.searchForm.serializeObject());
	}
	
	Article.prototype.del = function() {
		var row = $Article.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($Article.delUrl, $Article.Data_Id(row), function(data) {
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

	Article.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $Article.datagrid.datagrid('getSelected');
		$.post($Article.congealUrl, $Article.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改未解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Article.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $Article.datagrid.datagrid('getSelected');
		$.post($Article.thawUrl, $Article.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Article.prototype.del = function() {
		var row = $Article.datagrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.post($Article.delUrl, $Article.Data_Id(row), function(data) {
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
	
	Article.prototype.add = function() {
		$Article.button = true;
		$Article.show_editor();
	}
	
	Article.prototype.edit = function() {
		$Article.button = false;
		$Article.show_editor();
	}
	
	Article.prototype.save = function() {
		if ($Article.button) {
			formSubmit($Article.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Article.editUrl,'编辑');// 表单编辑
		}
	}
	
	
	function formSubmit(url,successInfo,title) {
		$ArticleType.form.form('submit', {
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
					msgShow($ArticleType.Messager_Title(), getModuleName() + successInfo +'成功.');
				} else {
					$.messager.alert($ArticleType.Messager_Title(), data, 'error');
				}
			}
		});
	}

	function dataGridReload(){
		$Article.datagrid.datagrid('options').url=$Article.loadUrl;
		$Article.datagrid.datagrid('reload');
		$Article.datagrid.datagrid('unselectAll');
		initButtons();
	}
	
	
	function initButtons() {
		$('#wadm-menu-edit').linkbutton('disable');
		$('#wadm-menu-remove').linkbutton('disable');
		$('#wadm-menu-congeal').linkbutton('disable');
		$('#wadm-menu-thaw').linkbutton('disable');
	}
	
	function dialogClose() {
		$Article.dialog.dialog('close');
	}
	
	Article.prototype.close = function(url) {
		dialogClose();
	}

	Article.prototype.save = function() {
		if ($Article.button) {
			formAdd();// 表单添加
		} else {
			formEdit();// 表单编辑
		}
	}

	return Article;
})();
