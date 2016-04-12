package com.dounine.mapper.system.rbac;

import java.util.Set;

import com.dounine.domain.system.rbac.Role;
import com.dounine.domain.system.rbac.User;
import com.dounine.mapper.BaseMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.mapper.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:07:54 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 角色映射接口 ]
 */
public interface RoleMapper extends BaseMapper<Role>{

	public Set<Role> findByUser(User user);

}
