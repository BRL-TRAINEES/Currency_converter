import 'package:currency_converter/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends ConsumerWidget {
  final TextEditingController _amountController = TextEditingController();

  CurrencyConverterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(currencyConverterProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Currency Converter'),
      backgroundColor: Color(0xFF0000FF),
      titleTextStyle: TextStyle(color: Colors.white,
      fontSize: 24,),
      ),
      backgroundColor: Color(0xFFADD8E6),
      body: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network('https://static.vecteezy.com/system/resources/previews/002/151/430/large_2x/global-currency-exchange-icon-transfer-money-stock-market-abstract-background-vector.jpg',
            height: 300,),
            SizedBox(height: 20,),
            
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount (USD)',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue,width: 2.0),
              )),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_amountController.text);
                if (amount != null) {
                  ref
                      .read(currencyConverterProvider.notifier)
                      .convert(amount, 'USD', 'INR');
                }
              },
              child: const Text('Convert to INR'),
            ),
            const SizedBox(height: 15),
            if (isLoading)
              const CircularProgressIndicator()
            else
              Consumer(builder: (context, watch, child) {
                final convertedAmount = ref.watch(currencyConverterProvider);

                return convertedAmount.when(
                  data: (amount) => Text(
                      'Converted Amount: ${amount.toStringAsFixed(2)} INR'),
                  loading: () => const SizedBox.shrink(),
                  error: (error, stackTrace) => Text('Error: $error'),
                );
              }),
          ],
        ),
      ),
    );
  }
}
