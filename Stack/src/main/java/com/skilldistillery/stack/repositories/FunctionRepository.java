package com.skilldistillery.stack.repositories;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.stack.entities.Function;
import com.skilldistillery.stack.entities.Technology;

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
			    AND (
			      :cityName IS NULL
			      OR f.node.city LIKE %:cityName%
			    )
			    AND (
			      :stateAbbr IS NULL
			      OR f.node.stateAbbreviation LIKE %:stateAbbr%
			    )
			    AND (
			      :stack IS NULL
			      OR EXISTS (
			        SELECT
			          t
			        FROM
			          Technology t
			        WHERE
			          t MEMBER OF f.node.stack
			          AND t IN :stack
			      )
			    )
			    AND f.enabled = true
			    AND f.cancelled = false
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
	Set<Function> searchFunctions(@Param("searchQuery") String searchQuery, @Param("cityName") String cityName,
			@Param("stateAbbr") String stateAbbr, @Param("username") String username,
			@Param("stack") Set<Technology> stack);

	@Query("SELECT f from Function f WHERE f.node.id = :id")
	  List<Function> findByNodeId(@Param("id") int id);
	
	@Query("SELECT f from Function f WHERE f.node.id = :id AND f.id = :fId")
	Function findFunctionByIdAndNode(@Param("id") int id, @Param("fId") int fId);

}
