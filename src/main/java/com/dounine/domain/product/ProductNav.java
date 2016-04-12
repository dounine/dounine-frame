package com.dounine.domain.product;

import com.dounine.domain.TreeDomain;

public class ProductNav extends TreeDomain<ProductNav> {

	private static final long serialVersionUID = -623875937200043830L;

	private Integer id;
	private String name;
	private ProductNav parent;
	private String description;
	
	public ProductNav(){
		
	}
	
	public ProductNav(Integer id){
		this.id = id;
	}

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

	public ProductNav getParent() {
		return parent;
	}

	public void setParent(ProductNav parent) {
		this.parent = parent;
	}


	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
