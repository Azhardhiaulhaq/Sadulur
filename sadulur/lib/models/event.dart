import 'dart:core';
import 'dart:io';

class Event {
  final String id;
  final String name;
  final String description;
  final String? bannerImage;
  final String location;
  final String? link;
  final DateTime date;
  final String author;
  final String contactPerson;
  final File? banner;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      this.bannerImage,
      required this.location,
      this.link,
      required this.date,
      required this.author,
      required this.contactPerson,
      this.banner});

  Event copyWith(
      {String? id,
      String? name,
      String? description,
      String? bannerImage,
      String? location,
      String? link,
      DateTime? date,
      String? author,
      String? contactPerson,
      File? banner}) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      bannerImage: bannerImage ?? this.bannerImage,
      location: location ?? this.location,
      link: link ?? this.link,
      date: date ?? this.date,
      author: author ?? this.author,
      contactPerson: contactPerson ?? this.contactPerson,
      banner: banner ?? this.banner,
    );
  }
}
