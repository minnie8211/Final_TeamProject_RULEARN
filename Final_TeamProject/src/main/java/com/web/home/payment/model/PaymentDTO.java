package com.web.home.payment.model;

public class PaymentDTO {
	private String p_tid; // 결제 정보 식별자
	private String p_acid; // 구매자 회원 id
	private String p_item_name; // 구매한 상품 이름(A강의 외 2건)
	private String p_item_code; // 전체 상품 코드
	private int p_total_amount; // 총 결제 금액
	private String p_approved_at; // 결제 시각 -> insert할 때 TO_DATE로 DATE 형식으로 변환
	private String ac_name;	// 구매자 회원이름
	
	public String getP_tid() {
		return p_tid;
	}
	public void setP_tid(String p_tid) {
		this.p_tid = p_tid;
	}
	public String getP_acid() {
		return p_acid;
	}
	public void setP_acid(String p_acid) {
		this.p_acid = p_acid;
	}
	public String getP_item_name() {
		return p_item_name;
	}
	public void setP_item_name(String p_item_name) {
		this.p_item_name = p_item_name;
	}
	public String getP_item_code() {
		return p_item_code;
	}
	public void setP_item_code(String p_item_code) {
		this.p_item_code = p_item_code;
	}
	public int getP_total_amount() {
		return p_total_amount;
	}
	public void setP_total_amount(int p_total_amount) {
		this.p_total_amount = p_total_amount;
	}
//	public Date getP_approved_at() {
//		return p_approved_at;
//	}
//	public void setP_approved_at(Date p_approved_at) {
//		this.p_approved_at = p_approved_at;
//	}
	
	public String getP_approved_at() {
		return p_approved_at;
	}
	public void setP_approved_at(String p_approved_at) {
		this.p_approved_at = p_approved_at;
	}
	public String getAc_name() {
		return ac_name;
	}
	public void setAc_name(String ac_name) {
		this.ac_name = ac_name;
	}
	
	@Override
	public String toString() {
		return "PaymentDTO [p_tid=" + p_tid + ", p_acid=" + p_acid + ", p_item_name=" + p_item_name + ", p_item_code="
				+ p_item_code + ", p_total_amount=" + p_total_amount + ", p_approved_at=" + p_approved_at + ", ac_name="
				+ ac_name + "]";
	}
	
	

}
