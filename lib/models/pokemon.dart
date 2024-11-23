import 'package:lspokedex/models/pokemonAttributes/ability.dart';
import 'package:lspokedex/models/pokemonAttributes/evolvesTo.dart';
import 'package:lspokedex/models/pokemonAttributes/item.dart';
import 'package:lspokedex/models/pokemonAttributes/stat.dart';
import 'package:lspokedex/models/pokemonAttributes/type.dart';


import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  final int id;
  final String name;
  final List<Ability> abilities;
  final String cries;
  final int height;
  final List<String> location_area_encounters;
  final List<EvolvesTo?> evolves_to;
  final List<Item> moves;
  final Item species;
  final String image;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.abilities,
    required this.cries,
    required this.height,
    required this.location_area_encounters,
    required this.evolves_to,
    required this.moves,
    required this.species,
    required this.image,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

// import 'package:json_annotation/json_annotation.dart';

// part 'models.g.dart';


// @JsonSerializable()
// class CaptureEventRequest {
//   final String team_id;

//   CaptureEventRequest({
//     required this.team_id,
//   });

//   factory CaptureEventRequest.fromJson(Map<String, dynamic> json) => _$CaptureEventRequestFromJson(json);
//   Map<String, dynamic> toJson() => _$CaptureEventRequestToJson(this);
// }

// @JsonSerializable()
// class CaptureEventResponse {
//   final String team_id;
//   final String captured_pokemon_uuid;
//   final List<String> pokemon_uuid_list;

//   CaptureEventResponse({
//     required this.team_id,
//     required this.captured_pokemon_uuid,
//     required this.pokemon_uuid_list,
//   });

//   factory CaptureEventResponse.fromJson(Map<String, dynamic> json) => _$CaptureEventResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$CaptureEventResponseToJson(this);
// }


// 

// @JsonSerializable()
// class EvolveRequest {
//   final List<String> pokemon_uuid_list;
//   final String team_id;

//   EvolveRequest({
//     required this.pokemon_uuid_list,
//     required this.team_id,
//   });

//   factory EvolveRequest.fromJson(Map<String, dynamic> json) => _$EvolveRequestFromJson(json);
//   Map<String, dynamic> toJson() => _$EvolveRequestToJson(this);
// }


// @JsonSerializable()
// class HTTPValidationError {
//   final List<ValidationError>? detail;

//   HTTPValidationError({
//     this.detail,
//   });

//   factory HTTPValidationError.fromJson(Map<String, dynamic> json) => _$HTTPValidationErrorFromJson(json);
//   Map<String, dynamic> toJson() => _$HTTPValidationErrorToJson(this);
// }

// @JsonSerializable()
// class ValidationError {
//   final List<dynamic> loc;
//   final String msg;
//   final String type;

//   ValidationError({
//     required this.loc,
//     required this.msg,
//     required this.type,
//   });

//   factory ValidationError.fromJson(Map<String, dynamic> json) => _$ValidationErrorFromJson(json);
//   Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);
// }


// @JsonSerializable()
// class PokemonBattle {
//   final List<String> pokemons;
//   final String winner;

//   PokemonBattle({
//     required this.pokemons,
//     required this.winner,
//   });

//   factory PokemonBattle.fromJson(Map<String, dynamic> json) => _$PokemonBattleFromJson(json);
//   Map<String, dynamic> toJson() => _$PokemonBattleToJson(this);
// }




// @JsonSerializable()
// class Team {
//   final String id;
//   final String name;
//   final int pve_score;
//   final int pvp_score;
//   final int pokedex_score;
//   final List<CapturedPokemon> captured_pokemons;
//   final bool is_active;

//   Team({
//     required this.id,
//     required this.name,
//     this.pve_score = 0,
//     this.pvp_score = 0,
//     this.pokedex_score = 0,
//     this.captured_pokemons = const [],
//     this.is_active = true,
//   });

//   factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
//   Map<String, dynamic> toJson() => _$TeamToJson(this);
// }

// @JsonSerializable()
// class Tournament {
//   final String id;
//   final String? time;
//   final bool can_register;
//   final List<TournamentTeam> teams;
//   final String? winner;
//   final List<TournamentTeamPosition> teams_positions;
//   final List<TournamentCombat> tournament_combats;

//   Tournament({
//     required this.id,
//     this.time,
//     this.can_register = true,
//     this.teams = const [],
//     this.winner,
//     this.teams_positions = const [],
//     this.tournament_combats = const [],
//   });

//   factory Tournament.fromJson(Map<String, dynamic> json) => _$TournamentFromJson(json);
//   Map<String, dynamic> toJson() => _$TournamentToJson(this);
// }

// @JsonSerializable()
// class TournamentCombat {
//   final List<String> teams;
//   final String winner;
//   final List<TournamentTurn> turns;

//   TournamentCombat({
//     required this.teams,
//     required this.winner,
//     this.turns = const [],
//   });

//   factory TournamentCombat.fromJson(Map<String, dynamic> json) => _$TournamentCombatFromJson(json);
//   Map<String, dynamic> toJson() => _$TournamentCombatToJson(this);
// }

// @JsonSerializable()
// class TournamentTurn {
//   final List<String> pokemons;
//   final String winner;

//   TournamentTurn({
//     required this.pokemons,
//     required this.winner,
//   });

//   factory TournamentTurn.fromJson(Map<String, dynamic> json) => _$TournamentTurnFromJson(json);
//   Map<String, dynamic> toJson() => _$TournamentTurnToJson(this);
// }

// @JsonSerializable()
// class TournamentTeam {
//   final String team_id;
//   final List<String> pokemon_uuid_list;

//   TournamentTeam({
//     required this.team_id,
//     this.pokemon_uuid_list = const [],
//   });

//   factory TournamentTeam.fromJson(Map<String, dynamic> json) => _$TournamentTeamFromJson(json);
//   Map<String, dynamic> toJson() => _$TournamentTeamToJson(this);
// }




// @JsonSerializable()
// class ZoneResponse {
//   final String id;
//   final String name;
//   final double cooldown_period;
//   final List<ZoneRequestByTeam> last_requests_by_team;

//   ZoneResponse({
//     required this.id,
//     required this.name,
//     required this.cooldown_period,
//     this.last_requests_by_team = const [],
//   });

//   factory ZoneResponse.fromJson(Map<String, dynamic> json) => _$ZoneResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$ZoneResponseToJson(this);
// }

// @JsonSerializable()
// class ZoneRequestByTeam {
//   final String team_id;
//   final String time;

//   ZoneRequestByTeam({
//     required this.team_id,
//     required this.time,
//   });

//   factory ZoneRequestByTeam.fromJson(Map<String, dynamic> json) => _$ZoneRequestByTeamFromJson(json);
//   Map<String, dynamic> toJson() => _$ZoneRequestByTeamToJson(this);
// }

// // Note: To generate the `*.g.dart` files, you need to run the following command:
// // flutter pub run build_runner build
