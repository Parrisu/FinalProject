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

class NotificationTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Notification notification;

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
		notification = em.find(Notification.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		notification = null;
	}

	@Test
	void test_content_mapping() {
		assertNotNull(notification);
		assertFalse(notification.getContent().isBlank());
	}

	@Test
	void test_enabled_mapping() {
		assertNotNull(notification);
		assertFalse(notification.isEnabled());
	}

	@Test
	void test_type_mapping() {
		assertNotNull(notification);
		assertEquals("Cancellation", notification.getType());
	}

}
