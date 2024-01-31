package com.skilldistillery.stack.repositories;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.stack.entities.Function;

public interface FunctionRepository extends JpaRepository<Function, Integer> {

	@Query("""
			SELECT
			  DISTINCT f
			FROM
			  Function f
			WHERE
			  (
			    (
			      (:searchQuery IS NULL)
			      OR f.name LIKE %:searchQuery%
			    )
			    AND 
			      f.enabled = true
			    AND 
			      f.cancelled = false
			  )
			  AND (
			    f.node.openToPublic = true
			    OR (
			      :username IS NULL
			      OR :username IN (
			        SELECT
			          nm.user.username
			        FROM
			          Node node
			          JOIN node.nodeMembers nm
			        WHERE
			          node = f.node
			      )
			    )
			  )
			""")
	Set<Function> getAll(@Param("searchQuery") String searchQuery, @Param("username") String username);
	
	@Query("SELECT f from Function f WHERE f.node.id = :id")
	  List<Function> findByNodeId(@Param("id") int id);

}
