import 'package:flutter/material.dart';

class Validators {
  // Main Validator
  static String? validate({
    required TextInputType? keyboardType,
    required String? value,
    TextEditingController? confirmPasswordController,
  }) {
    if (keyboardType == TextInputType.emailAddress) {
      return email(value);
    }

    if (keyboardType == TextInputType.phone) {
      return phone(value);
    }

    if (keyboardType == TextInputType.visiblePassword) {
      if (confirmPasswordController != null) {
        return confirmPassword(value, confirmPasswordController.text);
      }

      return password(value);
    }

    if (keyboardType == TextInputType.number ||
        keyboardType == TextInputType.numberWithOptions()) {
      return number(value);
    }

    return required(value);
  }

  // Required
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be left empty';
    }

    return null;
  }

  // Text
  static String? text(String? value) {
    return required(value);
  }

  // Email
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field cannot be left empty';
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!regex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be left empty';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  // Confirm Password
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be left empty';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Phone
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be left empty';
    }

    final regex = RegExp(r'^\+?[0-9]{8,15}$');

    if (!regex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  // Number
  static String? number(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be left empty';
    }

    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }

    return null;
  }
}
