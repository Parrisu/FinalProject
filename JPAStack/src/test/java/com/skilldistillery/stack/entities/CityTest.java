package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class CityTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private City city;

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
		city = em.find(City.class, 2);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		city = null;

	}

	@Test
	void test_City_entity_mapping() {
		assertNotNull(city);
		assertEquals("Centennial", city.getName());
		assertEquals("Colorado", city.getState());
	}

	@Test
	void test_City_User_mapping() {
		assertNotNull(city);
		assertTrue(city.getAddresses().size()> 0);
		assertTrue(city.getAddresses().toString().contains("havana"));
	}
	
	@Test
	void test_City_Nodes_mapping() {
		city = em.find(City.class, 1);
		assertNotNull(city);
		assertTrue(city.getNodes().size()> 0);
//		System.out.println(city.getNodes().toString());
		assertTrue(city.getNodes().toString().contains("Super Java bros"));
	}
		

}
