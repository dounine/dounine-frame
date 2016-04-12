package com.dounine.utils;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.utils ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:21:34 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ Excel工具类 ]
 */
public class ExcelUtil {

	public void fillExcelData(List<Map<String, Object>> objects,HttpServletResponse response,Map<Integer, Object[]> headers,String filename) throws Exception{
		Workbook wb = new HSSFWorkbook();
		int rowIndex=0;
		if(null!=objects&&objects.size()>0){
			Sheet sheet = wb.createSheet("统计结果");
			Row row = sheet.createRow(rowIndex++);
			CellStyle cellStyle = wb.createCellStyle();
			cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
			Cell cell = null;
			Map<String, Object> firstHeader = objects.get(0);//获取第一行数据
			
			int headerLength = 0;//查询数据与头部数据匹配数
			
			List<String> headerStrings = new ArrayList<String>(); 
			for (Object[] _key : headers.values()) {
				for (String key : firstHeader.keySet()) {
					if(key.equals(_key[0])){
						headerLength++;
						headerStrings.add(String.valueOf(_key[1]));//获取表头文字
						break;
					}
				}
			}
			
			for (int i = 0; i < headerLength; i++) {
				(cell=row.createCell(i)).setCellValue(headerStrings.get(i));
				 cell.setCellStyle(cellStyle);
			}
			Map<Integer, Object> widthObj = new HashMap<Integer, Object>();
			for(Map<String, Object> map : objects){
				row = sheet.createRow(rowIndex++);
				int index = 0;
				for (Object[] _key : headers.values()) {
					for (Object m : map.keySet()) {
						if(m.equals(_key[0])){
							if(!widthObj.containsKey(index)){
								widthObj.put(index, map.get(m));
							}
							for(Object ii : widthObj.values()){
								if(String.valueOf(ii).length()<String.valueOf(map.get(m)).length()){
									widthObj.put(index, String.valueOf(map.get(m)));
								}
							}
							(cell=row.createCell(index)).setCellValue(String.valueOf(map.get(m)));
							cell.setCellStyle(cellStyle);
							index++;
							break;
						}
					}
				}
			}
			for(Integer index : widthObj.keySet()){//选择一列最长的设置宽度
				for(String shead : headerStrings){
					if(shead.length()>String.valueOf(widthObj.get(index)).length()){
						sheet.setColumnWidth(index, shead.getBytes().length*2*256);
					}else{
						sheet.setColumnWidth(index, String.valueOf(widthObj.get(index)).getBytes().length*2*256);
					}
					break;
				}
			}
			exportExcel(response,wb,filename);
		}
		return;
	}
	
	public void exportExcel(HttpServletResponse response,Workbook wb,String fileName){
		OutputStream out=null;
		try {
			response.setContentType("text/html;charset=utf-8");
			response.setHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("UTF-8"),"ISO-8859-1"));
			response.setContentType("application/ynd.ms-excel;charset=utf-8");
			out = response.getOutputStream();
			wb.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
}
