package com.dounine.domain.system.cache;

import com.dounine.domain.BaseDomain;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.domain.system.cache ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:35:47 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 文件缓存实体类 ]
 */
public class Filecache extends BaseDomain{

	private static final long serialVersionUID = -7501929814523789580L;
	
	private Integer fileCacheId;
	private String fileCacheName;
	private String fileCacheResource;
	private String fileCacheDescription;
	
	public Integer getFileCacheId() {
		return fileCacheId;
	}
	public void setFileCacheId(Integer fileCacheId) {
		this.fileCacheId = fileCacheId;
	}
	public String getFileCacheName() {
		return fileCacheName;
	}
	public void setFileCacheName(String fileCacheName) {
		this.fileCacheName = fileCacheName;
	}
	public String getFileCacheResource() {
		return fileCacheResource;
	}
	public void setFileCacheResource(String fileCacheResource) {
		this.fileCacheResource = fileCacheResource;
	}
	public String getFileCacheDescription() {
		return fileCacheDescription;
	}
	public void setFileCacheDescription(String fileCacheDescription) {
		this.fileCacheDescription = fileCacheDescription;
	}
	
	
}
