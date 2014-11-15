part of tutorial.views;

class Item extends VComponent {
  final models.ItemList data;
  final int id;

  String title;

  bool _editing = false;
  vdom.TextInput _input;

  Item(Context context, this.data, this.id, this.title) : super('li', context) {
    Zone.ROOT.run(() {
      element.onDoubleClick.matches('span').listen((e) {
        _editing = true;
        invalidate();
        // We can't focus _input Element right now, because it will be created
        // on the next frame. So we can use special [after] Future and wait
        // until next frame is rendered.
        Scheduler.nextFrame.after().then((_) {
          if (_editing) {
            (_input.ref as InputElement).focus();
          }
        });
      });

      element.onBlur.capture((e) {
        if (_editing) {
          _editing = false;
          invalidate();
        }
      });
    });
  }

  build() {
    var children;
    if (_editing) {
      _input = vdom.textInput(#input, value: title);
      children = [_input];
    } else {
      _input = null;
      children = [vdom.span(#text, [vdom.t(title)])];
    }

    return vdom.li(0, children);
  }

  void updateProperties(String newTitle) {
    if (title != newTitle) {
      title = newTitle;
      update();
    }
  }

  static virtual(Object key, models.ItemList data, models.Item item) {
    return new VDomComponent(key, (component, context) {
      if (component == null) {
        return new Item(context, data, item.id, item.title);
      }
      component.updateProperties(item.title);
    });
  }
}
