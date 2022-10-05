package com.web.home.course.model;


public class FileInfoDTO {
	private int lu_id;
	private int lu_bid;
	private String lu_name;
	private String lu_uuidName;
	private String lu_location;
	private String lu_url;
	private int lu_fileSize;
	private String lu_contentType;
	public int getLu_id() {
		return lu_id;
	}
	public void setLu_id(int lu_id) {
		this.lu_id = lu_id;
	}
	public int getLu_bid() {
		return lu_bid;
	}
	public void setLu_bid(int lu_bid) {
		this.lu_bid = lu_bid;
	}
	public String getLu_name() {
		return lu_name;
	}
	public void setLu_name(String lu_name) {
		this.lu_name = lu_name;
	}
	public String getLu_uuidName() {
		return lu_uuidName;
	}
	public void setLu_uuidName(String lu_uuidName) {
		this.lu_uuidName = lu_uuidName;
	}
	public String getLu_location() {
		return lu_location;
	}
	public void setLu_location(String lu_location) {
		this.lu_location = lu_location;
	}
	public String getLu_url() {
		return lu_url;
	}
	public void setLu_url(String lu_url) {
		this.lu_url = lu_url;
	}
	public int getLu_fileSize() {
		return lu_fileSize;
	}
	public void setLu_fileSize(int lu_fileSize) {
		this.lu_fileSize = lu_fileSize;
	}
	public String getLu_contentType() {
		return lu_contentType;
	}
	public void setLu_contentType(String lu_contentType) {
		this.lu_contentType = lu_contentType;
	}
	@Override
	public String toString() {
		return "FileInfoDTO [lu_id=" + lu_id + ", lu_bid=" + lu_bid + ", lu_name=" + lu_name + ", lu_uuidName="
				+ lu_uuidName + ", lu_location=" + lu_location + ", lu_url=" + lu_url + ", lu_fileSize=" + lu_fileSize
				+ ", lu_contentType=" + lu_contentType + "]";
	}
	
	
	
}
