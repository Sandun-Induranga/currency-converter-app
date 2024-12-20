import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/convertor_bloc.dart';
import '../../bloc/convertor_state.dart';
import 'currency_card_widget.dart';

class PreferredCurrencyListWidget extends StatelessWidget {
  const PreferredCurrencyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConvertorBloc, ConvertorState>(
        builder: (context, state) {
      return ListView.builder(
        itemCount: state.preferredCurrencies.length,
        itemBuilder: (context, index) {
          final targetCurrency = state.preferredCurrencies[index];

          // Calculate the converted value based on the base currency
          final baseRate = state.currencies[state.selectedBaseCurrency] ?? 1.0;
          final targetRate = state.currencies[targetCurrency] ?? 1.0;
          final convertedValue = (state.amount / baseRate) * targetRate;

          return CurrencyCardWidget(
            targetCurrency: targetCurrency,
            convertedValue: convertedValue,
          );
        },
      );
    });
  }
}
