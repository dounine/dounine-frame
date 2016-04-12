package com.dounine.service.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dounine.annoation.Operator;
import com.dounine.dao.system.KeyBoardDao;
import com.dounine.domain.system.KeyBoard;
import com.dounine.service.BaseService;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.service.system.bug ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:11:14 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 快捷键业务类 ]
 */

@Service
@Operator(name="快捷键")
public class KeyBoardService extends BaseService<KeyBoard> {
	
	@Autowired
	private KeyBoardDao keyBoardDao;

	@Override
	@Operator(story="删除快捷键")
	public void delete(KeyBoard t) {
		keyBoardDao.delete(t);
	}
	
}
