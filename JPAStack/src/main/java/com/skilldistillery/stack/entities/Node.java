package com.skilldistillery.stack.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;

@Entity
public class Node {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@Column(name = "open_to_public")
	private Boolean openToPublic;

	@Column(name = "created_on")
	@CreationTimestamp
	private LocalDateTime createdOn;

	@Column(name = "updated_on")
	@UpdateTimestamp
	private LocalDateTime updatedOn;


	private String city;

	private String description;

	@Column(name = "image_url")
	private String imageUrl;
	
	@Column(name = "state_abbreviation")
	private String stateAbbr;

	@ManyToMany
	@JoinTable(name = "node_technology", joinColumns = @JoinColumn(name = "node_id"), inverseJoinColumns = @JoinColumn(name = "technology_id"))
	private List<Technology> stack;
	
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	public Node() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getOpenToPublic() {
		return openToPublic;
	}

	public void setOpenToPublic(Boolean openToPublic) {
		this.openToPublic = openToPublic;
	}

	public LocalDateTime getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(LocalDateTime createdOn) {
		this.createdOn = createdOn;
	}

	public LocalDateTime getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(LocalDateTime updatedOn) {
		this.updatedOn = updatedOn;
	}


	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public List<Technology> getStack() {
		return stack;
	}

	public void setStack(List<Technology> stack) {
		this.stack = stack;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getStateAbbr() {
		return stateAbbr;
	}

	public void setStateAbbr(String stateAbbr) {
		this.stateAbbr = stateAbbr;
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
		Node other = (Node) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Node [id=" + id + ", name=" + name + ", openToPublic=" + openToPublic + ", createdOn=" + createdOn
				+ ", updatedOn=" + updatedOn + ", city=" + city + ", description=" + description + ", imageUrl="
				+ imageUrl + ", stateAbbr=" + stateAbbr + ", stack=" + stack + ", user=" + user + "]";
	}

}
