package com.skilldistillery.stack.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
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
		assertEquals("1922 13th St", address.getStreet());
		assertEquals("80302", address.getZipCode());
		assertEquals("Boulder", address.getCity());
		assertEquals("CO", address.getStateAbbreviation());
	}

	@Test
	void test_Address_User_mapping() {
		assertNotNull(address);
		assertTrue(0 < address.getUsers().size());
		assertFalse(address.getUsers().isEmpty());
	}

	@Test
	void test_Address_Function_mapping() {
		assertNotNull(address);
		assertTrue(0 < address.getFunctions().size());
		assertFalse(address.getFunctions().isEmpty());
	}

}
