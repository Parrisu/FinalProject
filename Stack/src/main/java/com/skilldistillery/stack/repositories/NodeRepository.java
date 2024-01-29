package com.skilldistillery.stack.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.stack.entities.Node;

public interface NodeRepository extends JpaRepository<Node, Integer> {

}
