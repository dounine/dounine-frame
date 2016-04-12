package com.dounine.domain.website.floor;

import com.dounine.domain.BaseDomain;

public class FloorCell extends BaseDomain {

	private static final long serialVersionUID = -8330134585729912528L;

	private Integer cell_id;
	private String cell_picture;
	private String cell_url;
	private Integer cell_column_index;
	private Integer cell_row_index;
	private Integer cell_column_count;
	private Integer cell_row_count;
	private Boolean cell_vertical = Boolean.FALSE;
	private String cell_text;
	private String cell_css_style;
	private Boolean cell_picture_or_color = Boolean.FALSE;
	private String cell_bg_color;
	private ProductFloor productFloor;

	public FloorCell() {

	}

	public FloorCell(Integer cell_id) {
		this.cell_id = cell_id;
	}

	public Integer getCell_id() {
		return cell_id;
	}

	public void setCell_id(Integer cell_id) {
		this.cell_id = cell_id;
	}

	public Boolean getCell_vertical() {
		return cell_vertical;
	}

	public void setCell_vertical(Boolean cell_vertical) {
		this.cell_vertical = cell_vertical;
	}

	public String getCell_text() {
		return cell_text;
	}

	public void setCell_text(String cell_text) {
		this.cell_text = cell_text;
	}

	public String getCell_css_style() {
		return cell_css_style;
	}

	public void setCell_css_style(String cell_css_style) {
		this.cell_css_style = cell_css_style;
	}

	public Boolean getCell_picture_or_color() {
		return cell_picture_or_color;
	}

	public void setCell_picture_or_color(Boolean cell_picture_or_color) {
		this.cell_picture_or_color = cell_picture_or_color;
	}

	public String getCell_bg_color() {
		return cell_bg_color;
	}

	public void setCell_bg_color(String cell_bg_color) {
		this.cell_bg_color = cell_bg_color;
	}

	public String getCell_picture() {
		return cell_picture;
	}

	public void setCell_picture(String cell_picture) {
		this.cell_picture = cell_picture;
	}

	public String getCell_url() {
		return cell_url;
	}

	public void setCell_url(String cell_url) {
		this.cell_url = cell_url;
	}

	public Integer getCell_column_index() {
		return cell_column_index;
	}

	public void setCell_column_index(Integer cell_column_index) {
		this.cell_column_index = cell_column_index;
	}

	public Integer getCell_row_index() {
		return cell_row_index;
	}

	public void setCell_row_index(Integer cell_row_index) {
		this.cell_row_index = cell_row_index;
	}

	public Integer getCell_column_count() {
		return cell_column_count;
	}

	public void setCell_column_count(Integer cell_column_count) {
		this.cell_column_count = cell_column_count;
	}

	public Integer getCell_row_count() {
		return cell_row_count;
	}

	public void setCell_row_count(Integer cell_row_count) {
		this.cell_row_count = cell_row_count;
	}

	public ProductFloor getProductFloor() {
		return productFloor;
	}

	public void setProductFloor(ProductFloor productFloor) {
		this.productFloor = productFloor;
	}

}
