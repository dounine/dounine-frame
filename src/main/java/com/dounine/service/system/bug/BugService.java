package com.dounine.service.system.bug;

import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.domain.system.bug.Bug;
import com.dounine.domain.system.rbac.User;
import com.dounine.enumtype.StatusType;
import com.dounine.exception.CustomException;
import com.dounine.finals.Finals;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.bug ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:10:41 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ BUG业务类 ]
 */
@Service
@Operator(name="BUG")
@CacheConfig(cacheNames={"bugCache"})
public class BugService extends BaseService<Bug> {

	@Override
	@Operator(story = "添加一条BUG")
	@CachePut(key="#bug.bugId")
	public void insert(Bug bug) {
		Subject subject = SecurityUtils.getSubject();
		if(subject.isAuthenticated()){
			bug.setCreateTime(new Date());
			bug.setStatus(StatusType.CONGEAL);
			bug.setUser((User)subject.getSession().getAttribute(Finals.ADMIN_USER));
			super.insert(bug);
		}else{
			throw new CustomException(Finals.LOGIN_AFTER_OPERATOR);
		}
	}

	@Override
	@CacheEvict(key="#bug.bugId")
	public void update(Bug bug) {
		super.update(bug);
	}

	@Override
	@CacheEvict(key="#bug.bugId")
	public void delete(Bug bug) {
		super.delete(bug);
	}
	
	@Override
	public List<Bug> select(Bug bug) {
		return super.select(bug);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void congeal(Bug bug) {
		super.congeal(bug);
	}

	@Override
	@CacheEvict(allEntries=true)
	public void thaw(Bug bug) {
		super.thaw(bug);
	}

	@Override
	@Cacheable(key="#bug.bugId")
	public Bug find(Bug bug) {
		return super.find(bug);
	}
	
}
