import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:currency_converter/user_model.dart';

class CurrencyService {
  Future<CurrencyModel> fetchCurrencyRates() async {
    print("Fetching currency rates...");
    final response = await http.get(
      Uri.parse(
          'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_SnQMgkmAc88RgVEh2pI8yAdmuogqk6ZgEojD4Oyc'),
    );
    print('Response status: ${response.statusCode}');
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      return CurrencyModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load currency rates');
    }
  }
}
