part of tutorial.views;

final vItemList = v.dynamicTreeFactory(({data}) {
  return v.ul()(data.items.map((i) {
    return vItem(
        key: i.id,
        data: data,
        title: i.title,
        itemId: i.id);
  }).toList());
});
