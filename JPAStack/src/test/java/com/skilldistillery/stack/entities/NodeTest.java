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

class NodeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Node node;

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
		node = em.find(Node.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		node = null;
	}

	@Test
	void test_name_mapping() {
		assertNotNull(node);
		assertEquals("Super Java bros", node.getName());
	}

	@Test
	void test_openToPublic_mapping() {
		assertNotNull(node);
		assertTrue(node.getOpenToPublic());
	}

	@Test
	void test_createdOn_mapping() {
		assertNotNull(node);
		assertEquals(2001, node.getCreatedOn().getYear());
	}

	@Test
	void test_updatedOn_mapping() {
		assertNotNull(node);
		assertEquals(2001, node.getUpdatedOn().getYear());
	}

	@Test
	void test_city_mapping() {
		assertNotNull(node);
		assertNotNull(node.getCity());
		assertEquals(1, node.getCity().getId());
	}

	@Test
	void test_description_mapping() {
		assertNotNull(node);
		assertNotNull(node.getDescription());
		assertFalse(node.getDescription().isBlank());
	}

	@Test
	void test_imageUrl_mapping() {
		assertNotNull(node);
		assertNotNull(node.getImageUrl());
		assertFalse(node.getImageUrl().isBlank());
	}

}
