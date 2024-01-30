package com.skilldistillery.stack.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.stack.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findByUsername(String username);

	boolean existsByUsername(String username);

	boolean existsByEmail(String email);
	
	
	@Query("SELECT nm.user FROM Node n JOIN n.nodeMembers nm WHERE n.id = :nodeId")
	List<User> getMembersByNodeId(@Param("nodeId")int nodeId);
	
	
}
