package com.dounine.controller.system.rbac;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.rbac.Role;
import com.dounine.service.system.rbac.RoleService;


@Controller
@RequestMapping("admin/system/rbac/role")
public class RoleController extends BaseController<Role>{
	
	private static final String pathUrl = "admin/system/rbac/role/";
	
	@Autowired
	private RoleService roleService;

	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//模块主内容
		
		return pathUrl+"content";
		
	}
	
	@RequestMapping(value="find_by_user.action",method=RequestMethod.POST)
	@ResponseBody
	public Collection<?> findByUser(Integer id){
		
		return roleService.findByUser(id);
		
	}
	
	@RequestMapping(value="find_by_role.action",method=RequestMethod.POST)
	@ResponseBody
	public Collection<?> findByRole(Integer id){
		
		return roleService.findByRole(id);
		
	}
}
