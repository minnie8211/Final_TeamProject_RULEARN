package com.web.home.mypage.model;

import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


public class VirtualAccountInfoVO {
	private String mId;
	private String orderId;
	private String secret;
	private String status;
	private String method;
	private String orderName;
	private String totalAmount;
	private String requestedAt;
	private JsonNode virtualAccount;
	
	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getOrderName() {
		return orderName;
	}

	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	public String getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(String totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getRequestedAt() {
		return requestedAt;
	}

	public void setRequestedAt(String requestedAt) {
		this.requestedAt = spiltTime(requestedAt);
	}
	
	public void setVirtualAccount(JsonNode virtualAccount) {
		this.virtualAccount = virtualAccount;
	}
	
	public Map<String, String> getVirtualAccount() {
		Map<String, String> virtualAccount = new HashMap<String, String>();
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			virtualAccount = objectMapper.treeToValue(this.virtualAccount, Map.class);
			virtualAccount.replace("dueDate", spiltTime(virtualAccount.get("dueDate")));
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		}
		
		return virtualAccount;
	}
	
	private String spiltTime(String time) {
		String[] temp = time.split("-|T|\\+"); 
		time = temp[0] + "." + temp[1] + "." + temp[2] + " " + temp[3];
		
		return time;
	}
	@Override
	public String toString() {
		return "VirtualAccountInfoVO [mId=" + mId + ", orderId=" + orderId + ", secret=" + secret + ", status=" + status
				+ ", method=" + method + ", orderName=" + orderName + ", totalAmount=" + totalAmount + ", requestedAt="
				+ requestedAt + ", virtualAccount=" + virtualAccount + "]";
	}
	
	
	
}
