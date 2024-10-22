class CurrencyModel {
  final String baseCode;
  final Map<String, double> conversionRates;

  CurrencyModel({
    required this.baseCode,
    required this.conversionRates,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      baseCode: json['base_code'] ?? 'USD',
      conversionRates: (json["data"] as Map<String, dynamic>).map((key, value) {
        return MapEntry(
            key, (value is int) ? value.toDouble() : value.toDouble());
      }),
    );
  }
}
