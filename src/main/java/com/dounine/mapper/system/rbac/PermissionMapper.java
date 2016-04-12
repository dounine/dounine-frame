package com.dounine.mapper.system.rbac;

import java.util.Set;

import com.dounine.domain.system.rbac.Permission;
import com.dounine.domain.system.rbac.User;
import com.dounine.mapper.BaseMapper;

/**
 * 
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.mapper.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:07:06 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 权限资源映射接口 ]
 */
public interface PermissionMapper extends BaseMapper<Permission>{

	public Set<Permission> findByUserAll(User user);
	
	public Set<Permission> findByUser(User user);
	
	public int countA(User user);
}
