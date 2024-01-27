package com.skilldistillery.stack.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;

@Entity
@Table(name = "node_member")
public class NodeMember {

	@EmbeddedId
	private NodeMemberId id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value = "userId")
	private User user;

	@ManyToOne
	@JoinColumn(name = "node_id")
	@MapsId(value = "nodeId")
	private Node node;

	private boolean approved;

	@Column(name = "date_joined")
	@CreationTimestamp
	private LocalDateTime dateJoined;

	@ManyToOne
	@JoinColumn(name = "node_role_id")
	private NodeRole nodeRole;

	public NodeMember() {
		super();
	}

	public NodeMemberId getId() {
		return id;
	}

	public void setId(NodeMemberId id) {
		this.id = id;
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

	public LocalDateTime getDateJoined() {
		return dateJoined;
	}

	public void setDateJoined(LocalDateTime dateJoined) {
		this.dateJoined = dateJoined;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Node getNode() {
		return node;
	}

	public void setNode(Node node) {
		this.node = node;
	}

	public NodeRole getNodeRole() {
		return nodeRole;
	}

	public void setNodeRole(NodeRole nodeRole) {
		this.nodeRole = nodeRole;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		NodeMember other = (NodeMember) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "NodeMember [id=" + id + ", approved=" + approved + ", dateJoined=" + dateJoined + "]";
	}

}
