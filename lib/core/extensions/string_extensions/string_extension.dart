extension StringExtintion on String {
  String myCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase().replaceAll("_", " ")}";
  }

  String get toPrice => "${replaceAllMapped(
        RegExp(r'(\d{1})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      )} IQD";
}

String convertToTitleCase(String? input) {
  if (input == null || input.isEmpty) {
    return "";
  }
  List<String> words = input.split("_");
  words =
      words.map((word) => word[0].toUpperCase() + word.substring(1)).toList();
  return words.join(" ");
}
