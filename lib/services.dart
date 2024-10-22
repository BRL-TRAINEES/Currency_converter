import 'dart:convert';
import 'package:currency_converter/user_model.dart';
import 'package:http/http.dart'as http;
class CurrencyService {
  Future<CurrecncyModel>fetchCurrencyRates()async{
    final response = await http.get(Uri.parse('https://v6.exchangerate-api.com/v6/71478dfdd9bb2533b494ba46/latest/USD'));
    if (response ==200) {
      return CurrecncyModel.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load currency rates');
    }
  }
}