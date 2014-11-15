part of tutorial.views;

class ItemList extends VComponent {
  models.ItemList data;

  ItemList(Context context, this.data) : super('ul', context);

  build() =>
      vdom.ul(0, data.items.map((i) => Item.virtual(i.id, data, i)).toList());

  static virtual(Object key, models.ItemList data) {
    return new VDomComponent(key, (component, context) {
      if (component == null) {
        return new ItemList(context, data);
      }
      component.update();
    });
  }
}
