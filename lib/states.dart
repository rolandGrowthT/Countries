import 'cityVOList.dart';
class states {
  final String idState;
  final String stateName;
  final String stateCode;
  final List<CityVO> cityVOList;

  states({
    required this.idState,
    required this.stateName,
    required this.stateCode,
    required this.cityVOList,
  });

  factory states.fromJson(Map<String, dynamic> json) {
    return states(
      idState: json['idState'],
      stateName: json['stateName'],
      stateCode: json['stateCode'],
      cityVOList: List<CityVO>.from(
        json['cityVOList'].map((cityJson) => CityVO.fromJson(cityJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idState': idState,
      'stateName': stateName,
      'stateCode': stateCode,
      'cityVOList': cityVOList.map((city) => city.toJson()).toList(),
    };
  }
}
