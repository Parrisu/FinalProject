package com.skilldistillery.stack.entities;

import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;

@Entity
public class Attendee {
	
	@EmbeddedId
	private AttendeeId id;
	
	@ManyToOne
	@JoinColumn(name="function_id")
	@MapsId(value="functionId")
	@JsonIgnore
	Function function;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	@MapsId(value="userId")
	@JsonIgnore
	User user;
	
	public Attendee() {}

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

	@Override
	public int hashCode() {
		return Objects.hash(function, user);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Attendee other = (Attendee) obj;
		return Objects.equals(function, other.function) && Objects.equals(user, other.user);
	}

	@Override
	public String toString() {
		return "Attendee [function=" + function + ", user=" + user + "]";
	}
	
	

}
