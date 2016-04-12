package com.dounine.service.system.bug;

import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.domain.system.bug.BugType;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.bug ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:11:14 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ BUG类型业务类 ]
 */

@Service
@Operator(name="BUG类型")
public class BugTypeService extends BaseService<BugType> {

}
