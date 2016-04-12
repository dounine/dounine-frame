var ProductPicture = (function() {

	function ProductPicture() {
	}
	
	function getModuleName(){
		return "框架图片";
	}
	
	ProductPicture.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	ProductPicture.prototype.success_refresh = true;//操作成功后刷新列表
	
	ProductPicture.prototype.Data_Id = function (row){
		return {'id':row['id']};
	}
	
	ProductPicture.prototype.load = function() {
		$ProductPicture.button = true;
		$ProductPicture.datagrid.datagrid({
			url : arguments.length==0?null:$ProductPicture.loadUrl,
			rownumbers : true,
			pagination : true,
			fitColumns : true,
			singleSelect : true,
			nowrap : true,
			striped : true,
			onClickRow : rowClick,
			collapsible : true,
			columns : [ [ {
				field : 'id',
				title : 'ID编号',
				hidden : true,
				width : 100
			},{
				field:'name',
				title:'名称',
				width:100
			}, {
				field : 'smallPath',
				title : '图片预览',
				sortable:true,
				width : 100,
				formatter:function(val,row){
					return '<img height="30" src='+(base+val)+' />';
				}
			}, {
				field : 'sequence',
				title : '排序',
				width : 100
			}, {
				field : 'middlePath',
				title : '中图',
				hidden:true,
				width : 100
			}, {
				field : 'originalPath',
				title : '大图',
				hidden:true,
				width : 100
			}, {
				field : 'createTimeT',
				title : '创建时间',
				sortable:true,
				width : 100
			},{
				field:'action',
				title:'操作',
				formatter:function(val,row,index){
					return '<a style="color:#555555;" href="javascript:void(0);" onclick="$ProductPicture.edit('+row.id+','+index+');">编辑</a> | <a style="color:#555555;" href="javascript:void(0);" onclick="$ProductPicture.del('+row.id+','+index+');">删除</a>';
				}
			} ] ]
		});
		
		function rowClick(){
			var row = $ProductPicture.datagrid.datagrid('getSelected');
			if(row){
				$('#ppcdm-menu-remove').menubutton('enable');
				$('#ppcdm-menu-edit').menubutton('enable');
			}else{
				$('#ppcdm-menu-remove').menubutton('disable');
				$('#ppcdm-menu-edit').menubutton('disable');
			}
		}
	}

	ProductPicture.prototype.del = function(val,index) {
		$ProductPicture.datagrid.datagrid('selectRow',index);
		var row = $ProductPicture.datagrid.datagrid('getSelected');
		$.messager.confirm('删除确认', '您确认要删除这条'+getModuleName()+'么?', function(r) {
			if (r) {
				$.messager.progress();
				$.post($ProductPicture.delUrl, $ProductPicture.Data_Id(row), function(data) {
					if (data == "success") {
						msgShow('操作成功', getModuleName()+'删除成功.');
						$ProductPicture.dataGridReload();
					} else {
						if(dataFilter(data).length>0){
							$.messager.alert('删除错误', data, 'error');
						}
					}
					$.messager.progress('close');
				});
			}
		});
	}

	ProductPicture.prototype.add = function() {
		$.messager.progress('close');
		$ProductPicture.button = true;
		$ProductPicture.form.form('clear');
	}

	ProductPicture.prototype.edit = function(val,index) {
		$.messager.progress('close');
		$ProductPicture.datagrid.datagrid('selectRow',index);
		var row = $ProductPicture.datagrid.datagrid('getSelected');
		$ProductPicture.button = false;
		$ProductPicture.form.form('load', row);
		$("#productPictureUrl").attr('src',row.originalPath);
		$("#productPictureButton").linkbutton('enable').linkbutton({
			'text':'&nbsp;&nbsp;编&nbsp;&nbsp;辑&nbsp;&nbsp;'
		});
	}

	ProductPicture.prototype.search = function() {
		$ProductPicture.datagrid.datagrid('reload', $ProductPicture.searchForm.serializeObject());
	}
	
	function formSubmit(url,successInfo,title) {
		$ProductPicture.form.form('submit', {
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
					msgShow($ProductPicture.Messager_Title(), getModuleName() + successInfo +'成功.');
					$ProductPicture.dataGridReload();
				} else {
					if(dataFilter(data).length>0){
						$.messager.alert($ProductPicture.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	ProductPicture.prototype.save = function() {
		if ($ProductPicture.button) {
			formSubmit($ProductPicture.addUrl,'添加');// 表单添加
		} else {
			formSubmit($ProductPicture.editUrl,'编辑');// 表单编辑
		}
	}
	
	ProductPicture.prototype.dataGridReload = function(){
		$("#productPictureButton").linkbutton('disable').linkbutton({
			'text':'&nbsp;&nbsp;保&nbsp;&nbsp;存&nbsp;&nbsp;'
		});
		$("#productPictureUrl").attr("src",base+'/resource/admin/css/themes/icons/dounine-icon-picture.png');
		$ProductPicture.datagrid.datagrid('reload');
		$ProductPicture.datagrid.datagrid('unselectAll');
	}

	ProductPicture.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$ProductPicture.dialog.dialog('close');
	}
	
	function dataGridReload(){
		$ProductPicture.datagrid.datagrid('reload');
		initButtons();
	}
	
	function initButtons() {
		$('#ppcdm-menu-remove').menubutton('disable');
		$('#ppcdm-menu-edit').menubutton('disable');
	}


	return ProductPicture;
})();
