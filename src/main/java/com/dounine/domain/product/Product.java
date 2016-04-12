package com.dounine.domain.product;

import com.dounine.domain.BaseDomain;
import com.dounine.domain.system.rbac.User;

public class Product extends BaseDomain {

	private static final long serialVersionUID = -1560244749952427002L;

	private Integer id;
	private String name;
	private ProductClass productClass;
	private User user;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ProductClass getProductClass() {
		return productClass;
	}

	public void setProductClass(ProductClass productClass) {
		this.productClass = productClass;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
