package com.dounine.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import com.dounine.enumtype.SortType;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.handler ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:28:32 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 类型的数据类型转换器 ]
 */
public class SortTypeHandler extends BaseTypeHandler<SortType> {

	@Override
	public SortType getNullableResult(ResultSet rs, String columnLabel)
			throws SQLException {
		return SortType.fromTo(rs.getInt(columnLabel));
	}

	@Override
	public SortType getNullableResult(ResultSet rs, int columnIndex)
			throws SQLException {
		return SortType.fromTo(rs.getInt(columnIndex));
	}

	@Override
	public SortType getNullableResult(CallableStatement cs, int parameterIndex)
			throws SQLException {
		return SortType.fromTo(cs.getInt(parameterIndex));
	}

	@Override
	public void setNonNullParameter(PreparedStatement ps, int parameterIndex,
			SortType qe, JdbcType arg3) throws SQLException {
		ps.setInt(parameterIndex, qe.getValue());
	}

}