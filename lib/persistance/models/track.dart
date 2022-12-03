import 'dart:core';

class Track {
  Track();

  int? id;
  String name = '';
  String artist = '';

  static Track fromMap(Map<String, dynamic> json) {
    return Track()
      ..id = json['tck_id']
      ..name = json['tck_name']
      ..artist = json['tck_artist'];
  }

  static Map<String, dynamic> toMap(Track track) {
    return {
      'tck_id': track.id,
      'tck_name': track.name,
      'tck_artist': track.artist
    };
  }
}
