package com.dounine.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dounine.controller.BaseController;
import com.dounine.domain.product.ProductNav;
import com.dounine.service.product.ProductNavService;

@Controller
@RequestMapping("admin/product/productNav")
public class ProductNavController extends BaseController<ProductNav>{
	
	private static final String pathUrl = "admin/product/productNav/";
	
	@Autowired
	private ProductNavService productNavService;

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {// 模块主内容
		return pathUrl+"content";
	}
	
	@Override
	@RequestMapping(value="all.action", method = RequestMethod.POST)
	@ResponseBody
	public List<ProductNav> all(ProductNav productNav){
		return productNavService.all();
	}
	
	@Override
	@RequestMapping(value="list.action")
	@ResponseBody
	public List<ProductNav> list(ProductNav productNav){//不带分页数据
		return baseService.select(productNav);
	}
	
	

}
