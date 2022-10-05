package com.web.home.course.model;

import java.util.Arrays;

public class ReviewInfoDTO {
	private int l_id;
	private int AMOUNT;
	private float AVG;
	private int[] score = new int[5];
	private int[] scorePercent = new int[5];
	
	public int getL_id() {
		return l_id;
	}
	public void setL_id(int l_id) {
		this.l_id = l_id;
	}
	public int getAMOUNT() {
		return AMOUNT;
	}
	public void setAMOUNT(int aMOUNT) {
		AMOUNT = aMOUNT;
	}
	public float getAVG() {
		return AVG;
	}
	public void setAVG(float aVG) {
		AVG = aVG;
	}
	public int[] getScore() {
		return score;
	}
	public void setScore(int[] score) {
		this.score = score;
	}
	public int[] getScorePercent() {
		return scorePercent;
	}
	public void setScorePercent(int[] scorePercent) {
		this.scorePercent = scorePercent;
	}
	@Override
	public String toString() {
		return "ReviewInfoDTO [AMOUNT=" + AMOUNT + ", AVG=" + AVG + ", score=" + Arrays.toString(score)
				+ ", scorePercent=" + Arrays.toString(scorePercent) + "]";
	}
}
