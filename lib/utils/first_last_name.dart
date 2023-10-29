String getFirstAndLastName(String fullName) {
  List<String> names = fullName.split(' ');

  if (names.length >= 2) {
    String firstName = names.first;
    String lastName = names.last;
    return '$firstName $lastName';
  } else {
    return fullName;
  }
}
