package com.dounine.dao.system.rbac;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dounine.dao.BaseRepository;
import com.dounine.domain.system.rbac.Login;
import com.dounine.domain.system.rbac.Permission;
import com.dounine.domain.system.rbac.User;
import com.dounine.mapper.system.rbac.LoginMapper;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.dao.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:40:16 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 登录日志数据层实现类 ]
 */
@Repository
public class LoginDao  extends BaseRepository<Login>{
	
	@Autowired
	private LoginMapper loginMapper;

	public Set<Permission> findByUserAll(User user){
		return loginMapper.findByUserAll(user);
	}
	
	public Login getLastLogin(User user){
		return loginMapper.getLastLogin(user);
	}
}
