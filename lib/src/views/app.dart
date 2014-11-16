part of tutorial.views;

class App extends VComponent {
  models.ItemList data;
  vdom.TextInput _input;
  String _title = '';

  App(Context context, this.data) : super('div', context) {
    // Root-Level Html Element for this component is created at this stage,
    // so we can use Event Delegation to listen for children events.
    element.onKeyPress.matches('input').listen((e) {
      if (e.keyCode == KeyCode.ENTER) {
        if (_title.isNotEmpty) {
          data.createItem(_title);
          _title = '';
          // When we invalidate Component, it means that it will be updated
          // on the next rendering frame.
          //
          // This way we can update DOM in batches, no need to update it as
          // soon as possible, especially when the state can be changed
          // mutiple times before browser starts to render new frame.
          invalidate();
        }
        e.stopPropagation();
        e.preventDefault();
      }
    });
    element.onInput.matches('input').listen((e) {
      _title = _input.value;
      e.stopPropagation();
    });
  }

  build() {
    // textInput is a special vdom Node that is declared in "liquid/forms.dart"
    // library.
    //
    // We've created special wrappers for the Form Elements to make them work.
    //
    // And we are assigning it to [_input], so we can reference it from the
    // event listeners. Virtual DOM diff/patch algorithm will transfer state
    // from the previous tree to the new one, so that we can always access real
    // dom element from the latest VDom tree.
    _input = vdom.textInput(#input, value: _title);

    return vdom.div(0,
        [new Header(#header),
         ItemList.virtual(#list, data),
         _input]);
  }
}
