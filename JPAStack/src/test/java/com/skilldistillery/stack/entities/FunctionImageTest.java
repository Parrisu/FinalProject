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

class FunctionImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private FunctionImage functionImage;
	
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
		functionImage = em.find(FunctionImage.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		functionImage = null;
		
	}

	@Test
	void test_FunctionImage_entity_mapping() {
		assertNotNull(functionImage);
		assertEquals("https://res.cloudinary.com/practicaldev/image/fetch/s--X9Y_p5lV--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/ums3t6d9mjrwdau8zr2i.png", functionImage.getImgUrl());
		
	}
	
	@Test
	void test_FunctionImage_Function_mapping() {
		assertNotNull(functionImage);
		assertEquals("Java meet up", functionImage.getFunction().getName());
	}

}
