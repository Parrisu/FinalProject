package com.skilldistillery.stack.repositories;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.stack.entities.Node;
import com.skilldistillery.stack.entities.Technology;

public interface NodeRepository extends JpaRepository<Node, Integer> {
	public List<Node> findByNameContaining(String name);

	@Query("""
			SELECT
			    DISTINCT node
			FROM
			    Node node
			WHERE
			    node.enabled = true
			    AND (
			        :searchQuery IS NULL
			        OR node.name LIKE %:searchQuery%
			        OR EXISTS (
			            SELECT
			                t
			            FROM
			                Technology t
			            WHERE
			                t MEMBER OF node.stack
			                AND t.name LIKE %:searchQuery%
			        )
			    )
			    AND (
			        :city IS NULL
			        OR node.city LIKE %:city%
			    )
			    AND (
			        :stateAbbr IS NULL
			        OR node.stateAbbreviation LIKE %:stateAbbr%
			    )
			    AND (
			        :stack IS NULL
			        OR EXISTS (
			            SELECT
			                t
			            FROM
			                Technology t
			            WHERE
			                t MEMBER OF node.stack
			                AND t IN :stack
			        )
			    )""")
	Set<Node> searchNodes(@Param("searchQuery") String searchQuery, @Param("city") String city,
			@Param("stateAbbr") String stateAbbr, @Param("stack") Set<Technology> stack);
}
