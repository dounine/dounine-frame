package com.dounine.domain.website.floor;

import java.util.List;

import com.dounine.domain.BaseDomain;

public class ProductFloor extends BaseDomain {

	private static final long serialVersionUID = -8330134585729912528L;

	private Integer floor_id;
	private String floor_name;
	private Integer floor_cell_width;
	private Integer floor_cell_height;
	private Integer floor_column_count;
	private Integer floor_row_count;
	private List<FloorCell> floorCells;

	public Integer getFloor_id() {
		return floor_id;
	}

	public void setFloor_id(Integer floor_id) {
		this.floor_id = floor_id;
	}

	public String getFloor_name() {
		return floor_name;
	}

	public void setFloor_name(String floor_name) {
		this.floor_name = floor_name;
	}

	public Integer getFloor_cell_width() {
		return floor_cell_width;
	}

	public void setFloor_cell_width(Integer floor_cell_width) {
		this.floor_cell_width = floor_cell_width;
	}

	public Integer getFloor_cell_height() {
		return floor_cell_height;
	}

	public void setFloor_cell_height(Integer floor_cell_height) {
		this.floor_cell_height = floor_cell_height;
	}

	public Integer getFloor_column_count() {
		return floor_column_count;
	}

	public void setFloor_column_count(Integer floor_column_count) {
		this.floor_column_count = floor_column_count;
	}

	public Integer getFloor_row_count() {
		return floor_row_count;
	}

	public void setFloor_row_count(Integer floor_row_count) {
		this.floor_row_count = floor_row_count;
	}

	public List<FloorCell> getFloorCells() {
		return floorCells;
	}

	public void setFloorCells(List<FloorCell> floorCells) {
		this.floorCells = floorCells;
	}

}
