package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

class NodeRoleTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private NodeRole role;

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
		role = em.find(NodeRole.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		role = null;
	}

	@Test
	void test_role_mapping() {
		assertNotNull(role);
		assertEquals("Owner", role.getRole());
	}

	@Test
	void test_description_mapping() {
		assertNotNull(role);
		assertFalse(role.getDescription().isBlank());
	}

}
