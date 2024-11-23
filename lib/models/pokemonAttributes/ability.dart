import 'package:lspokedex/models/pokemonAttributes/item.dart';



class Ability {
    final Item ability;
    final bool is_hidden;
    final int slot;

    Ability({required this.ability, required this.is_hidden, required this.slot}); 

    //Funció usada per a convertir la resposta del fitxer json a un objecte del tipus Ability
    factory Ability.jsonToAbility(Map<String, dynamic> json) {
        return Ability(
            ability: Item.jsonToItem(json['ability']), 
            is_hidden: json['is_hidden'],
            slot: json['slot'],
        );
    }
}

