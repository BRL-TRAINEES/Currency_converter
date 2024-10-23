import 'package:currency_converter/services.dart';
import 'package:currency_converter/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currencyServiceProvider = Provider((ref) => CurrencyService());

final currencyRateProvider = FutureProvider<CurrencyModel>((ref) async {
  final currencyService = ref.watch(currencyServiceProvider);
  return await currencyService.fetchCurrencyRates();
});

final currencyConverterProvider =
    StateNotifierProvider<CurrencyConverterNotifier, AsyncValue<double>>((ref) {//when state changes automatically rebuilds all the widgets which are watching or reading this state
  return CurrencyConverterNotifier(ref);
});

class CurrencyConverterNotifier extends StateNotifier<AsyncValue<double>> {
  CurrencyConverterNotifier(this.ref) : super(const AsyncValue.data(0.0));//sets the initial converted amount to 0.0
  final Ref ref;//declares variable ref to interact with the providers

  void convert(double amount, String fromCurrency, String toCurrency) async {
    state = const AsyncValue.loading();
    try {
      final currencyRatesAsyncValue =
          await ref.read(currencyRateProvider.future);//.future allows direct access to the future returned by currency rate provider

      final rates = currencyRatesAsyncValue.conversionRates;//accesses the conversion rates from model.dart
      final fromRate = rates[fromCurrency];
      final toRate = rates[toCurrency];

      if (fromRate != null && toRate != null) {
        state = AsyncValue.data(amount * (toRate / fromRate));
      } else {
        state = AsyncValue.error('Invalid currency rates', StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
