package com.dounine.controller.system.rbac;

import java.util.HashMap;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dounine.domain.system.log.Operation;
import com.dounine.domain.system.rbac.User;
import com.dounine.service.system.log.OperationService;
import com.dounine.service.system.rbac.LoginService;
import com.dounine.service.system.rbac.PermissionService;

@Controller
@RequestMapping("admin/system/rbac/user/info")
public class AdminInfo {

	@Autowired
	private PermissionService permissionService;
	@Autowired
	private LoginService loginService;
	@Autowired
	private OperationService operationService;

	@RequestMapping(value = "admin_info.html", method = RequestMethod.POST)
	public String admin_info() {
		return "admin/info/operator";
	}

	@RequestMapping(value = "info.html", method = RequestMethod.POST)
	public String info() {
		return "admin/info/info/content";
	}

	@RequestMapping(value = "oper/content.html", method = RequestMethod.POST)
	public String me() {
		return "admin/info/oper/content";
	}

	@RequestMapping(value = "safe/content.html", method = RequestMethod.POST)
	public String safe() {
		return "admin/info/safe/content";
	}

	@RequestMapping(value = "login/content.html", method = RequestMethod.POST)
	public String login() {
		return "admin/info/login/content";
	}

	@RequestMapping(value = "rbac/content.html", method = RequestMethod.POST)
	public String rbac() {
		return "admin/info/rbac/content";
	}

	@RequestMapping(value = "permission/find_by_admin_user.action", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> findByUserPermission(final User user) {

		user.setUserName(String.valueOf(SecurityUtils.getSubject().getPrincipals()));
		return new HashMap<String, Object>() {
			private static final long serialVersionUID = 975714782007778264L;
			{
				put("total", permissionService.countA(user));
				put("rows", permissionService.findByUserAll(user));
			}
		};

	}

	@RequestMapping(value = "login/find_by_admin_user.action", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> findByAdminLogin(final User user) {
		user.setUserName(String.valueOf(SecurityUtils.getSubject().getPrincipals()));
		return new HashMap<String, Object>() {
			private static final long serialVersionUID = 975714782007778264L;
			{
				put("total", loginService.count(user));
				put("rows", loginService.findByUser(user));
			}
		};

	}

	@RequestMapping(value = "operation/find_by_admin_user.action", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> findByAdminOperation(final Operation operation) {
		operation.setUserName(String.valueOf(SecurityUtils.getSubject().getPrincipals()));
		return new HashMap<String, Object>() {
			private static final long serialVersionUID = 975714782007778264L;
			{
				put("total", operationService.count(operation));
				put("rows", operationService.select(operation));
			}
		};

	}
}
