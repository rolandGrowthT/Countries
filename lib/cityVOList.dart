class CityVO {
  final String idCity;
  final String cityName;

  CityVO({
    required this.idCity,
    required this.cityName,
  });

  factory CityVO.fromJson(Map<String, dynamic> json) {
    return CityVO(
      idCity: json['idCity'],
      cityName: json['cityName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCity': idCity,
      'cityName': cityName,
    };
  }
}