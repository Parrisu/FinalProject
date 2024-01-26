package com.skilldistillery.stack.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "node_member")
public class NodeMember {

	@EmbeddedId
	private NodeMemberId id;

	private Boolean approved;

	@Column(name = "date_joined")
	@CreationTimestamp
	private LocalDateTime dateJoined;

	@Column(name = "date_approved")
	@UpdateTimestamp
	private LocalDateTime dateApproved;

	public NodeMember() {
		super();
	}

	public NodeMemberId getId() {
		return id;
	}

	public void setId(NodeMemberId id) {
		this.id = id;
	}

	public Boolean getApproved() {
		return approved;
	}

	public void setApproved(Boolean approved) {
		this.approved = approved;
	}

	public LocalDateTime getDateJoined() {
		return dateJoined;
	}

	public void setDateJoined(LocalDateTime dateJoined) {
		this.dateJoined = dateJoined;
	}

	public LocalDateTime getDateApproved() {
		return dateApproved;
	}

	public void setDateApproved(LocalDateTime dateApproved) {
		this.dateApproved = dateApproved;
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

}
