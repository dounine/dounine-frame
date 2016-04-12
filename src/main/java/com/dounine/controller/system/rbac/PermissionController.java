package com.dounine.controller.system.rbac;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.rbac.Permission;
import com.dounine.service.system.rbac.PermissionService;

@Controller
@RequestMapping("admin/system/rbac/permission")
public class PermissionController extends BaseController<Permission>{
	
	private static final String pathUrl = "admin/system/rbac/permission/";

	@Autowired
	private PermissionService permissionService;
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//模块主内容
		
		return pathUrl+"content";
		
	}
	
	@RequestMapping(value="find_by_user.action",method=RequestMethod.POST)
	@ResponseBody
	public Collection<Permission> findByUser(Integer id){
		
		return permissionService.findByUser(id);
		
	}
	
	@RequestMapping(value="find_by_role.action",method=RequestMethod.POST)
	@ResponseBody
	public Collection<Permission> findByRole(Integer id){
		
		return permissionService.findByRole(id);
		
	}
	
}
