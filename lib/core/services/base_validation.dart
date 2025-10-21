import 'package:easy_localization/easy_localization.dart';

class BaseValidation {
  /// Check if a string is empty
  static String? requiredField(String? value, {String? message}) {
  message ??= "fieldRequired".tr(); 
  if (value == null || value.trim().isEmpty) {
    return message;
  }
  return null;
}

  /// Validate email format
static String? email(String? value, {String? message}) {
  message ??= "enterValidEmail".tr();
  if (value == null || value.trim().isEmpty) return message;
  final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  if (!regex.hasMatch(value)) {
    return message;
  }
  return null;
}


  /// Validate phone number (basic example)
  static String? phone(String? value, {String? message}) {
  message ??= "enterValidPhone".tr();
  if (value == null || value.trim().isEmpty) return message;
  final regex = RegExp(r"^[0-9]{8,15}$"); // adjust rules as needed
  if (!regex.hasMatch(value)) {
    return message;
  }
  return null;
}

  /// Validate username
static String? userName(String? value, {String? message}) {
  message ??= "usernameMinChars".tr();
  if (value == null || value.length < 3) {
    return message;
  }
  return null;
}

  /// Validate password (min 6 chars)
static String? password(String? value, {String? message}) {
  message ??= "passwordMinChars".tr();
  if (value == null || value.length < 6) {
    return message;
  }
  return null;
}


  /// Confirm password
static String? confirmPassword(String? value, String? compareWith, {String? message}) {
  message ??= "passwordsDoNotMatch".tr();
  if (value != compareWith) {
    return message;
  }
  return null;
}

  // /// Validate min length
  // static String? minLength(String? value, int min, {String? message}) {
  //   if (value == null || value.length < min) {
  //     return message ?? "Must be at least $min characters";
  //   }
  //   return null;
  // }

  // /// Validate max length
  // static String? maxLength(String? value, int max, {String? message}) {
  //   if (value != null && value.length > max) {
  //     return message ?? "Must be at most $max characters";
  //   }
  //   return null;
  // }


  /// Validate min length
static String? minLength(String? value, int min, {String? message}) {
  message ??= "minLength".tr(args: [min.toString()]);
  if (value == null || value.length < min) {
    return message;
  }
  return null;
}

/// Validate max length
static String? maxLength(String? value, int max, {String? message}) {
  message ??= "maxLength".tr(args: [max.toString()]);
  if (value != null && value.length > max) {
    return message;
  }
  return null;
}
}