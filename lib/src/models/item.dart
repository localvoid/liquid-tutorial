part of tutorial.models;

class Item {
  static int _nextId = 0; // Used for Auto-Incremental Unique Keys

  final int id;
  String title;

  Item(this.title) : id = _nextId++;
}
