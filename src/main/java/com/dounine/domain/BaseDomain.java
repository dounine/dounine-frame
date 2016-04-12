package com.dounine.domain;

import java.io.IOException;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dounine.annoation.Excel;
import com.dounine.annoation.Operator;
import com.dounine.enumtype.StatusType;
import com.dounine.finals.Finals;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

/**
 * @ProjectName: [ 逗你呢框架管理系统 ]
 * @Package: [ com.dounine.domain ]
 * @Author: [ huanghuanlai ]
 * @CreateTime: [ 2015年2月4日 上午10:37:08 ]
 * @Copy: [ dounine.com ]
 * @Version: [ v1.0 ]
 * @Description: [ 实体类的基类 ]
 */
@SuppressWarnings("all")
@Operator
public class BaseDomain extends JsonSerializer<Date> implements Serializable {

	public static final SimpleDateFormat TIMESTAMP = new SimpleDateFormat(
			Finals.TIMESTAMP);
	public static final SimpleDateFormat DATETIME = new SimpleDateFormat(
			Finals.DATETIME);

	private int offSet = 0;

	private int page = 0;

	private int rows = 10;

	private String sort;

	private String order;

	public StatusType status;
	@Excel(name = "创建时间")
	public Date createTime;

	public Integer sequence;

	private String ids;

	public int getOffSet() {
		return offSet;
	}

	public void setOffSet(int offSet) {
		this.offSet = offSet;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public int getPage() {
		return page > 0 ? page : 0;
	}

	public void setPage(int page) {
		this.page = page;
		if (page > 0)
			this.offSet = (page - 1) * rows;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public StatusType getStatus() {
		return status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public String getCreateTimeT() {
		if (null != createTime) {
			try {
				return TIMESTAMP.format(createTime);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public String getCreateTimeD() {
		if (null != createTime) {
			try {
				return DATETIME.format(createTime);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public void setStatus(StatusType status) {
		this.status = status;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
		if (page > 0) {
			this.offSet = (page - 1) * rows;
		}
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	@Override
	public void serialize(Date date, JsonGenerator jsonGenerator,
			SerializerProvider serializerProvider) throws IOException,
			JsonProcessingException {
		jsonGenerator.writeString(TIMESTAMP.format(date));
	}
}
