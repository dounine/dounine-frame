package com.dounine.domain.product;

import com.dounine.domain.BaseDomain;

public class ProductDetail extends BaseDomain {

	private static final long serialVersionUID = -4876752272211673352L;

	private Integer id;
	private String name;
	private Product product;
	private ProductNav productNav;
	private String content;// 内容

	public Integer getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public ProductNav getProductNav() {
		return productNav;
	}

	public void setProductNav(ProductNav productNav) {
		this.productNav = productNav;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
