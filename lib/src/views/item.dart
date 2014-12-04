part of tutorial.views;

final vItem = v.componentFactory(Item);
class Item extends Component {
  @property models.ItemList data;
  @property int itemId;
  @property String title;

  bool _editing = false;
  v.VTextInput _input;

  void create() { element = new LIElement(); }

  void init() {
    element.onDoubleClick.matches('span').listen((e) {
      _editing = true;
      // We can't focus _input Element right now, because it will be created
      // on the next frame. So we can use special [after] Future and wait
      // until next frame is rendered.
      domScheduler.nextFrame.after().then((_) {
        if (_editing) {
          _input.ref.focus();
        }
      });
      invalidate();
      e.stopPropagation();
      e.preventDefault();
    });

    element.onBlur.capture((e) {
      if (_editing) {
        _editing = false;
        data.updateItemTitle(itemId, _input.value);
      }
    });
  }

  build() {
    var children;
    if (_editing) {
      _input = v.textInput(value: title);
      children = [_input];
    } else {
      _input = null;
      children = [v.span()(title)];
    }

    return v.root()(children);
  }
}
