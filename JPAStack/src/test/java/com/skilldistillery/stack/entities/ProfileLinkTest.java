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

class ProfileLinkTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ProfileLink link;

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
		link = em.find(ProfileLink.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		link = null;
	}

	@Test
	void test_url_mapping() {
		assertNotNull(link);
		assertNotNull(link.getUrl());
		assertFalse(link.getUrl().isBlank());
	}
	
	@Test
	void test_name_mapping() {
		assertNotNull(link);
		assertNotNull(link.getName());
		assertEquals("linkedin", link.getName());
	}
	
	@Test
	void test_user_mapping() {
		assertNotNull(link);
		assertNotNull(link.getUser());
		assertEquals(1, link.getUser().getId());
	}
}
