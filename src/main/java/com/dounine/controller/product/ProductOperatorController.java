package com.dounine.controller.product;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.product.Product;

@Controller
@RequestMapping("admin/product")
public class ProductOperatorController extends BaseController<Product>{
	
	private static final String pathUrl = "admin/product/";

	@RequestMapping(value="product_menu.html",method=RequestMethod.POST)
	public String menu(){//加载模块菜单 
		
		return pathUrl+"menu";
		
	}
	
	@RequestMapping(value="operator.html",method=RequestMethod.POST)
	public String operator(){
		
		return pathUrl+"product/operator";
		
	}
}
