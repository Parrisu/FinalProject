package com.skilldistillery.stack.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.stack.entities.Node;

public interface NodeRepository extends JpaRepository<Node, Integer> {
	public List<Node> findByNameContaining(String name);
}
