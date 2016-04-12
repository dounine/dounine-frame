package com.dounine.domain.system;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName: [ 逗你呢框架管理系统 ]
 * @Package: [ com.dounine.domain.system ]
 * @Author: [ huanghuanlai ]
 * @CreateTime: [ 2015年2月4日 上午10:36:26 ]
 * @Copy: [ dounine.com ]
 * @Version: [ v1.0 ]
 * @Description: [ 快捷键实体类 ]
 */
public class KeyBoard extends BaseDomain {

	private static final long serialVersionUID = -1774070547838683228L;

	private Integer keyBoardId;
	private String name;
	private String description;
	private Integer userId;
	private String url;
	private String picture;

	public Integer getKeyBoardId() {
		return keyBoardId;
	}

	public void setKeyBoardId(Integer keyBoardId) {
		this.keyBoardId = keyBoardId;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
