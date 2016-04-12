package com.dounine.controller.home.floor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dounine.controller.BaseController;
import com.dounine.domain.website.floor.FloorCell;
import com.dounine.service.website.floor.FloorCellService;

@Controller
@RequestMapping("home/website/homeFloorCell")
public class HomeFloorCellController extends BaseController<FloorCell>{
	
	@Autowired
	private FloorCellService floorCellService;

	@Override
	public List<FloorCell> all(FloorCell t) {
		t.setRows(Integer.valueOf(String.valueOf(baseService.count(null))));
		return floorCellService.select(t);
	}
}
