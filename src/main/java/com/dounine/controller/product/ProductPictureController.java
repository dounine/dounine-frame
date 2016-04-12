package com.dounine.controller.product;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.product.ProductPicture;

@Controller
@RequestMapping("admin/product/productPicture")
public class ProductPictureController extends BaseController<ProductPicture>{
	
	private static final String pathUrl = "admin/product/productPicture/";

	@RequestMapping(value = "content.html", method = RequestMethod.POST)
	public String content() {// 模块主内容
		return pathUrl+"content";
	}

}
