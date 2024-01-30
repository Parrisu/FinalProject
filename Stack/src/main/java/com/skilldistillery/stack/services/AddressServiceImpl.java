package com.skilldistillery.stack.services;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.entities.City;
import com.skilldistillery.stack.exceptions.EntityDoesNotExistException;
import com.skilldistillery.stack.exceptions.InvalidEntityException;
import com.skilldistillery.stack.repositories.AddressRepository;
import com.skilldistillery.stack.repositories.CityRepository;

@Service
public class AddressServiceImpl implements AddressService {

	@Autowired
	private AddressRepository addressRepo;

	@Autowired
	private CityRepository cityRepo;

	@Override
	public Address createAddress(Address address)
			throws EntityDoesNotExistException, InvalidEntityException {

		City city = cityRepo.findById(address.getCity().getId()).orElse(null);
		if (city == null) {
			throw new EntityDoesNotExistException("City does not exist.");
		}

		Map<String, String> errors = new HashMap<>();

		if (!fieldIsValid(address.getStreet(), 300)) {
			errors.put("street", "Street must not be empty and must be under 300 characters in length.");
		}

		if (!zipcodeIsValid(address.getZipCode())) {
			errors.put("zipCode", "Zip Code must be a valid use zip code.");
		}

		if (!errors.isEmpty()) {
			throw new InvalidEntityException(errors);
		}

		address.setCity(city);
		return addressRepo.saveAndFlush(address);
	}

	private boolean fieldIsValid(String field, int maxLength) {
		return field != null && !field.isBlank() && field.length() <= maxLength && !field.contains("\\s");
	}

	private boolean zipcodeIsValid(String zipCode) {
		boolean isValid = fieldIsValid(zipCode, 11);
		if (isValid) {
			Pattern pattern = Pattern.compile("^\\d{5}(?:[-\\s]\\d{4})?$");
			Matcher matcher = pattern.matcher(zipCode);
			isValid = matcher.matches();
		}
		return isValid;
	}

}
