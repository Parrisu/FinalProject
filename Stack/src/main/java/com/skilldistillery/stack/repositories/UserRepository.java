package com.skilldistillery.stack.repositories;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.stack.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User findByUsername(String username);

	boolean existsByUsername(String username);

	boolean existsByEmail(String email);

	@Query("SELECT nm.user FROM Node n JOIN n.nodeMembers nm WHERE n.id = :nodeId")
	List<User> getMembersByNodeId(@Param("nodeId") int nodeId);

	@Query("""
			SELECT
			  u
			FROM
			  User u
			WHERE
			  (
			    :searchQuery IS NULL
			    OR u.username LIKE %:searchQuery%
			    OR u.aboutMe LIKE %:searchQuery%
			  )
			  AND u.enabled = true
			""")
	Set<User> getAll(@Param("searchQuery") String searchQuery);
}
