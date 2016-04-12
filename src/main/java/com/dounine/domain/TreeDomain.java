package com.dounine.domain;

import java.io.Serializable;
import java.util.Collection;


/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:38:29 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 树形基类 ]
 */
public class TreeDomain<T> extends BaseDomain implements Serializable {

	private static final long serialVersionUID = -8123483052398418765L;
	
	protected Collection<T> children;
	protected String state;//easyui 树形
	protected Boolean expand = false;
	public static final String OPEN = "open";//展开
	public static final String CLOSED = "closed";//关闭

	public Collection<T> getChildren() {
		return children;
	}

	public void setChildren(Collection<T> children) {
		this.children = children;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		if (state == null) {
			this.state = null;
		} else {
			if(state.equals(OPEN)){
				this.state = OPEN;
			}else{
				this.state = CLOSED;
			}
		}
	}

	public Boolean getExpand() {
		return expand;
	}

	public void setExpand(Boolean expand) {
		this.expand = expand;
	}
}
