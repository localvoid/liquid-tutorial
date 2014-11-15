part of tutorial.models;

class ItemList {
  // Here we are creating Dart Streams to listen for notifications when
  // something is changed.
  //
  // If you are not familiar with Dart Stream, you can read about them in this
  // articles:
  // https://www.dartlang.org/docs/tutorials/streams/
  // https://www.dartlang.org/articles/creating-streams/
  StreamController _onChangesController = new StreamController();
  Stream get onChanges => _onChangesController.stream;

  List<Item> items = [];

  // Actions:

  /// Create a new Todo Item
  void createItem(String title) {
    if (title.trim().isNotEmpty) {
      items.add(new Item(title));
      _onChangesController.add(null);
    }
  }

  /// Update title property for Todo item
  void updateItemTitle(int id, String newTitle) {
    if (newTitle.trim().isEmpty) {
      items.removeWhere((i) => i.id == id);
    } else {
      final item = items.firstWhere((i) => i.id == id);
      item.title = newTitle;
    }
    _onChangesController.add(null);
  }
}
