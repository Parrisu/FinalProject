package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.Entity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

@Entity
class NodeResourceTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private NodeResource nodeResource;

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
		nodeResource = em.find(NodeResource.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		nodeResource = null;
	}

	@Test
	void test_url_mapping() {
		assertNotNull(nodeResource);
		assertFalse(nodeResource.getUrl().isBlank());
	}

	@Test
	void test_title_mapping() {
		assertNotNull(nodeResource);
		assertEquals("Our discord", nodeResource.getTitle());
	}

	@Test
	void test_node_mapping() {
		assertNotNull(nodeResource);
		assertEquals(1, nodeResource.getNode().getId());
	}

}
