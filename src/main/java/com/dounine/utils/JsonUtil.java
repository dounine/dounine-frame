package com.dounine.utils;

import java.util.Collection;

import org.apache.commons.lang.StringUtils;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * json工具类
 * @author huanghuanlai
 *
 */
public class JsonUtil {
	
	private static class JsonHolder{
		private static final ObjectMapper mapper = new ObjectMapper();
	}

	/**
	 * 返回成功执行的操作json
	 * @param info
	 * @return
	 */
	public String success(String info,boolean addStr){
		if(addStr){
			return "{success:true,info:'"+info.trim()+"'}";
		}else{
			return "{success:true,info:"+info.trim()+"}";
		}
	}
	
	/**
	 * 返回失败执行的操作json
	 * @param info
	 * @return
	 */
	public String failure(String info,boolean addStr){
		if(addStr){
			return "{success:false,info:'"+StringUtils.trim(info)+"'}";
		}else{
			return "{success:false,info:"+info.trim()+"}";
		}
	}
	
	/**
	 * 将一个对象解析成Json数据格式
	 * @param object
	 * @return
	 */
	public String toJson(Object object){
		try {
			return JsonHolder.mapper.writeValueAsString(object);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 构建对象json数据
	 * @param values 数据集合
	 * @param excludes 忽略的列
	 * @return
	 */
	public String buildList(Object total,Collection<?> list,String excludes){
		StringBuilder sb = new StringBuilder();
		sb.append("{\"total\":\"");
		sb.append(String.valueOf(total));
		sb.append("\",\"rows\":[");
		JsonConfig cfg = new JsonConfig();
		String[] excluds = null;
		if(StringUtils.isNotEmpty(excludes)&&StringUtils.isNotEmpty(StringUtils.trim(excludes))){
			excluds = StringUtils.split(",");
			if(StringUtils.length(excludes)>0){
				cfg.setExcludes(excluds);
			}
		}
		cfg.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		for(Object object : list){
			//声明json配置对象
			//设置循环策略为忽略、避免死循环
			JSONObject jsonObject = JSONObject.fromObject(object,cfg);
			sb.append(String.valueOf(jsonObject));
			sb.append(",");
		}
		if(list.size()>0){
			sb.deleteCharAt(sb.length()-1);
		}
		sb.append("]}");
		return String.valueOf(sb);
	}
}
