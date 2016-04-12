package com.dounine.dao.system.rbac;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dounine.dao.BaseRepository;
import com.dounine.domain.system.rbac.Permission;
import com.dounine.domain.system.rbac.User;
import com.dounine.mapper.system.rbac.PermissionMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.dao.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:40:38 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 权限资源数据业实现类 ]
 */
@Repository
public class PermissionDao  extends BaseRepository<Permission>{

	@Autowired
	private PermissionMapper permissionMapper;
	
	public Set<Permission> findByUserAll(User user){
		return permissionMapper.findByUserAll(user);
	}
	
	public Set<Permission> findByUser(User user){
		return permissionMapper.findByUser(user);
	}
	
	public int countA(User user){
		return permissionMapper.countA(user);
	}
}
