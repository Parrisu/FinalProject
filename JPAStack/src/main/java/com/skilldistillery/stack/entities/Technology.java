package com.skilldistillery.stack.entities;

import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;

@Entity
public class Technology {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@Column(name = "badge_url")
	private String badgeUrl;

	private String description;

	@ManyToMany
	@JsonIgnore
	@JoinTable(name = "node_technology", joinColumns = @JoinColumn(name = "technology_id"), inverseJoinColumns = @JoinColumn(name = "node_id"))
	private List<Node> nodes;

	public Technology() {
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

	public String getBadgeUrl() {
		return badgeUrl;
	}

	public void setBadgeUrl(String badgeUrl) {
		this.badgeUrl = badgeUrl;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Node> getNodes() {
		return nodes;
	}

	public void setNodes(List<Node> nodes) {
		this.nodes = nodes;
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
		Technology other = (Technology) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Technology [id=" + id + ", name=" + name + ", badgeUrl=" + badgeUrl + ", description=" + description
				+ "]";
	}

}
