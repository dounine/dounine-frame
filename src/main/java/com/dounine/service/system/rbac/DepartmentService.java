package com.dounine.service.system.rbac;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dounine.annoation.Operator;
import com.dounine.domain.system.rbac.Department;
import com.dounine.enumtype.StatusType;
import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;
import com.dounine.service.BaseService;
import com.dounine.utils.NotDelete;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:13:52 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 部门业务类 ]
 */
@Service
@Operator(name="部门")
@CacheConfig(cacheNames = {"departmentCache"})  
public class DepartmentService extends BaseService<Department> {
	
	@Override
	@Transactional
	@Operator(story="添加部门数据")
	@CacheEvict(allEntries=true)
	public void insert(Department department) {
		if(null==department.getDepartmentParent()||(null!=department.getDepartmentParent()&&null==department.getDepartmentParent().getDepartmentId())){//不能使用(==)(超过-127~127范围就无法判断了)
			throw new CustomException(Finals.TREE_PARENT_NODE_NOTEMPTY);
		}
		department.setCreateTime(new Date());
		super.insert(department);
	}
	
	@Override
	public List<Department> select(Department department){
		List<Department> list =  super.select(department);
		if( (null==department) || ((null!=department)&&null==department.getDepartmentId()) ){//如果ID为空则搜索ROOT根节点下一级节点数据
			Department _department = super.find(new Department(Finals.DEPARTMENT_ROOT_ID));
			if(null!=_department){
				_department.setChildren(new ArrayList<Department>());
				_department.setState(Finals.TREE_OPEN);//设置Tree根节点为打开状态
				_department.getChildren().addAll(list);//把查询到节点加到根节点下
				List<Department> departments = new ArrayList<Department>();
				departments.add(_department);
				return departments;
			}
		}
		return list;
	}
	
	public Collection<Department> findByUser(Integer userDepartmentId){
		if(null==userDepartmentId) return null;
		List<Integer> ids = new ArrayList<Integer>();
		Department department = find(new Department(userDepartmentId));
		if(null!=department){
			boolean out = true;
			if(null!=department.getDepartmentParent()&&!department.getDepartmentParent().getDepartmentId().equals(Finals.DEPARTMENT_ROOT_ID)){//如果不是root节点
				do{
					department = find(new Department(department.getDepartmentParent().getDepartmentId()));//查询自身及父亲节点
					if(null!=department){
						if(null!=department.getDepartmentParent()&&department.getDepartmentParent().getDepartmentId().equals(Finals.DEPARTMENT_ROOT_ID)){//如果是root节点就停止向上级搜索节点
							out = false;//退出循环
						}
						if(!ids.contains(department.getDepartmentId())){
							ids.add(department.getDepartmentId());//加到搜索ID列表
						}
					}
				}while(out);
			}
		}
		List<Department> _departments = (List<Department>) this.select(null);
		findChildren(_departments.get(0),ids);
		return _departments;
	}
	
	@Cacheable(key="#departmentId")
	public boolean parentIsLocked(String departmentId){//父级是否已经被锁定
		if(null==departmentId) return true;
		departmentId = departmentId.substring(Finals.DEPARTMENT_PARENT_IS_LOCKED_CACHE.length());//目的是为了启动缓存而组装的ID
		Department department = find(new Department(Integer.parseInt(departmentId)));
		boolean isLocked = false;
		if(null!=department){
			boolean out = true;
			if(null!=department.getDepartmentParent()&&!department.getDepartmentParent().getDepartmentId().equals(Finals.DEPARTMENT_ROOT_ID)){//如果不是root节点
				do{
					department = find(new Department(department.getDepartmentParent().getDepartmentId()));//查询自身及父亲节点
					if(null!=department){
						if(null!=department.getDepartmentParent()&&department.getDepartmentParent().getDepartmentId().equals(Finals.DEPARTMENT_ROOT_ID)){//如果是root节点就停止向上级搜索节点
							out = false;//退出循环
						}
						if(department.getStatus().equals(StatusType.CONGEAL)){//找到锁定的父级,直接退出
							isLocked = true;
							out = false;//退出循环
						}
					}
				}while(out);
			}
			if(department.getStatus()==StatusType.CONGEAL){
				isLocked = true;
			}
		}
		return isLocked;
	}
	
	public void findChildren(final Department department,List<Integer> parentList){
		if(null!=department.getChildren()&&department.getChildren().size()>0){
			for(Department _department : department.getChildren()){
				for(Integer id : parentList){
					if(_department.getDepartmentId().equals(id)){
						parentList.remove(id);//减少下次循环
						_department.setChildren(this.select(_department));//查找当前节点下的孩子节点
						_department.setState(Finals.TREE_OPEN);
						findChildren(_department,parentList);
						break;
					}
				}
			}
		}
	}

	@Override
	@Transactional
	@Operator(story = "删除部门信息")
	@CacheEvict(allEntries=true)
	public void delete(Department department) {
		NotDelete.delete();
		if(department.getDepartmentId().equals(Finals.DEPARTMENT_ROOT_ID)){
			throw new CustomException(Finals.ROOT_NODE_NOT_DELETE);
		}
		super.delete(department);
	}

	@Override
	@Transactional
	@Operator(story = "修改部门信息")
	@CachePut(key="#department.departmentId")
	public void update(Department department) {
		if(department.getDepartmentId().equals(department.getDepartmentParent().getDepartmentId())){
			throw new CustomException(Finals.TREE_NODE_NOT_MYSELF);
		}
		super.update(department);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void congeal(Department t) {
		super.congeal(t);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void thaw(Department t) {
		super.thaw(t);
	}

	
}
