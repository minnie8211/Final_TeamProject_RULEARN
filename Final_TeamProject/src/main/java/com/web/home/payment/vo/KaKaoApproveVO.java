package com.web.home.payment.vo;

import java.sql.Date;

public class KaKaoApproveVO {
	
	private String aid; // 요청 고유 번호
	private String tid;	// 결제 고유 번호 (결제 요청이 성공되면 반환됨 readyResponse.tid)
	private String cid;	// 가맹점 코드(TESTCODE)
	// private String sid; // 정기 결제용 id, 정기 결제 cid로 단건 결제 요청 시 발급
	private String partner_order_id;	// 가맹점 주문번호
	private String partner_user_id;		// 가맹점 id(RULEARN)
	private String payment_method_type;	// 결제수단(CARD 또는 MONEY 중 하나)
	private KaKaoAmountVO amount;		// 결제 금액(KaKaoPayAmountVO)
	// private int card_info;				// 결제 수단이 카드일 경우 포함(KaKaoPayCardVO)
	private String item_name;			// 상품 이름(최대 100자)
	private String item_code;			// 상품 코드(최대 100자)
	private int quantity;				// 상품 수량
	private Date created_at;			// 결제 준비 요청 시각
	private Date approved_at;			// 결제 승인 시각
	// private String payload;				// 결제 승인 요청에 대한 저장한 값, 요청시 전달된 내용
	
	
	public String getAid() {
		return aid;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getPartner_order_id() {
		return partner_order_id;
	}
	public void setPartner_order_id(String partner_order_id) {
		this.partner_order_id = partner_order_id;
	}
	public String getPartner_user_id() {
		return partner_user_id;
	}
	public void setPartner_user_id(String partner_user_id) {
		this.partner_user_id = partner_user_id;
	}
	public String getPayment_method_type() {
		return payment_method_type;
	}
	public void setPayment_method_type(String payment_method_type) {
		this.payment_method_type = payment_method_type;
	}
	public KaKaoAmountVO getAmount() {
		return amount;
	}
	public void setAmount(KaKaoAmountVO amount) {
		this.amount = amount;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public Date getApproved_at() {
		return approved_at;
	}
	public void setApproved_at(Date approved_at) {
		this.approved_at = approved_at;
	}
	@Override
	public String toString() {
		return "KaKaoApproveVO [aid=" + aid + ", tid=" + tid + ", cid=" + cid + ", partner_order_id=" + partner_order_id
				+ ", partner_user_id=" + partner_user_id + ", payment_method_type=" + payment_method_type + ", amount="
				+ amount + ", item_name=" + item_name + ", item_code=" + item_code + ", quantity=" + quantity
				+ ", created_at=" + created_at + ", approved_at=" + approved_at + "]";
	}
	
}
