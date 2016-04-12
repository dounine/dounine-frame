package com.dounine.service.system.rbac;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.dao.system.rbac.RoleDao;
import com.dounine.dao.system.rbac.RolePermissionDao;
import com.dounine.dao.system.rbac.UserRoleDao;
import com.dounine.domain.system.rbac.Role;
import com.dounine.domain.system.rbac.RolePermission;
import com.dounine.domain.system.rbac.User;
import com.dounine.domain.system.rbac.UserRole;
import com.dounine.enumtype.StatusType;
import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:14:31 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 角色业务类 ]
 */
@Service
@Operator(name="角色")
@CacheConfig(cacheNames = {"roleCache"})  
public class RoleService extends BaseService<Role>{
	
	@Autowired
	private RolePermissionDao rolePermissionDao;
	
	@Autowired
	private UserRoleDao userRoleDao;
	
	@Autowired
	private RoleDao roleDao;

	@Override
	@Transactional
	@Operator(story = "添加一条角色")
	@CacheEvict(allEntries=true)
	public void insert(Role role) {
		if(null==role.getRoleParent()||(null!=role.getRoleParent()&&null==role.getRoleParent().getRoleId())){
			throw new CustomException(Finals.TREE_PARENT_NODE_NOTEMPTY);
		}
		role.setCreateTime(new Date());
		super.insert(role);
		if(null!=role.getRolePermissions()&&role.getRolePermissions().length>0){
			for(Integer id : role.getRolePermissions()){
				rolePermissionDao.insert(new RolePermission(role.getRoleId(),id));
			}
		}
	}
	
	@Override
	public Role find(Role role) {
		Role _role = super.find(role);
		if(null!=_role){
			List<RolePermission> rolePermissions = (List<RolePermission>) rolePermissionDao.select(new RolePermission(_role.getRoleId(), null));
			Integer[] ids = new Integer[rolePermissions.size()];
			for(int i =0;i<rolePermissions.size();i++){
				ids[i] = rolePermissions.get(i).getPermissionId();
			}
			_role.setRolePermissions(ids);
			return _role;
		}
		return null;
	}


	@Override
	@Transactional
	@Operator(story = "修改角色信息")
	@CacheEvict(allEntries=true)
	public void update(Role role) {
		if(role.getRoleId().equals(role.getRoleParent().getRoleId())){
			throw new CustomException(Finals.TREE_NODE_NOT_MYSELF);
		}
		rolePermissionDao.delete(new RolePermission(role.getRoleId(), null));
		if(null!=role.getRolePermissions()&&role.getRolePermissions().length>0){
			for(Integer id : role.getRolePermissions()){
				rolePermissionDao.insert(new RolePermission(role.getRoleId(),id));
			}
		}
		super.update(role);
	}

	@Override
	public List<Role> select(Role role){
		List<Role> list =  super.select(role);
		if( (null==role) || ((null!=role)&&null==role.getRoleId()) ){
			Role _role = super.find(new Role(Finals.ROLE_ROOT_ID));
			if(null!=_role){
				_role.setChildren(new ArrayList<Role>());
				_role.setState(Finals.TREE_OPEN);
				_role.getChildren().addAll(list);
				List<Role> roles = new ArrayList<Role>();
				roles.add(_role);
				return roles;
			}
		}
		return list;
	}
	
	@Cacheable(key="#userId")
	public Collection<Role> findByRole(Integer userId){
		if(null==userId)return null;
		List<Integer> ids = new ArrayList<Integer>();
		List<UserRole> userRoles = (List<UserRole>) userRoleDao.select(new UserRole(userId, null));//查询用户下有多少个角色
		for(UserRole userRole : userRoles){
			Role role = (find(new Role(userRole.getRoleId())));
			if(null!=role){
				boolean out = true;
				if(null!=role.getRoleParent()&&!role.getRoleParent().getRoleId().equals(Finals.ROLE_ROOT_ID)){//如果不是root节点
					do{
						role = find(new Role(role.getRoleParent().getRoleId()));
						if(null!=role){
							if(null!=role.getRoleParent()&&role.getRoleParent().getRoleId().equals(Finals.ROLE_ROOT_ID)){
								out = false;
							}
							if(ids.contains(role.getRoleId())){
								ids.add(role.getRoleId());
							}
						}
					}while(out);
				}
			}
		}
		List<Role> roles = (List<Role>) select(null);//查找根节点，以及根节点下的子节点（两层深度）
		findChildren(roles.get(0),ids);
		return roles;
	}
	
