package com.web.home.mypage.model;

public class WishlistDTO {
	// 위시 리스트(테이블의 속성)
	private int W_ID;
	private String W_ACID;
	private int W_LID;

	// 강의
	private int L_ID;
	private String L_TITLE;
	private int L_PRICE;
	private String L_THUMBNAIL;
	private String L_WID;

	public int getW_ID() {
		return W_ID;
	}

	public void setW_ID(int w_ID) {
		W_ID = w_ID;
	}

	public String getW_ACID() {
		return W_ACID;
	}

	public void setW_ACID(String w_ACID) {
		W_ACID = w_ACID;
	}

	public int getW_LID() {
		return W_LID;
	}

	public void setW_LID(int w_LID) {
		W_LID = w_LID;
	}

	public int getL_ID() {
		return L_ID;
	}

	public void setL_ID(int l_ID) {
		L_ID = l_ID;
	}

	public String getL_TITLE() {
		return L_TITLE;
	}

	public void setL_TITLE(String l_TITLE) {
		L_TITLE = l_TITLE;
	}

	public int getL_PRICE() {
		return L_PRICE;
	}

	public void setL_PRICE(int l_PRICE) {
		L_PRICE = l_PRICE;
	}

	public String getL_THUMBNAIL() {
		return L_THUMBNAIL;
	}

	public void setL_THUMBNAIL(String l_THUMBNAIL) {
		L_THUMBNAIL = l_THUMBNAIL;
	}

	public String getL_WID() {
		return L_WID;
	}

	public void setL_WID(String l_WID) {
		L_WID = l_WID;
	}

	@Override
	public String toString() {
		return "WishlistDTO [W_ID=" + W_ID + ", W_ACID=" + W_ACID + ", W_LID=" + W_LID + ", L_ID=" + L_ID + ", L_TITLE="
				+ L_TITLE + ", L_PRICE=" + L_PRICE + ", L_THUMBNAIL=" + L_THUMBNAIL + ", L_WID=" + L_WID + "]";
	}

}