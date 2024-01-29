package com.skilldistillery.stack.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.stack.entities.Address;

public interface AddressRepository extends JpaRepository<Address, Integer> {}