	@Cacheable(key="#userRoleId")
	public Collection<Role> findByUser(Integer userRoleId){
		if(null==userRoleId)return null;
		List<Integer> ids = new ArrayList<Integer>();
		Role role = find(new Role(userRoleId));
		if(null!=role){
			boolean out = true;
			if(role.getRoleParent()!=null&&!role.getRoleParent().getRoleId().equals(Finals.ROLE_ROOT_ID)){//如果不是root节点
				do{
					role = find(new Role(role.getRoleParent().getRoleId()));
					if(null!=role){
						if(role.getRoleParent()!=null&&role.getRoleParent().getRoleId().equals(Finals.ROLE_ROOT_ID)){
							out = false;
						}
						if(ids.contains(role.getRoleId())){
							ids.add(role.getRoleId());
						}
					}
				}while(out);
			}
		}
		List<Role> _roles = (List<Role>) select(null);
		findChildren(_roles.get(0),ids);
		return _roles;
	}
	
	@Cacheable(key="#roleLockedId")
	public boolean parentIsLocked(String roleLockedId){
		if(null==roleLockedId) return true;
		roleLockedId = roleLockedId.substring(Finals.ROLE_PARENT_IS_LOCKED_CACHE.length());
		Role role = find(new Role(Integer.parseInt(roleLockedId)));
		boolean isLocked = false;
		if(null!=role){
			boolean out = true;
			if(role.getRoleParent()!=null&&!role.getRoleParent().getRoleId().equals(Finals.ROLE_ROOT_ID)){//如果不是root节点
				do{
					role = find(new Role(role.getRoleParent().getRoleId()));
					if(null!=role){
						if(role.getRoleParent()!=null&&role.getRoleParent().getRoleId().equals(Finals.ROLE_ROOT_ID)){
							out = false;
						}
						if(role.getStatus().equals(StatusType.CONGEAL)){//找到锁定的父级,直接退出
							isLocked = true;
							out = false;//退出循环
						}
					}
				}while(out);
			}
			if(role.getStatus()==StatusType.CONGEAL){
				isLocked = true;
			}
		}
		return isLocked;
	}
	
	public void findChildren(final Role role,List<Integer> parentList){
		if(null!=role.getChildren()&&role.getChildren().size()>0&&null!=parentList&&parentList.size()>0){
			for(Role _role : role.getChildren()){
				for(Integer id : parentList){
					if(_role.getRoleId().equals(id)){
						parentList.remove(id);//减少下次循环
						_role.setChildren(select(_role));//查找当前节点下有多少孩子节点
						_role.setState(Finals.TREE_OPEN);
						findChildren(_role,parentList);
						break;
					}
				}
			}
		}
	}

	@Override
	@Transactional
	@Operator(story = "删除角色信息")
	@CacheEvict(allEntries=true)
	public void delete(Role role) {
		if(role.getRoleId().equals(Finals.ROLE_ROOT_ID)){
			throw new CustomException(Finals.ROOT_NODE_NOT_DELETE);
		}
		rolePermissionDao.delete(new RolePermission(role.getRoleId(),null));
		super.delete(role);
	}
	
	@Cacheable(key="#userName")
	public Set<Role> findByUserName(String userName){
		return roleDao.findByUser(new User(userName.substring(Finals.ROLE_CACHE_SPLIT.length())));
	}
	
}
