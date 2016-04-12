package com.dounine.controller;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dounine.annoation.Excel;
import com.dounine.domain.BaseDomain;
import com.dounine.enumtype.StatusType;
import com.dounine.finals.Finals;
import com.dounine.service.BaseService;
import com.dounine.utils.ExcelUtil;


public abstract class BaseController<T extends BaseDomain> {

	public static final String SUCCESS = Finals.SUCCESS;
	
	public static final String FAILURE = Finals.FAILURE;
	
	@Autowired
	protected BaseService<T> baseService;
	
	@RequestMapping(value="add.action",method=RequestMethod.POST)
	public void add(T t,HttpServletResponse response){//添加
		t.setCreateTime(new Date());
		baseService.insert(t);
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
			try {
				response.getWriter().print(e.getMessage());
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}
	
	@RequestMapping(value="edit.action",method=RequestMethod.POST)
	public void edit(T t,HttpServletResponse response){//修改
		baseService.update(t);
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
			try {
				response.getWriter().print(e.getMessage());
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}
	
	@RequestMapping(value="del.action",method=RequestMethod.POST)
	public void del(T t,HttpServletResponse response){//删除
		baseService.delete(t);
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
			try {
				response.getWriter().print(e.getMessage());
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}
	
	@RequestMapping(value="congeal.action",method=RequestMethod.POST)
	public void congeal(T t,HttpServletResponse response){//冻结
		t.setStatus(StatusType.CONGEAL);
		baseService.congeal(t);
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
			try {
				response.getWriter().print(e.getMessage());
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}
	
	@RequestMapping(value="thaw.action",method=RequestMethod.POST)
	public void thaw(T t,HttpServletResponse response){//解冻
		t.setStatus(StatusType.NORMAL);
		baseService.thaw(t);
		try {
			response.getWriter().print(SUCCESS);
		} catch (IOException e) {
			e.printStackTrace();
			try {
				response.getWriter().print(e.getMessage());
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		
	}
	
	@RequestMapping(value="list.action")
	@ResponseBody
	public List<T> list(T t){//不带分页数据
		
		return baseService.select(t);
		
	}
	
	@RequestMapping(value="all.action",method=RequestMethod.POST)
	@ResponseBody
	public List<T> all(T t){//全部列表数据
		
		t.setRows(Integer.valueOf(String.valueOf(baseService.count(null))));
		return baseService.select(t);
		
	}
	
	@RequestMapping(value="find.action",method=RequestMethod.POST)
	@ResponseBody
	public T find(T t){//内容
		
		return baseService.find(t);
		
	}
	
	@RequestMapping(value="maps.action",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> maps(final T t){//带分页数据
		return new HashMap<String, Object>(){
			private static final long serialVersionUID = 975714782007778264L;
		{
			put("total", baseService.count(t));
			put("rows", baseService.select(t));
		}};
	}
	
	@RequestMapping(value="count.action",method=RequestMethod.POST)
	public void count(final T t,HttpServletResponse response){
		try {
			response.getWriter().print(baseService.count(t));
		} catch (IOException e) {
			e.printStackTrace();
			try {
				response.getWriter().print(e.getMessage());
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}
	
	@RequestMapping(value="export.action",method=RequestMethod.GET)
	public void export(final T t, HttpServletRequest request, HttpServletResponse response){
		List<Map<String, Object>> list = baseService.export(t);
		Field[] fields = t.getClass().getDeclaredFields();
		Map<Integer,Object[]> headers = new HashMap<Integer, Object[]>();
		Object[] objects = null;
		int lengthField =0;
		for(Field field : fields){
			if(field.isAnnotationPresent(Excel.class)){
				objects = new Object[2];
				objects[0] = field.getName();
				objects[1] = field.getAnnotation(Excel.class).name();
				headers.put(lengthField,objects);
				lengthField++;
			}
		}
		if(null!=t.getClass().getSuperclass()){
			fields = t.getClass().getSuperclass().getDeclaredFields();
			for(Field field : fields){
				if(field.isAnnotationPresent(Excel.class)){
					objects = new Object[2];
					objects[0] = field.getName();
					objects[1] = field.getAnnotation(Excel.class).name();
					headers.put(lengthField,objects);
					lengthField++;
				}
			}
		}
		try {
			StringBuilder fileName = new StringBuilder();
			if(t.getClass().isAnnotationPresent(Excel.class)){
				fileName.append(t.getClass().getAnnotation(Excel.class).fileName());
			}else{
				fileName.append(t.getClass().getSimpleName());
			}
			fileName.append("_");
			fileName.append(BaseDomain.TIMESTAMP.format(new Date()));
			ExcelUtil excelUtil = new ExcelUtil();
			excelUtil.fillExcelData(list,response,headers,fileName+".xls");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
