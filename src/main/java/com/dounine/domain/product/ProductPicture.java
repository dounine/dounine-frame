package com.dounine.domain.product;

import com.dounine.domain.BaseDomain;

public class ProductPicture extends BaseDomain {

	private static final long serialVersionUID = 5140311910566171165L;

	private Integer id;
	private Product product;
	private String smallPath;// 小图
	private String middlePath;// 中图
	private String originalPath;// 原图
	private String name;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Product getProduct() {
		return product;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getSmallPath() {
		return smallPath;
	}

	public void setSmallPath(String smallPath) {
		this.smallPath = smallPath;
	}

	public String getMiddlePath() {
		return middlePath;
	}

	public void setMiddlePath(String middlePath) {
		this.middlePath = middlePath;
	}

	public String getOriginalPath() {
		return originalPath;
	}

	public void setOriginalPath(String originalPath) {
		this.originalPath = originalPath;
	}

}
