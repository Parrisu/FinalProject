package com.skilldistillery.stack.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.stack.entities.Function;

public interface FunctionRepository extends JpaRepository<Function, Integer> {
	
	@Query("SELECT f from Function f WHERE f.node.id = :id")
	  List<Function> findByNodeId(@Param("id") int id);

}
