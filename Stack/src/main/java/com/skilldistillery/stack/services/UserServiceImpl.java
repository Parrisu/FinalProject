package com.skilldistillery.stack.services;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.stack.entities.Address;
import com.skilldistillery.stack.entities.User;
import com.skilldistillery.stack.exceptions.InvalidEntityException;
import com.skilldistillery.stack.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Override
	public Address updateUserAddress(int userId, Address address) throws InvalidEntityException {
		User user = userRepo.findById(userId).orElseThrow(InvalidEntityException::new);
		Map<String, String> errors = new HashMap<>();
		if (!fieldIsValid(address.getStreet(), 300)) {
			errors.put("street", "Street must not be empty and must be under 300 characters in length.");
		}
		
		if (!zipcodeIsValid(address.getZipCode())) {
			errors.put("zipCode", "Zip Code must be a valid use zip code.");
		}

		return null;
	}

	private boolean fieldIsValid(String field, int maxLength) {
		return field != null && !field.isBlank() && field.length() < maxLength && !field.contains("\\s");
	}

	private boolean zipcodeIsValid(String zipCode) {
		boolean isValid = fieldIsValid(zipCode, 8);
		if (isValid) {
			Pattern pattern = Pattern.compile("^\\d{5}(?:[-\\s]\\d{4})?$");
			Matcher matcher = pattern.matcher(zipCode);
			isValid = matcher.matches();
		}
		return isValid;
	}

}
