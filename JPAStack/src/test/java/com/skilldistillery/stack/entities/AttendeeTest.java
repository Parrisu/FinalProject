 package com.skilldistillery.stack.entities;

 import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

 class AttendeeTest {
 	private static EntityManagerFactory emf;
 	private EntityManager em;
 	private Attendee attendee;

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
 		AttendeeId aId = new AttendeeId(1,1);
 		attendee = em.find(Attendee.class, aId);
 	}

 	@AfterEach
 	void tearDown() throws Exception {
 		em.close();
 		attendee = null;
 	}

 	@Test
 	void test_Attendee_User_mapping() {
 		assertNotNull(attendee);
 		assertEquals("admin", attendee.getUser().getFirstName());
 	}

 	@Test
 	void test_Attendee_Function_mapping() {
 		assertNotNull(attendee);
 		assertEquals("Java meet up" , attendee.getFunction().getName());
 	}

 }
