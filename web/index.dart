import 'dart:html';
import 'package:liquid/liquid.dart';
import 'package:liquid_tutorial/models.dart' as models;
import 'package:liquid_tutorial/views.dart' as views;

void main() {
  final data = new models.ItemList();
  injectComponent(new views.App()..data = data, document.body);
}
