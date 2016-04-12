package com.dounine.service.system.rbac;

import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.dao.system.rbac.UserDao;
import com.dounine.dao.system.rbac.UserRoleDao;
import com.dounine.domain.system.rbac.User;
import com.dounine.domain.system.rbac.UserRole;
import com.dounine.enumtype.StatusType;
import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;
import com.dounine.service.BaseService;
import com.dounine.utils.PasswordHash;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:15:13 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 用户业务类 ]
 */
@Service
@Operator(name = "用户")
@CacheConfig(cacheNames = {"userCache"})  
public class UserService extends BaseService<User> {

	@Autowired
	private UserRoleDao userRoleDao;
	@Autowired
	private UserDao userDao;

	@Override
	@Transactional
	@Operator(story = "添加一个用户")
	@CacheEvict(allEntries=true)
	public synchronized void insert(User user) {
		if (StringUtils.isNotEmpty(user.getUserPassword())
				&& StringUtils.isNotEmpty(user.getUserPassword().trim())
				&& StringUtils.length(user.getUserPassword().trim()) < 20) {
			try {
				user.setUserPassword(PasswordHash.createHash(user.getUserPassword()));
			} catch (NoSuchAlgorithmException e) {
				throw new CustomException(e);
			} catch (InvalidKeySpecException e) {
				throw new CustomException(e);
			}
		} else {
			throw new CustomException(Finals.PASSWORD_NOT_STANDARD);
		}
		user.setCreateTime(new Date());
		super.insert(user);// 要获取插入后的ID
		if (null != user.getUserRoles() && user.getUserRoles().length > 0) {
			for (Integer id : user.getUserRoles()) {
				userRoleDao.insert(new UserRole(user.getUserId(), id));
			}
		}
	}

	@Override
	@Cacheable(key="#user.userName")
	public User find(User user) {
		User _user = super.find(user);
		if (null != _user) {
			List<UserRole> userRoles = (List<UserRole>) userRoleDao
					.select(new UserRole(_user.getUserId(), null));
			Integer[] ids = new Integer[userRoles.size()];
			for (int i = 0; i < userRoles.size(); i++) {
				ids[i] = userRoles.get(i).getRoleId();
			}
			_user.setUserRoles(ids);
			return _user;
		}
		return null;
	}
	
	
	public void check_password(String userPassword){
		Subject subject = SecurityUtils.getSubject();
		if(null!=subject){
			User user = find(new User(String.valueOf(subject.getPrincipals())));
			if(null!=user){
				try {
					if(!PasswordHash.validatePassword(userPassword,user.getUserPassword())){
						throw new CustomException(Finals.USER_PASSWORD_VERIFY);
					}
				} catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
					throw new CustomException(Finals.USER_PASSWORD_VERIFY);
				} catch (InvalidKeySpecException e) {
					e.printStackTrace();
					throw new CustomException(Finals.USER_PASSWORD_VERIFY);
				}
			}
		}else{
			throw new CustomException(Finals.LOGIN_AFTER_OPERATOR);
		}
	}
	
	

	@Override
	@CacheEvict(allEntries=true)
	public void congeal(User user) {
		super.congeal(user);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void thaw(User user) {
		super.thaw(user);
	}

	@Override
	@Transactional
	@Operator(story = "修改用户信息")
	@CacheEvict(key = "#user.userName")
	public void update(User user) {
		if (StringUtils.isNotEmpty(user.getUserPassword())
				&& StringUtils.isNotEmpty(user.getUserPassword().trim())
				&& StringUtils.length(user.getUserPassword().trim()) < 20) {
			try {
				user.setUserPassword(PasswordHash.createHash(user.getUserPassword()));
			} catch (NoSuchAlgorithmException e) {
				throw new CustomException(e);
			} catch (InvalidKeySpecException e) {
				throw new CustomException(e);
			}
		}
		user.setUserId(userDao.find(user).getUserId());
		userRoleDao.delete(new UserRole(user.getUserId(), null));
		if (null != user.getUserRoles() && user.getUserRoles().length > 0) {
			for (Integer id : user.getUserRoles()) {
				userRoleDao.insert(new UserRole(user.getUserId(), id));
			}
		}
		super.update(user);
	}

	@Override
	@Transactional
	@Operator(story = "删除用户信息")
	@CacheEvict(allEntries=true)
	public void delete(User user) {
		if (user.getUserName().equals(Finals.ADMIN_NAME_STRING)) {
			throw new CustomException(Finals.ROOT_ADMIN_NOT_DELETE);
		}
		userRoleDao.delete(new UserRole(userDao.find(user).getUserId(), null));
		super.delete(user);
	}

	@Override
	public List<User> select(User user) {
		return super.select(user);
	}

	@Transactional
	@Operator(story = "修改密码")
	public void updatePassword(String oldPassword, String userPassword) {
		Subject subject = SecurityUtils.getSubject();
		if (subject.isAuthenticated()) {
			String userName = String.valueOf(subject.getPrincipal());

			if (userName.equals(Finals.ADMIN_NAME_STRING)) {
				throw new CustomException(Finals.BOX_PROGRAMMER_PASSWORD);
			}
			User user = super.find(new User(userName));
			if (user.getStatus().equals(StatusType.NORMAL)) {
				try {
					if (PasswordHash.validatePassword(oldPassword,
							user.getUserPassword())) {
						User _user = new User();
						_user.setUserId(user.getUserId());
						_user.setUserPassword(PasswordHash
								.createHash(userPassword));
						super.update(_user);
						subject.logout();
					} else {
						throw new CustomException(
								Finals.USERPASSWORD_NOT_EQUALS);
					}
				} catch (NoSuchAlgorithmException e) {
					throw new CustomException(Finals.PASSWORD_VERIFY_ERROR);
				} catch (InvalidKeySpecException e) {
					throw new CustomException(Finals.PASSWORD_VERIFY_ERROR);
				}
			} else {
				throw new CustomException(Finals.ACCOUNT_STATUS_NOT_NORMAL);
			}
		} else {
			throw new CustomException(Finals.LOGIN_AFTER_OPERATOR);
		}
	}

}
