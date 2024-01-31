package com.skilldistillery.stack.entities;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class NodeMemberId implements Serializable {
	private static final long serialVersionUID = -7704956826660016625L;

	@Column(name = "node_id")
	private int nodeId;

	@Column(name = "user_id")
	private int userId;

	public NodeMemberId(int nodeId, int userId) {
		super();
		this.nodeId = nodeId;
		this.userId = userId;
	}

	public NodeMemberId() {
		super();
	}

	public int getNodeId() {
		return nodeId;
	}

	public void setNodeId(int nodeId) {
		this.nodeId = nodeId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public int hashCode() {
		return Objects.hash(nodeId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		NodeMemberId other = (NodeMemberId) obj;
		return nodeId == other.nodeId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "NodeMemberId [nodeId=" + nodeId + ", userId=" + userId + "]";
	}

}
