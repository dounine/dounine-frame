var Login = (function() {

	function Login() {
	}
	
	function getModuleName(){
		return "登录日志";
	}
	
	Login.prototype.Data_Id = function (row){
		return {'loginId':row['loginId']};
	}
	
	Login.prototype.load = function() {
		$Login.datagrid.datagrid({
			url : arguments.length==0?null:$Login.loadUrl,
			rownumbers : true,
			lines:true,
			border:false,
			fitColumns : true,
			singleSelect : true,
			pagination : true,
		    onSelect:rowClick,
			columns : [ [ {
				field : 'loginId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'userName',
				title : '操作者',
				width : 100
			}, {
				field : 'loginIp',
				title : '登录IP',
				sortable:true,
				width : 100
			}, {
				field : 'area',
				title : '登录地址',
				sortable:true,
				width : 200
			}, {
				field : 'loginTimeC',
				title : '登录时间',
				sortable:true,
				width : 100
			}] ],
			toolbar : $Login.datagrid_menu
		});
		
		function rowClick(){
			var row = $Login.datagrid.datagrid('getSelected');
			if(row){
				$('#slldm-menu-remove').menubutton('enable');
			}else{
				$('#slldm-menu-remove').menubutton('disable');
			}
		}
	}
	
	Login.prototype.search = function() {
		$Login.datagrid.datagrid('reload', $Login.searchForm.serializeObject());
	}

	Login.prototype.del = function() {
		var row = $Login.datagrid.datagrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.messager.progress();
					$.post($Login.delUrl,$Login.Data_Id(row), function(data) {
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
		$Login.datagrid.datagrid('options').url=$Login.loadUrl;
		$Login.datagrid.datagrid('reload');
		$Login.datagrid.datagrid('unselectAll');
		initButtons();
	}
	
	
	function initButtons() {
		$('#slldm-menu-remove').linkbutton('disable');
	}

	Login.prototype.save = function() {
		if ($Login.button) {
			formAdd();// 表单添加
		} else {
			formEdit();// 表单编辑
		}
	}

	Login.prototype.close = function(url) {
		dialogClose();
	}

	return Login;
})();
