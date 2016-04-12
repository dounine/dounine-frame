package com.dounine.controller.system.rbac;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("admin/system/rbac")
public class RbacOperatorController {
	
	private static final String pathUrl = "admin/system/rbac/";

	@RequestMapping(value="operator.html",method=RequestMethod.POST)
	public String operator(){
		
		return pathUrl+"operator";
		
	}
}
