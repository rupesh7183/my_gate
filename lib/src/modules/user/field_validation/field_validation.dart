class FieldValidation {
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Enter Email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
      return 'Enter valid Email';
    }
    if (value.contains(' ')) {
      return 'Email cannot contain empty space';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Enter Password';
    }
    if (value.length < 6) {
      return 'Password Must contain 6 digits';
    }
    if (value.contains(' ')) {
      return 'Password cannot contain empty space';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Enter name';
    }
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Enter Mobile Number';
    }
    if (value.contains(RegExp(r'[A-Z]'))) {
      return 'Mobile no must be number';
    }
    if (value.length == 10) {
      return 'must contain 10 digits';
    }
  }

  String? validateFlatno(String value) {
    if (value.isEmpty) {
      return 'Enter Flat no';
    }
  }
}
