var Role = (function() {

	function Role() {
	}
	
	function getModuleName(){
		return "角色";
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
	
	Role.prototype.Messager_Title = function(){
		return '温馨提示';
	}
	
	Role.prototype.success_refresh = true;//操作成功后刷新列表
	
	Role.prototype.Data_Id = function (row){
		return {'roleId':row['roleId']};
	}
	
	Role.prototype.load = function() {
		$Role.treegrid.treegrid({
			url : arguments.length==0?null:$Role.loadUrl,
			rownumbers : true,
			lines:true,
			fitColumns : true,
			idField:'roleId',
			border:false,
		    treeField:'roleName',
		    onSelect:rowClick,
			columns : [ [ {
				field : 'roleId',
				title : 'ID编号',
				hidden : true,
				width : 100
			}, {
				field : 'roleName',
				title : '名称',
				width : 100
			}, {
				field : 'rolePermissions',
				title : '权限列表',
				hidden:true,
				width : 100
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
				field : 'roleDescription',
				title : '角色描述',
				width : 100
			} ] ],
			onBeforeExpand:function (node) {
				$Role.treegrid.treegrid('options').url = $Role.loadUrl+'&roleId='+node.roleId;
	        },
			toolbar : $Role.treegrid_menu
		});
		
		function rowClick(){
			var row = $Role.treegrid.treegrid('getSelected');
			if(row.status=='NORMAL'){
				$('#surtm-menu-edit').menubutton('enable');
				$('#surtm-menu-remove').menubutton('enable');
				$('#surtm-menu-congeal').menubutton('enable');
				$('#surtm-menu-thaw').menubutton('disable');
			}else{
				$('#surtm-menu-edit').menubutton('disable');
				$('#surtm-menu-remove').menubutton('disable');
				$('#surtm-menu-congeal').menubutton('disable');
				$('#surtm-menu-thaw').menubutton('enable');
			}
			if(row.roleId==1){
				initButtons();
			}
		}
	}

	Role.prototype.del = function() {
		var row = $Role.treegrid.treegrid('getSelected');
		if (row) {
			$.messager.confirm('删除确认', "您确认要删除这条"+getModuleName()+"么?", function(r) {
				if (r) {
					$.messager.progress();
					$.post($Role.delUrl,$Role.Data_Id(row) , function(data) {
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

	Role.prototype.add = function() {
		dialogOpen('添加');
		$Role.button = true;
		$($Role.roleParent).combotree('destroy').remove();
		$($Role.rolePermissions).combotree('destroy').remove();
		$Role.form.form('clear');
		
		var roleParent = addParent(true);//重新添加combotree
		addPermission();
		
		roleParent.combotree('loadData',$Role.treegrid.treegrid('getRoots'));
		var node = null;
		if($Role.treegrid.treegrid('getSelected')){
			node = $Role.treegrid.treegrid('getSelected');
		}else{
			node = $Role.treegrid.treegrid('getRoot');
		}
		roleParent.combotree('setValue',node.roleId);
	}

	Role.prototype.edit = function() {
		dialogOpen('编辑');
		$Role.button = false;
		var row = $Role.treegrid.treegrid('getSelected');
		
		$($Role.roleParent).combotree('destroy').remove();//清空原来的combotree对象
		$($Role.rolePermissions).combotree('destroy').remove();//清空原来的combotree对象
		$Role.form.form('load', row);//必需放在销毁后面,创建前面。
		
		addPermission(row.roleId);//重新添加combotree
		var roleParent = addParent();//重新添加combotree
		roleParent.combotree('loadData',$Role.treegrid.treegrid('getRoots'));
		roleParent.combotree('setValue', row.roleParent.roleId);
		
	}

	Role.prototype.congeal = function() {// 冻结
		$.messager.progress('close');
		$.messager.progress();
		var row = $Role.treegrid.treegrid('getSelected');
		$.post($Role.congealUrl,$Role.Data_Id(row), function(data) {
			$.messager.progress('close');
			if (data == "success") {
				msgShow('操作成功', getModuleName()+'冻结成功.');
				treeGridReload();
			} else {
				$.messager.alert('冻结错误', data, 'error');
			}
		});
	}

	Role.prototype.thaw = function() {// 解冻
		$.messager.progress('close');
		$.messager.progress();
		var row = $Role.treegrid.treegrid('getSelected');
		$.post($Role.thawUrl, $Role.Data_Id(row), function(data) {
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
		if($Role.success_refresh){
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
					$Role.success_refresh = false;
					input1.removeAttr('checked',false);
					$(this).find('font').text('操作成功后不刷新');
				}else{
					$Role.success_refresh = true;
					input1.attr('checked',true);
					$(this).find('font').text('操作成功后刷新');
				}
			}
		},save_btn = {
			text : title,
			iconCls : 'icon-d-save',
			handler : $Role.save
		},close_btn = {
			text : '取消',
			iconCls : 'icon-d-close',
			handler : $Role.close	
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
		$Role.dialog.show().dialog({
			title : '&nbsp;'+title+getModuleName(),
			buttons : buttons
		});
	}
	
	function formSubmit(url,successInfo,title) {
		$Role.form.form('submit', {
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
					msgShow($Role.Messager_Title(), getModuleName() + successInfo +'成功.');
					dialogClose($Role.success_refresh);
					if($Role.success_refresh){//成功后刷新
						treeGridReload();
					}
				} else {
					dialogOpen(successInfo);
					if(dataFilter(data).length>0){
						$.messager.alert($Role.Messager_Title(), data, 'error');
					}
				}
			}
		});
	}

	Role.prototype.save = function() {
		if ($Role.button) {
			formSubmit($Role.addUrl,'添加');// 表单添加
		} else {
			formSubmit($Role.editUrl,'编辑');// 表单编辑
		}
	}

	Role.prototype.close = function(url) {
		dialogClose();
	}
	
	function dialogClose() {
		$Role.dialog.dialog('close');
	}
	
	function treeGridReload(){
		$Role.treegrid.treegrid('options').url=$Role.loadUrl;
		$Role.treegrid.treegrid('reload');
		$Role.treegrid.treegrid('unselectAll');
		initButtons();
	}
	
	function addParent(){
		var roleParent = $('<table name="roleParent.roleId" id="roleParent" style="width:494px;"></table>').appendTo($($Role.roleParentBox));
		addLoadingCount();
		roleParent.combotree({
			url:arguments.length==1?$Role.loadUrl:null,
			valueField:'roleId',
			textField:'roleName',
			lines : true,
			editable: false,
			required:true,
			onLoadSuccess:function(){
				delLoadingCount();
			},
			onBeforeExpand:function (node) {
				roleParent.combotree('tree').tree('options').url = $Role.loadUrl+'&roleId='+node.roleId;
	        }
		});
		return roleParent;
	}
	
	function addPermission(id){
		var permission = $('<table name="rolePermissions" multiple id="rolePermissions" style="width:494px;"></table>').appendTo($Role.rolePermissionsBox);
		var isFirst = true;
		addLoadingCount();
		permission.combotree({
			url:id?($Role.findPermissionUrl+'&id='+id):$Role.permissionUrl,
			valueField:'permissionId',
			textField:'permissionName',
			editable: false,
			lines : true,
			onLoadSuccess:function(){
				var self = permission;
				delLoadingCount();
				if(id&&isFirst){
					addLoadingCount();
					$.post($Role.rolePermissionUrl,{'roleId':$Role.treegrid.treegrid('getSelected').roleId},function(data){
						if(data.rolePermissions){
							self.combotree('setValues',data.rolePermissions);
						}
						delLoadingCount();
					});
				}
			},
			onBeforeExpand:function (node) {
				permission.combotree('tree').tree('options').url = $Role.permissionUrl+'&permissionId='+node.permissionId;
				isFirst = false;
	        }
		});
		return permission;
	}
	
	function initButtons() {
		$('#surtm-menu-edit').linkbutton('disable');
		$('#surtm-menu-remove').linkbutton('disable');
		$('#surtm-menu-congeal').menubutton('disable');
		$('#surtm-menu-thaw').menubutton('disable');
	}

	return Role;
})();
