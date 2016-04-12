package com.dounine.mapper.system.rbac;

import java.util.Set;

import com.dounine.domain.system.rbac.Login;
import com.dounine.domain.system.rbac.Permission;
import com.dounine.domain.system.rbac.User;
import com.dounine.mapper.BaseMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.mapper.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:06:52 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 登录映射接口 ]
 */
public interface LoginMapper extends BaseMapper<Login>{

	public Set<Permission> findByUserAll(User user);
	
	public Login getLastLogin(User user);
}
