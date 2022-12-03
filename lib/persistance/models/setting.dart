import './track.dart';
import 'effect.dart';

class Setting {
  Setting();

  int? id;
  Track track = Track();
  Effect effect = Effect();
  double gain = 0;
  double volume = 0;
  String voice = 'Clean';
  double param1 = 0;
  double param2 = 0;
  double param3 = 0;
  double bass = 0;
  double middle = 0;
  double treble = 0;

  static Setting fromMap(Map<String, dynamic> json) {
    return Setting()
      ..id = json['set_id']
      ..track = Track.fromMap(json)
      ..effect = Effect.fromMap(json)
      ..gain = (json['set_gain'] as num).toDouble()
      ..volume = (json['set_volume'] as num).toDouble()
      ..voice = json['set_voice'] as String
      ..param1 = (json['set_param1'] as num).toDouble()
      ..param2 = (json['set_param2'] as num).toDouble()
      ..param3 = (json['set_param3'] as num).toDouble()
      ..bass = (json['set_bass'] as num).toDouble()
      ..middle = (json['set_middle'] as num).toDouble()
      ..treble = (json['set_treble'] as num).toDouble();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'set_track': track.id,
      'set_effect': effect.id,
      'set_gain': gain,
      'set_volume': volume,
      'set_voice': voice,
      'set_param1': param1,
      'set_param2': param2,
      'set_param3': param3,
      'set_bass': bass,
      'set_middle': middle,
      'set_treble': treble,
    };
  }
}
