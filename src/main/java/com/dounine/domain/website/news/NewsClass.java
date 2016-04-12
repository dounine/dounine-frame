package com.dounine.domain.website.news;

import com.dounine.domain.BaseDomain;
import com.dounine.enumtype.SortType;
import com.dounine.enumtype.TimeType;

/**
 * @author Administrator
 *
 */
public class NewsClass extends BaseDomain {

	private static final long serialVersionUID = -8569752877218825146L;
	private Integer id;
	private String title;
	private Boolean showPaging = Boolean.TRUE;// 是否显示分页3小按钮
	private Integer pagingCount;// 每页显示多少条
	private TimeType timeType;// 显示时间格式
	private SortType sortType;// 排序方式
	private String description;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getShowPaging() {
		return showPaging;
	}

	public void setShowPaging(Boolean showPaging) {
		this.showPaging = showPaging;
	}

	public Integer getPagingCount() {
		return pagingCount;
	}

	public void setPagingCount(Integer pagingCount) {
		this.pagingCount = pagingCount;
	}

	public TimeType getTimeType() {
		return timeType;
	}

	public void setTimeType(TimeType timeType) {
		this.timeType = timeType;
	}

	public SortType getSortType() {
		return sortType;
	}

	public void setSortType(SortType sortType) {
		this.sortType = sortType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
