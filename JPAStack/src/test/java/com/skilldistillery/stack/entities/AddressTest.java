package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.time.LocalDateTime;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class AddressTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address address;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAStack");
		
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		address = em.find(Address.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		address = null;
		
	}

	@Test
	void test_Address_entity_mapping() {
		assertNotNull(address);
		assertEquals("7 havana St", address.getStreet());
		assertEquals("80112", address.getZipCode());
	}
	
//	@Test
//	void test_Address_function_mapping() {
//		assertNotNull(address);
//		assertEquals("Super Java bros", address.get);
//	}
	

}
