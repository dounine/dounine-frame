package com.dounine.dao.system.rbac;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dounine.dao.BaseRepository;
import com.dounine.domain.system.rbac.Role;
import com.dounine.domain.system.rbac.User;
import com.dounine.mapper.system.rbac.RoleMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.dao.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:41:35 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 角色数据层实现类 ]
 */
@Repository
public class RoleDao extends BaseRepository<Role>{
	
	@Autowired
	private RoleMapper roleMapper;
	
	public Set<Role> findByUser(User user){
		return roleMapper.findByUser(user);
	}

}
