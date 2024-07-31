class DummyDB {
  static final List<String> _titles = [];
  static final List<String> _descriptions = [];
  static final List<String> _dates = [];

  static void saveTitle(String title, String description, String date) {
    _titles.add(title);
    _descriptions.add(description);
    _dates.add(date);
  }

  static List<String> getTitles() {
    return _titles;
  }

  static List<String> getDescriptions() {
    return _descriptions;
  }

  static List<String> getDates() {
    return _dates;
  }
}
