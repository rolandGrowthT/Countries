class PostModel {
  final String idCountry;
  final String countryName;
  final String countryCode;
  final String isoCode2;
  final String isoCode3;

  PostModel({
    required this.idCountry,
    required this.countryName,
    required this.countryCode,
    required this.isoCode2,
    required this.isoCode3,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      idCountry: json['idCountry'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
      isoCode2: json['isoCode2'],
      isoCode3: json['isoCode3'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCountry': idCountry,
      'countryName': countryName,
      'countryCode': countryCode,
      'isoCode2': isoCode2,
      'isoCode3': isoCode3,
    };
  }
}
