<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://dounine.com/dounine-frame/csrf.tld" prefix="dounine-csrf" %>
<form method="post" id="admin_info_safe_form" >
	<table class="easyui-grid">
		<tr>
			<td>用户名称:</td>
			<td>
				<input style="width: 200px;" editable="false" type="text" class="easyui-textbox" value="${adminCurrentUserInfo.userName}" required="required" />
			</td>
			<td>所属部门:</td>
			<td>
				<input style="width: 200px;" editable="false"  value="${adminCurrentUserInfo.department.departmentName}" type="text" class="easyui-textbox" />
			</td>
		</tr>
		<tr>
			<td>旧密码:</td>
			<td>
				<input style="width: 200px;" id="safeOldPassword" type="password" class="easyui-textbox" name="oldPassword" required="required" />
			</td>
			<td>新密码:</td>
			<td>
				<input style="width: 200px;" id="safeNewPassword" name="userPassword" type="password" class="easyui-textbox"  required="required"/>
			</td>
		</tr>
		<tr>
			<td colspan="4" id="admin_info_safe_msg"></td>
		</tr>
		<tr>
			<td colspan="4"><a href="javascript:void(0);" onclick="admin_info_safe_form_submit();" iconCls="icon-d-save" class="easyui-linkbutton"> 修 改 </a></td>
		</tr>
	</table>
</form>
<script>
	function admin_info_safe_form_submit(){
		$("#admin_info_safe_form").form('submit', {
			url : '<dounine-csrf:token-value uri="${base}/admin/system/rbac/user/update_password.action" />'+_userUrl,
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
				$("#safeOldPassword,#safeNewPassword").textbox('setValue','');
				if (data == 'success') {
					$("#admin_info_safe_msg").text("密码修改成功,请重新登录!!");
				} else {
					$.messager.alert('温馨提示', data, 'error');
				}
			}
		});
	}
</script>