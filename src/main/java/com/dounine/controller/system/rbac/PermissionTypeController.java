package com.dounine.controller.system.rbac;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.rbac.PermissionType;

@Controller
@RequestMapping("admin/system/rbac/permissiontype")
public class PermissionTypeController extends BaseController<PermissionType>{
	
	private static final String pathUrl = "admin/system/rbac/permission/type/";
	

	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//模块主内容
		
		return pathUrl+"content";
		
	}

}
