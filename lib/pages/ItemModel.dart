class ItemModel {
  final String value;
  final String name;
  final String img;
  bool accepting;

  ItemModel({
    required this.value,
    required this.name,
    required this.img,
    this.accepting = false,
  });
}