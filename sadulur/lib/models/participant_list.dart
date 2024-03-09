import 'dart:core';

class ParticipantList {
  final String id;
  final String name;
  final List<String> participants;

  ParticipantList(
      {required this.id, required this.name, required this.participants});

  ParticipantList copyWith({
    String? id,
    String? name,
    List<String>? participants,
  }) {
    return ParticipantList(
        id: id ?? this.id,
        name: name ?? this.name,
        participants: participants ?? this.participants);
  }
}
