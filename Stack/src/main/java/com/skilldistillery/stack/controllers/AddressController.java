package com.skilldistillery.stack.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;
import com.skilldistillery.stack.services.AddressService;

@RestController
@CrossOrigin({ "*", "http://localhost/" })
@RequestMapping({ "api/cities/{cityId}/addresses" })
public class AddressController {

	@Autowired
	private AddressService addressService;

	@PostMapping
	public Address createNewAddress(@RequestBody Address address, @PathVariable("cityId") int cityId)
			throws EntityDoesNotExistException, InvalidEntityException {
		return addressService.createAddress(address, cityId);
	}
}
