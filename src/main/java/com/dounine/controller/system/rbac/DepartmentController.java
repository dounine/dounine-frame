package com.dounine.controller.system.rbac;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dounine.controller.BaseController;
import com.dounine.domain.system.rbac.Department;
import com.dounine.service.system.rbac.DepartmentService;

@Controller
@RequestMapping("admin/system/rbac/department")
public class DepartmentController extends BaseController<Department>{
	
	private static final String pathUrl = "admin/system/rbac/department/";
	
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping(value="content.html",method=RequestMethod.POST)
	public String content(){//模块主内容
		
		return pathUrl+"content";
		
	}
	
	@RequestMapping(value="find_by_user.action",method=RequestMethod.POST)
	@ResponseBody
	public Collection<?> findByUser(Integer id){
		
		return departmentService.findByUser(id);
		
	}
	
}
