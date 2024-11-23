class Item {
    final String name;
    final String url;
  
  Item({required this.name, required this.url});


  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      url: json['url'],
    );
  }
}