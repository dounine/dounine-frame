var Product = (function() {

	function Product() {
	}
	
	function getModuleName(){
		return "框架";
	}
	
	Product.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Product.prototype.success_refresh = true;//操作成功后刷新列表
	
	Product.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	Product.prototype.load = function() {
		$Product.datagrid.datagrid({
			url : arguments.length==0?null:$Product.loadUrl,
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
				field : 'name',
				title : '名称',
				sortable:true,
				width : 100
			}, {
				field : 'productClass',
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
			},{
				field:'sequence',
				title:'排序',
				width:100
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
			toolbar : $Product.datagrid_menu
		});
		
		function rowClick(){
			var row = $Product.datagrid.datagrid('getSelected');
			$Product.row = row;
			if (row.status == 'NORMAL') {
				$('#pdm-menu-edit').linkbutton('enable');
				$('#pdm-menu-remove').linkbutton('enable');
				$('#pdm-menu-congeal').linkbutton('enable');
				$('#pdm-menu-thaw').linkbutton('disable');
			} else {
				$('#pdm-menu-edit').linkbutton('disable');
				$('#pdm-menu-remove').linkbutton('disable');
				$('#pdm-menu-congeal').linkbutton('disable');
				$('#pdm-menu-thaw').linkbutton('enable');
			}
		}
	}
	
	Product.prototype.search = function() {
		$Product.datagrid.datagrid('reload', $Product.searchForm.serializeObject());
	}
	
	Product.prototype.del = function() {
		var row = $Product.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($Product.delUrl, $Product.Data_Id(row), function(data) {
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

	Product.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $Product.datagrid.datagrid('getSelected');
		$.post($Product.congealUrl, $Product.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改未解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Product.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $Product.datagrid.datagrid('getSelected');
		$.post($Product.thawUrl, $Product.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == 'success') {
				msgShow('温馨提示', getModuleName()+'修改解决状态成功.');
				dataGridReload();
			} else {
				$.messager.alert('温馨提示', data, 'error');
			}
		});
	}

	Product.prototype.del = function() {
		var row = $Product.datagrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.post($Product.delUrl, $Product.Data_Id(row), function(data) {
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
	
	Product.prototype.add = function() {
		$Product.button = true;
		$Product.row = null;
		$Product.show_editor();
	}
	
	Product.prototype.edit = function() {
		$Product.button = false;
		$Product.show_editor();
	}
	
	Product.prototype.save = function() {
		if ($Product.button) {
			formSubmit($Product.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Product.editUrl,'编辑');// 表单编辑
		}
	}
	
	
	function formSubmit(url,successInfo,title) {
		$ProductType.form.form('submit', {
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
					msgShow($ProductType.Messager_Title(), getModuleName() + successInfo +'成功.');
				} else {
					$.messager.alert($ProductType.Messager_Title(), data, 'error');
				}
			}
		});
	}

	function dataGridReload(){
		$Product.datagrid.datagrid('options').url=$Product.loadUrl;
		$Product.datagrid.datagrid('reload');
		$Product.datagrid.datagrid('unselectAll');
		initButtons();
	}
	
	
	function initButtons() {
		$('#pdm-menu-edit').linkbutton('disable');
		$('#pdm-menu-remove').linkbutton('disable');
		$('#pdm-menu-congeal').linkbutton('disable');
		$('#pdm-menu-thaw').linkbutton('disable');
	}
	
	function dialogClose() {
		$Product.dialog.dialog('close');
	}
	
	Product.prototype.close = function(url) {
		dialogClose();
	}

	Product.prototype.save = function() {
		if ($Product.button) {
			formAdd();// 表单添加
		} else {
			formEdit();// 表单编辑
		}
	}

	return Product;
})();
