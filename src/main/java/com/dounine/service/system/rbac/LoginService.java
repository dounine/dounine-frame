package com.dounine.service.system.rbac;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.NoOperator;
import com.dounine.annoation.Operator;
import com.dounine.dao.system.rbac.LoginDao;
import com.dounine.dao.system.rbac.UserDao;
import com.dounine.domain.system.rbac.Login;
import com.dounine.domain.system.rbac.User;
import com.dounine.service.BaseService;
import com.dounine.utils.NotDelete;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:14:02 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 权限类型业务类 ]
 */
@Service
@Operator(name="登录日志")
public class LoginService extends BaseService<Login>{
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private LoginDao loginDao;

	@Override
	@Transactional
	@NoOperator
	public void insert(Login login) {
		login.setUserId(userDao.find(new User(login.getUserName())).getUserId());
		login.setLoginTime(new Date());
		super.insert(login);
	}

	public Collection<Login> findByUser(User user){
		Login login =new Login();
		login.setUserId(userDao.find(user).getUserId());
		login.setRows(user.getRows());
		login.setPage(user.getPage());
		return super.select(login);
	}
	
	public long count(User user){
		return (Long)super.count(new Login(userDao.find(user).getUserName()));
	}

	@Override
	@Operator(story = "删除登录信息")
	public void delete(Login login) {
		NotDelete.delete();
		super.delete(login);
	}
	
	
	public Login getLastLogin(User user){
		return loginDao.getLastLogin(user);
	}
}
