package com.dounine.service.system.rbac;

import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.domain.system.rbac.UserRole;
import com.dounine.service.BaseService;
/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.rbac ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:14:37 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 用户角色业务类 ]
 */
@Service
@Operator(name="用户角色")
public class UserRoleService extends BaseService<UserRole>{

}
