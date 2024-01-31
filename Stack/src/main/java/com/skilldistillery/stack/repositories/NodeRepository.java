package com.skilldistillery.stack.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.NodeMember;

public interface NodeRepository extends JpaRepository<Node, Integer> {
	public List<Node> findByNameContaining(String name);
	
}
