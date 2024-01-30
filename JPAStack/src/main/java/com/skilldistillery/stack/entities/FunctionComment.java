package com.skilldistillery.stack.entities;

import java.time.LocalDateTime;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "function_comment")
public class FunctionComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String content;

	@Column(name = "created_on")
	private LocalDateTime created;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "function_id")
	private Function function;

	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;

	@JsonIgnore
	@OneToOne
	@JoinColumn(name = "reply_to_comment_id")
	private FunctionComment reply;

	public FunctionComment() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCreated() {
		return created;
	}

	public void setCreated(LocalDateTime created) {
		this.created = created;
	}

	public Function getFunction() {
		return function;
	}

	public void setFunction(Function function) {
		this.function = function;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public FunctionComment getReply() {
		return reply;
	}

	public void setReply(FunctionComment reply) {
		this.reply = reply;
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
		FunctionComment other = (FunctionComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "FunctionComment [id=" + id + ", content=" + content + ", created=" + created + ", function=" + function
				+ "]";
	}

}
