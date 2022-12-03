class Effect {
  Effect();

  int id = 0;
  String name = '';
  String param1 = '';
  String param2 = '';
  String param3 = '';

  static Effect fromMap(Map<String, dynamic> json) {
    return Effect()
      ..id =  json['eff_id']
      ..name = json['eff_name']
      ..param1 = json['eff_param1']
      ..param2 = json['eff_param2']
      ..param3 = json['eff_param3'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eff_id': id,
      'eff_name': name,
      'eff_param1': param1,
      'eff_param2': param2,
      'eff_param3': param3
    };
  }
}
