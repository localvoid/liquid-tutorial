part of tutorial.views;

class App extends Component {
  @property models.ItemList data;

  v.VTextInput _input;
  String _title = '';

  void init() {
    data.onChanges.listen((_) {
      // Invalidate Component when data is changed.
      //
      // When we invalidate Component, it means that it will
      // be updated on the next rendering frame.
      //
      // This way we can update DOM in batches, no need to
      // update it as soon as possible, especially when the
      // state can be changed mutiple times before browser
      // starts to render new frame.
      invalidate();
    });

    // Add Event Listeners using Event-Delegation.
    element.onKeyPress.matches('input').listen((e) {
      if (e.keyCode == KeyCode.ENTER) {
        if (_input.value.isNotEmpty) {
          data.createItem(_input.value);
          _title = '';
        }
        e.stopPropagation();
        e.preventDefault();
      }
    });
  }

  build() {
    // Here we are assigning VTextInput to [_input] property, so we can
    // reference it from the event listeners.
    _input = v.textInput(value: _title);

    return v.root()([
      vHeader(),
      vItemList(data: data),
      _input
    ]);
  }
}
