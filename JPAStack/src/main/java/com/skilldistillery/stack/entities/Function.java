package com.skilldistillery.stack.entities;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;

@Entity
public class Function {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private boolean cancelled;

	private boolean enabled;

	@Column(name = "function_date")
	private Date date;

	private String description;

	@Column(name = "start_time")
	private LocalDateTime start;

	@Column(name = "end_time")
	private LocalDateTime end;

	@Column(name = "created_on")
	private LocalDateTime created;

	@Column(name = "updated_on")
	private LocalDateTime updated;

	@Column(name = "max_attendees")
	private int cap;

	@Column(name = "image_url")
	private String imgUrl;

	@OneToMany(mappedBy = "function")
	private List<FunctionComment> comments;

	@OneToMany(mappedBy = "function")
	private List<FunctionImage> images;

	@ManyToOne
	@JoinColumn(name = "address_id")
	private Address address;

	@OneToOne
	@JoinColumn(name = "created_by")
	private User user;

	@ManyToOne
	@JoinColumn(name = "node_id")
	private Node node;

	public Function() {
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

	public boolean isCancelled() {
		return cancelled;
	}

	public void setCancelled(boolean cancelled) {
		this.cancelled = cancelled;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getStart() {
		return start;
	}

	public void setStart(LocalDateTime start) {
		this.start = start;
	}

	public LocalDateTime getEnd() {
		return end;
	}

	public void setEnd(LocalDateTime end) {
		this.end = end;
	}

	public LocalDateTime getCreated() {
		return created;
	}

	public void setCreated(LocalDateTime created) {
		this.created = created;
	}

	public LocalDateTime getUpdated() {
		return updated;
	}

	public void setUpdated(LocalDateTime updated) {
		this.updated = updated;
	}

	public int getCap() {
		return cap;
	}

	public void setCap(int cap) {
		this.cap = cap;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public List<FunctionComment> getComments() {
		return comments;
	}

	public void setComments(List<FunctionComment> comments) {
		this.comments = comments;
	}

	public List<FunctionImage> getImages() {
		return images;
	}

	public void setImages(List<FunctionImage> images) {
		this.images = images;
	}

	public Node getNode() {
		return node;
	}

	public void setNode(Node node) {
		this.node = node;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
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
		Function other = (Function) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Function [id=" + id + ", name=" + name + ", cancelled=" + cancelled + ", enabled=" + enabled + ", date="
				+ date + ", description=" + description + ", start=" + start + ", end=" + end + ", created=" + created
				+ ", updated=" + updated + ", cap=" + cap + ", imgUrl=" + imgUrl + "]";
	}

}
