import 'dart:convert';
class CurrecncyModel {
  final String basecode;
  final Map<String,double> conversionRates;

  CurrecncyModel({
    required this.basecode,
    required this.conversionRates,

  });
  factory CurrecncyModel.fromJson(Map < String , dynamic json){
    return CurrecncyModel(basecode: json['base_code'], conversionRates:Map<String,double>.from(json['conversion_rates']) );
  }
}