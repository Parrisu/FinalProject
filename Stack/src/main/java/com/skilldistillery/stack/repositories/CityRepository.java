package com.skilldistillery.stack.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.stack.entities.City;

public interface CityRepository extends JpaRepository<City, Integer> {
}
