
part 'equalization.g.dart';

class Equalization {
  Equalization();

  double bass = 5.0;
  double middle = 5.0;
  double treble = 5.0;

  factory Equalization.fromJson(Map<String, dynamic> json) =>
      _$EqualizationFromJson(json);

  Map<String, dynamic> toJson() => _$EqualizationToJson(this);
}
