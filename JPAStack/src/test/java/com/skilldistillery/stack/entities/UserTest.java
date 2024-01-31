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

class UserTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	void test_address_mapping() {
		assertNotNull(user);
		assertNotNull(user.getAddress());
		assertEquals(3, user.getAddress().getId());
	}

	@Test
	void test_username_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}

	@Test
	void test_password_mapping() {
		assertNotNull(user);
		assertEquals("$2a$10$YIVc0suGYF7SlCurrPbkjOvrULm35jlDAZ0bb8UlBReumopVMxtEq", user.getPassword());
	}

	@Test
	void test_enabled_mapping() {
		assertNotNull(user);
		assertEquals(true, user.isEnabled());
	}

	@Test
	void test_email_mapping() {
		assertNotNull(user);
		assertEquals("admin@admin.com", user.getEmail());
	}

	@Test
	void test_role_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getRole());
	}

	@Test
	void test_aboutMe_mapping() {
		assertNotNull(user);
		assertFalse(user.getAboutMe().isBlank());
	}

	@Test
	void test_firstName_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getFirstName());
	}

	@Test
	void test_lastName_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getLastName());
	}

	@Test
	void test_profileImageUrl_mapping() {
		assertNotNull(user);
		assertFalse(user.getEmail().isBlank());
	}

	@Test
	void test_stack_is_not_empty() {
		assertNotNull(user);
		assertNotNull(user.getStack());
		assertFalse(user.getStack().isEmpty());
	}

	@Test
	void test_profileLinks_is_not_empty() {
		assertNotNull(user);
		assertNotNull(user.getProfileLinks());
		assertFalse(user.getProfileLinks().isEmpty());
	}
	
	@Test
	void test_notifications_is_not_empty() {
		assertNotNull(user);
		assertNotNull(user.getNotifications());
		assertFalse(user.getNotifications().isEmpty());
	}
}
