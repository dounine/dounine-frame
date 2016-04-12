package com.dounine.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;

import com.dounine.finals.Finals;

/**
 * @ProjectName:		[ 逗你呢框架管理系统 ]
 * @Package:			[ com.dounine.utils ]
 * @Author:				[ huanghuanlai ]
 * @CreateTime:			[ 2015年2月4日 上午10:21:20 ]
 * @Copy:				[ dounine.com ]
 * @Version:			[ v1.0 ]
 * @Description:   		[ 时间段工具类 ]
 */
public class DateUtil extends Thread{
	
	private static ServletContext appliContext;
	
	public DateUtil(ServletContext appliContext){
		DateUtil.appliContext = appliContext;
	}
	
	public static String times = null;

	@Override
	public void run() {
		while(true){
			setTimes();
			try {
				Thread.sleep(60000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

	private static final String[] dates = new String[5];
	private static final String[] dates_s = new String[5];
	private static final String[] dates_tip = new String[5];
	private static final String[] dates_icon = new String[5];
	
	static{
		dates[0] = "0:00-5:59";
		dates[1] = "6:00-11:59";
		dates[2] = "12:00-13:59";
		dates[3] = "14:00-17:59";
		dates[4] = "18:00-23:59";
		
		dates_s[0] = "凌晨";
		dates_s[1] = "早上";
		dates_s[2] = "中午";
		dates_s[3] = "下午";
		dates_s[4] = "晚上";
		
		dates_tip[0] = "要注意休息噢";
		dates_tip[1] = "记得吃早点";
		dates_tip[2] = "眯个觉身体比较有劲";
		dates_tip[3] = "捉紧时间干活吧";
		dates_tip[4] = "别玩太晚咯";
		
		dates_icon[0] = "dounine-icon-sleep.png";
		dates_icon[1] = "dounine-icon-morning.png";
		dates_icon[2] = "dounine-icon-rest.png";
		dates_icon[3] = "dounine-icon-noon.png";
		dates_icon[4] = "dounine-icon-night.png";
	}
	
	private static void setTimes(){
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		String currentDate = sdf.format(new Date());
		Date currDate = null;
		Date startDate = null;
		Date endDate = null;
		String[] dateArr = null;
		String date = null;
		for(int i = 0;i<dates.length;i++){
			date = dates[i];
			dateArr = date.split("-");
			try {
				currDate = sdf.parse(currentDate);//当前时间
				startDate = sdf.parse(dateArr[0]);//开始时间
				endDate  = sdf.parse(dateArr[1]);//结束时间
				if(currDate.after(startDate)&&currDate.before(endDate)){
					if(null==appliContext.getAttribute(Finals.CURRENT_TIME_STRING)||(null!=appliContext.getAttribute(Finals.CURRENT_TIME_STRING)&&!appliContext.getAttribute(Finals.CURRENT_TIME_STRING).equals(dates_s[i]))){
						appliContext.setAttribute(Finals.CURRENT_TIME_STRING, dates_s[i]);
						appliContext.setAttribute(Finals.CURRENT_TIME_TIP, dates_tip[i]);
						appliContext.setAttribute(Finals.CURRENT_TIME_ICON, dates_icon[i]);
					}
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}

}
