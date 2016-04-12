package com.dounine.controller.home.floor;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.floor.FloorCell;
import com.dounine.domain.website.floor.ProductFloor;
import com.dounine.service.website.floor.FloorCellService;
import com.dounine.service.website.floor.ProductFloorService;

@Controller
@RequestMapping("home/website/homeProductFloor")
public class HomeProductFloorController extends BaseController<ProductFloor>{
	
	@Autowired
	private ProductFloorService productFloorService;
	@Autowired
	private FloorCellService floorCellService;

	@RequestMapping(value="add_row.action",method=RequestMethod.POST)
	public void add_row(HttpServletResponse response,ProductFloor t){
		try {
			ProductFloor productFloor = productFloorService.find(t);
			productFloor.setFloor_row_count(productFloor.getFloor_row_count()+1);
			productFloorService.update(productFloor);
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
	
	@RequestMapping(value="add_column.action",method=RequestMethod.POST)
	public void add_column(HttpServletResponse response,ProductFloor t){
		try {
			ProductFloor productFloor = productFloorService.find(t);
			productFloor.setFloor_column_count(productFloor.getFloor_column_count()+1);
			productFloorService.update(productFloor);
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
	
	@RequestMapping(value="del_row.action",method=RequestMethod.POST)
	public void del_row(HttpServletResponse response,ProductFloor t,Integer[] ids){
		try {
			ProductFloor productFloor = productFloorService.find(t);
			productFloor.setFloor_row_count(productFloor.getFloor_row_count()-1);
			productFloorService.update(productFloor);
			for(Integer id : ids){
				floorCellService.delete(new FloorCell(id));
			}
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
	
	@RequestMapping(value="del_column.action",method=RequestMethod.POST)
	public void del_column(HttpServletResponse response,ProductFloor t,Integer[] ids){
		try {
			ProductFloor productFloor = productFloorService.find(t);
			productFloor.setFloor_column_count(productFloor.getFloor_column_count()-1);
			productFloorService.update(productFloor);
			for(Integer id : ids){
				floorCellService.delete(new FloorCell(id));
			}
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
	
	@RequestMapping(value="clear.action",method=RequestMethod.POST)
	public void clear(HttpServletResponse response,ProductFloor t){
		try {
			FloorCell floorCell = new FloorCell();
			floorCell.setProductFloor(t);
			floorCellService.delete(floorCell);
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

}
