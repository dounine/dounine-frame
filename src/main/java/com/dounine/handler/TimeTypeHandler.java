package com.dounine.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import com.dounine.enumtype.TimeType;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.handler ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:28:32 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 类型的数据类型转换器 ]
 */
public class TimeTypeHandler extends BaseTypeHandler<TimeType> {

	@Override
	public TimeType getNullableResult(ResultSet rs, String columnLabel)
			throws SQLException {
		return TimeType.fromTo(rs.getInt(columnLabel));
	}

	@Override
	public TimeType getNullableResult(ResultSet rs, int columnIndex)
			throws SQLException {
		return TimeType.fromTo(rs.getInt(columnIndex));
	}

	@Override
	public TimeType getNullableResult(CallableStatement cs, int parameterIndex)
			throws SQLException {
		return TimeType.fromTo(cs.getInt(parameterIndex));
	}

	@Override
	public void setNonNullParameter(PreparedStatement ps, int parameterIndex,
			TimeType qe, JdbcType arg3) throws SQLException {
		ps.setInt(parameterIndex, qe.getValue());
	}

}