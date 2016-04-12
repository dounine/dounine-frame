var Permission = (function() {

	function Permission() {
	}
	
	function getModuleName(){
		return "权限资源";
	}
	
	var loadingCount = 0;
	var loadingImg = $(loadingImgObj);
	
	function delLoadingCount(){
		loadingCount--;
		if(loadingCount<=0){
			loadingImg.hide();
		}
	}
	
	function addLoadingCount(){
		loadingCount++;
		if(loadingCount>0){
			loadingImg.show();
		}
	}
	
	Permission.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Permission.prototype.success_refresh = true;//操作成功后刷新列表
	
	Permission.prototype.Data_Id = function (row){
		return {'permissionId':row['permissionId']};
	}
	
	Permission.prototype.load = function() {
		$Permission.treegrid.treegrid({
			url : arguments.length==0?null:$Permission.loadUrl,
			rownumbers : true,
			border:false,
			lines:true,
			fitColumns : true,
			idField:'permissionId',
		    treeField:'permissionName',
		    onSelect:rowClick,
			columns : [ [ {
				field : 'permissionId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'permissionName',
				title : '权限名称',
				width : 200
			}, {
				field : 'permissionResource',
				title : '权限资源',
				width : 200
			}, {
				field : 'permissionType',
				title : '权限类型',
				width : 100,
				formatter:function(val,row){
					if(val){
						return val.permissionTypeName;
					}
				}
			}, {
				field : 'permissionParent',
				title : '上级权限',
				hidden : true,
				width : 100,
				formatter:function(val,row){
					if(val){
						return val.permissionName;
					}else{
						return '<p style="color:red">无</p>';
					}
				}
			}, {
				field : 'createTimeT',
				title : '创建时间',
				width : 100
			}, {
				field : 'status',
				title : '权限状态',
				formatter : function(val, row) {
					if (val=='NORMAL') {
						return '正常';
					} else {
						return '<font style="color:red">冻结</font>';
					}
				},
				width : 100
			}, {
				field : 'permissionDescription',
				title : '权限资源描述',
				width : 100
			} ] ],
			onBeforeExpand:function (node) {
				$Permission.treegrid.treegrid('options').url = $Permission.loadUrl+'&permissionId='+node.permissionId;
	        },
			toolbar : $Permission.treegrid_menu
		});
		
		function rowClick(){
			var row = $Permission.treegrid.treegrid('getSelected');
			if(row.status=='NORMAL'){
				$('#suptm-menu-edit').menubutton('enable');
				$('#suptm-menu-remove').menubutton('enable');
				$('#suptm-menu-congeal').menubutton('enable');
				$('#suptm-menu-thaw').menubutton('disable');
			}else{
				$('#suptm-menu-edit').menubutton('disable');
				$('#suptm-menu-remove').menubutton('disable');
				$('#suptm-menu-congeal').menubutton('disable');
				$('#suptm-menu-thaw').menubutton('enable');
			}
			if(row.permissionId==1){
				initButtons();
			}
		}
	}

	Permission.prototype.del = function() {
		var row = $Permission.treegrid.treegrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.messager.progress();
					$.post($Permission.delUrl, $Permission.Data_Id(row) , function(data) {
						if (data == "success") {
							msgShow('操作成功', getModuleName()+'删除成功.');
							treeGridReload();
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

	Permission.prototype.add = function() {
		dialogOpen('添加');
		$Permission.button = true;
		$.messager.progress('close');
		$($Permission.permissionParent).combotree('destroy').remove()
		$Permission.form.form('clear');
		var node = $Permission.treegrid.treegrid('getSelected');
		if(node){
			var permissionParent = addParent(null,node.permissionId);//重新添加combotree
			$Permission.permissionResource.textbox('setValue',node.permissionResource.slice(0,-1));
			permissionParent.combotree('loadData',$Permission.treegrid.treegrid('getRoots'));
			permissionParent.combotree('setValue',node.permissionId);
		}else{
			addParent($Permission.loadUrl,$Permission.treegrid.treegrid('getRoot').permissionId);
		}
		addLoadingCount();
		$Permission.type.combogrid({
			panelWidth:134,
			editable:false,	
			required:true,
			onLoadSuccess:function(){
				delLoadingCount();
			},
			url:$Permission.typeUrl,
			idField:'permissionTypeId',
			textField:'permissionTypeName',
			columns:[[
			          {
			        	  field:'permissionTypeName',
			        	  width:110
			          }
			    ]]
		});
	}

	Permission.prototype.edit = function() {
		dialogOpen('编辑');
		$Permission.button = false;
		$.messager.progress('close');
		var row = $Permission.treegrid.treegrid('getSelected');
		$($Permission.permissionParent).combotree('destroy').remove();//清空原来的combotree对象
		$Permission.form.form('load', row);
		
		var permissionParent = addParent();//重新添加combotree
		permissionParent.combotree('loadData',$Permission.treegrid.treegrid('getRoots'));
		permissionParent.combotree('setValue', row.permissionParent.permissionId);
		addLoadingCount();
		$Permission.type.combogrid({
			panelWidth:134,
			editable:false,	
			required:true,
			url:$Permission.typeUrl,
			idField:'permissionTypeId',
			textField:'permissionTypeName',
			onLoadSuccess:function(){
				$Permission.type.combogrid('setValue',row.permissionType.permissionTypeId);
				delLoadingCount();
			},
			columns:[[
			          {
			        	  field:'permissionTypeName',
			        	  width:110
			          }
			    ]]
		});
	}

	Permission.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $Permission.treegrid.treegrid('getSelected');
		$.post($Permission.congealUrl, $Permission.Data_Id(row) , function(data) {
			$.messager.progress('close');
			if (data == "success") {
				msgShow('操作成功', getModuleName()+'冻结成功.');
				treeGridReload();
			} else {
				$.messager.alert('冻结错误', data, 'error');
			}
		});
	}

	Permission.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $Permission.treegrid.treegrid('getSelected');
		$.post($Permission.thawUrl,$Permission.Data_Id(row) , function(data) {
			$.messager.progress('close');
			if (data == "success") {
				msgShow('操作成功', getModuleName()+'解冻成功.');
				treeGridReload();
			} else {
				$.messager.alert('解冻错误', data, 'error');
			}
		});
	}

	function dialogOpen(title,read) {
		$.messager.progress('close');
		var tex = '';
		if($Permission.success_refresh){
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
					$Permission.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$Permission.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $Permission.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $Permission.close	
		},loading_btn = {
			plain:true,
			text:loadingImg[0]
		};
		var buttons = [];
		buttons.push(loading_btn);
		if(read){
			$.extend(close_btn,{text:'关闭'});//克隆属性
		}else{
			buttons.push(ref_title);
			buttons.push(save_btn);
		}
		buttons.push(close_btn);
		$Permission.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$Permission.form.form('submit', {
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
					msgShow($Permission.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($Permission.success_refresh);
					if($Permission.success_refresh){//成功后刷新
						treeGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($Permission.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	Permission.prototype.save = function() {
		if ($Permission.button) {
			formSubmit($Permission.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Permission.editUrl,'编辑');// 表单编辑
		}
	}

	Permission.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$Permission.dialog.dialog('close');
	}
	
	function treeGridReload(){
		$Permission.treegrid.treegrid('options').url=$Permission.loadUrl;
		$Permission.treegrid.treegrid('reload');
		$Permission.treegrid.treegrid('unselectAll');
		initButtons();
	}
	
	function addParent(url,id){
		var permissionParent = $('<table name="permissionParent.permissionId" id="permissionParent" style="width:494px;"></table>').appendTo($($Permission.permissionParentBox));
		addLoadingCount();
		permissionParent.combotree({
			url:url?url:null,
			valueField:'permissionId',
			textField:'permissionName',
			lines : true,
			editable: false,
			required:true,
			onLoadSuccess:function(){
				if(id){
					permissionParent.combotree('setValue',id);
				}
				delLoadingCount();
			},
			onBeforeExpand:function (node) {
				permissionParent.combotree('tree').tree('options').url = $Permission.loadUrl+'&permissionId='+node.permissionId;
	        }
		});
		return permissionParent;
	}
	
	function initButtons() {
		$('#suptm-menu-edit').linkbutton('disable');
		$('#suptm-menu-remove').linkbutton('disable');
		$('#suptm-menu-congeal').menubutton('disable');
		$('#suptm-menu-thaw').menubutton('disable');
	}

	return Permission;
})();
