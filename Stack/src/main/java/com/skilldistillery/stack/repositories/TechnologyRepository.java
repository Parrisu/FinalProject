package com.skilldistillery.stack.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.stack.entities.Technology;

public interface TechnologyRepository extends JpaRepository<Technology, Integer> {

}
