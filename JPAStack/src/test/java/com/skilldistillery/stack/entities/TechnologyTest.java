package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class TechnologyTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Technology tech;

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
		tech = em.find(Technology.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		tech = null;
	}

	@Test
	void test_name_mapping() {
		assertNotNull(tech);
		assertEquals("Java", tech.getName());
	}

	@Test
	void test_badgeUrl_mapping() {
		assertNotNull(tech);
		assertNotNull(tech.getBadgeUrl());
		assertFalse(tech.getBadgeUrl().isBlank());
	}

	@Test
	void test_description_mapping() {
		assertNotNull(tech);
		assertNotNull(tech.getDescription());
		assertFalse(tech.getDescription().isBlank());
	}
	
	@Test
	void test_nodes_mapping() {
		assertNotNull(tech);
		assertNotNull(tech.getNodes());
		assertFalse(tech.getNodes().isEmpty());
	}
}
