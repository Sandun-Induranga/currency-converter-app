import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';

void showAddConverterDialog(
    BuildContext context, List<String> availableCurrencies) {
  String? selectedCurrency;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              "Select Currency",
              style: TextStyle(color: Colors.white),
            ),
            content: DropdownButton<String>(
              dropdownColor: Colors.grey[800],
              hint: const Text("Choose Currency",
                  style: TextStyle(color: Colors.white)),
              value: selectedCurrency,
              isExpanded: true,
              items: availableCurrencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(
                    currency,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setDialogState(() {
                  selectedCurrency = value;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                    "Cancel", style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (selectedCurrency != null) {
                    // Add the selected currency to the target list
                    if (!context.read<HomeBloc>().state.preferredCurrencies.contains(selectedCurrency)) {
                    context
                        .read<HomeBloc>()
                        .add(AddPreferredCurrency(selectedCurrency!));
                    }
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        }
      );
    },
  );
}
