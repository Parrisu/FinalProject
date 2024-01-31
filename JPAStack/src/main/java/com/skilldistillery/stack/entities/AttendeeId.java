package com.skilldistillery.stack.entities;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class AttendeeId implements Serializable {
	private static final long serialVersionUID = -7704956826660016625L;

	@Column(name = "function_id")
	private int functionId;

	@Column(name = "user_id")
	private int userId;

	public AttendeeId(int functionId, int userId) {
		this.functionId = functionId;
		this.userId = userId;
	}

	public AttendeeId() {
	}

	public int getNodeId() {
		return functionId;
	}

	public void setNodeId(int functionId) {
		this.functionId = functionId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(functionId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AttendeeId other = (AttendeeId) obj;
		return functionId == other.functionId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "AttendeeId [functionId=" + functionId + ", userId=" + userId + "]";
	}

}
