import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart'; 

@JsonSerializable()
class Item {
    final String name;
    final String url;

    Item({required this.name, required this.url});

    //Funció usada per a convertir la resposta del fitxer json a un objecte del tipus Item
    factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

    //Funció usada per a convertir un objecte de tipus Item a format fitxer json.
    Map<String, dynamic> toJson() => _$ItemToJson(this);
}