package com.dounine.controller.product;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.product.Product;
import com.dounine.domain.system.rbac.User;
import com.dounine.finals.Finals;
import com.dounine.service.product.ProductService;

@Controller
@RequestMapping("admin/product/product")
public class ProductController extends BaseController<Product>{
	
	@Autowired
	private ProductService productService;
	
	private static final String pathUrl = "admin/product/product/";

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {// 模块主内容
		return pathUrl+"content/content";
	}
	
	@RequestMapping(value="info.html",method=RequestMethod.POST)
	public String info(){//内容
		
		return pathUrl+"info/content";
		
	}

	@Override
	public void add(Product t, HttpServletResponse response) {
		Object object = SecurityUtils.getSubject().getSession().getAttribute(Finals.ADMIN_USER);
		t.setUser((User)object);
		t.setCreateTime(new Date());
		productService.insert(t);
		try {
			response.getWriter().print(SUCCESS+":"+t.getId());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	

}
