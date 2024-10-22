import 'package:currency_converter/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: App()));
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(currencyConverterProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('Currency Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount (USD)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_amountController.text);
                if (amount != null) {
                  ref
                      .read(currencyConverterProvider.notifier)
                      .convert(amount, 'USD', 'INR');
                }
              },
              child: Text('Convert to INR'),
            ),
            SizedBox(height: 15),
            if (isLoading)
              CircularProgressIndicator()
            else
              Consumer(builder: (context, watch, child) {
                final convertedAmount = ref.watch(currencyConverterProvider);

                return convertedAmount.when(
                  data: (amount) => Text(
                      'Converted Amount: ${amount.toStringAsFixed(2)} INR'),
                  loading: () => SizedBox.shrink(),
                  error: (error, stackTrace) => Text('Error: $error'),
                );
              }),
          ],
        ),
      ),
    );
  }
}
