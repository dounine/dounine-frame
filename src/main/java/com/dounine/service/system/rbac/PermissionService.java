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
import com.dounine.dao.system.rbac.PermissionDao;
import com.dounine.dao.system.rbac.RolePermissionDao;
import com.dounine.domain.system.rbac.Permission;
import com.dounine.domain.system.rbac.RolePermission;
import com.dounine.domain.system.rbac.User;
import com.dounine.enumtype.StatusType;
import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;
import com.dounine.service.BaseService;
import com.dounine.utils.NotDelete;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:14:11 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 权限业务类 ]
 */
@Service
@Operator(name="权限")
@CacheConfig(cacheNames={"permissionCache"})
public class PermissionService extends BaseService<Permission>{
	
	@Autowired
	private RolePermissionDao rolePermissionDao;
	
	@Autowired
	private PermissionDao permissionDao;
	
	@Override
	@Transactional
	@Operator(story = "添加一条权限")
	@CacheEvict(allEntries=true)
	public void insert(Permission permission) {
		if(null==permission.getPermissionParent()||(null!=permission.getPermissionParent()&&null==permission.getPermissionParent().getPermissionId())){
			throw new CustomException(Finals.TREE_PARENT_NODE_NOTEMPTY);
		}
		permission.setCreateTime(new Date());
		super.insert(permission);
	}
	
	public int countA(User user){
		return permissionDao.countA(user);
	}

	@Override
	@Transactional
	@Operator(story = "修改权限信息")
	@CacheEvict(allEntries=true)
	public void update(Permission permission) {
		if(permission.getPermissionId().equals(permission.getPermissionParent().getPermissionId())){
			throw new CustomException(Finals.TREE_NODE_NOT_MYSELF);
		}
		super.update(permission);
	}


	@Override
	public List<Permission> select(Permission permission){
		List<Permission> list =  super.select(permission);
		if( (null==permission) || ((null!=permission)&&null==permission.getPermissionId()) ){
			Permission _permission = super.find(new Permission(Finals.PERMISSION_ROOT_ID));
			if(null!=_permission){
				_permission.setChildren(new ArrayList<Permission>());
				_permission.setState(Finals.TREE_OPEN);
				_permission.getChildren().addAll(list);
				List<Permission> permissions = new ArrayList<Permission>();
				permissions.add(_permission);
				return permissions;
			}
		}
		return list;
	}
	
	@Cacheable(key="#userPermissionId")
	public Collection<Permission> findByUser(Integer userPermissionId){
		if(null==userPermissionId)return null;
		List<Integer> ids = new ArrayList<Integer>();
		Permission permission = find(new Permission(userPermissionId));
		if(null!=permission){
			boolean out = true;
			if(null!=permission.getPermissionParent()&&!permission.getPermissionParent().getPermissionId().equals(Finals.PERMISSION_ROOT_ID)){
				do{
					permission = find(new Permission(permission.getPermissionParent().getPermissionId()));
					if(null!=permission){
						if(null!=permission.getPermissionParent()&&permission.getPermissionParent().getPermissionId().equals(Finals.PERMISSION_ROOT_ID)){
							out = false;
						}
						if(!ids.contains(permission.getPermissionId())){
							ids.add(permission.getPermissionId());
						}
					}
				}while(out);
			}
		}
		List<Permission> _permissions = (List<Permission>) select(null);
		findChildren(_permissions.get(0),ids);
		return _permissions;
	}
	
	@Override
	@Cacheable(key="#permission.permissionId")
	public Permission find(Permission permission) {
		return super.find(permission);
	}

	@Cacheable(key="#lockPermissionId")
	public boolean parentIsLocked(String lockPermissionId){
		if(null==lockPermissionId) return true;
		lockPermissionId = lockPermissionId.substring(Finals.PERMISSION_PARENT_IS_LOCKED_CACHE.length());
		Permission permission = find(new Permission(Integer.parseInt(lockPermissionId)));
		boolean isLocked = false;
		if(null!=permission){
			boolean out = true;
			if(null!=permission.getPermissionParent()&&!permission.getPermissionParent().getPermissionId().equals(Finals.PERMISSION_ROOT_ID)){
				do{
					permission = find(new Permission(permission.getPermissionParent().getPermissionId()));
					if(null!=permission){
						if(null!=permission.getPermissionParent()&&permission.getPermissionParent().getPermissionId().equals(Finals.PERMISSION_ROOT_ID)){
							out = false;
						}
						if(permission.getStatus().equals(StatusType.CONGEAL)){//找到锁定的父级,直接退出
							isLocked = true;
							out = false;//退出循环
						}
					}
				}while(out);
			}
			if(permission.getStatus()==StatusType.CONGEAL){
				isLocked = true;
			}
		}
		return isLocked;
	}
	
	public void findChildren(final Permission permission,List<Integer> parentList){
		if(null!=permission.getChildren()&&permission.getChildren().size()>0&&null!=parentList&&parentList.size()>0){
			for(Permission _permission : permission.getChildren()){
				for(Integer id : parentList){
					if(_permission.getPermissionId().equals(id)){
						parentList.remove(id);
						_permission.setChildren(select(_permission));
						_permission.setState(Finals.TREE_OPEN);
						findChildren(_permission,parentList);
						break;
					}
				}
			}
		}
	}

	@Override
	@Transactional
	@Operator(story = "删除权限信息")
	@CacheEvict(allEntries=true)
	public void delete(Permission permission) {
		NotDelete.delete();
		if(permission.getPermissionId().equals(Finals.PERMISSION_ROOT_ID)){
			throw new CustomException(Finals.ROOT_NODE_NOT_DELETE);
		}
		super.delete(permission);
	}
	
	@Cacheable(key="#rolePermissionId")
	public Collection<Permission> findByRole(Integer rolePermissionId){
		if(null==rolePermissionId)return null;
		List<Integer> ids = new ArrayList<Integer>();
		List<RolePermission> rolePermissions = (List<RolePermission>) rolePermissionDao.select(new RolePermission(rolePermissionId, null));//查询角色下有多少个权限
		for(RolePermission rolePermission : rolePermissions){
			Permission permission = find(new Permission(rolePermission.getPermissionId()));
			if(null!=permission){
				boolean out = true;
				if(null!=permission.getPermissionParent()&&!permission.getPermissionParent().getPermissionId().equals(Finals.PERMISSION_ROOT_ID)){//如果不是root节点
					do{
						permission = find(new Permission(permission.getPermissionParent().getPermissionId()));
						if(null!=permission){
							if(null!=permission.getPermissionParent()&&permission.getPermissionParent().getPermissionId().equals(Finals.PERMISSION_ROOT_ID)){//判断父ID是不是根节点
								out = false;
							}
							if(!ids.contains(permission.getPermissionId())){
								ids.add(permission.getPermissionId());
							}
						}
					}while(out);
				}
			}
		}
		List<Permission> _permissions = (List<Permission>) select(null);//查找根节点，以及根节点下的子节点（两层深度）
		findChildren(_permissions.get(0),ids);
		return _permissions;
	}
	
	public Set<Permission> findByUserAll(User user){
		return permissionDao.findByUserAll(user);
	}
	
	@Cacheable(key="#userName")
	public Set<Permission> findByUserName(String userName){
		return permissionDao.findByUser(new User(userName.substring(Finals.PERMISSION_CACHE_SPLIT.length())));
	}
}
