part of tutorial.views;

class Header extends vdom.Node {
  Header(Object key) : super(key);

  void create(_) {
    ref = new HeadingElement.h1()
      ..id = 'header';
  }

  void render(_) {
    ref.text = 'TODO Application';
  }
}
