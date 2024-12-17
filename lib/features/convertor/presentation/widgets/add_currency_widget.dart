import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_codes.dart';
import '../../bloc/convertor_bloc.dart';
import '../../bloc/convertor_event.dart';

void showAddConverterDialog(
    BuildContext context, List<String> availableCurrencies) {
  String? selectedCurrency;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setDialogState) {
        return AlertDialog(
          backgroundColor: ColorCodes.secondaryColor,
          title: Text(
            "Select Currency",
            style: context.theme.textTheme.titleLarge,
          ),
          content: DropdownButton<String>(
            dropdownColor: ColorCodes.secondaryColor,
            hint: Text(
              "Choose Currency",
              style: context.theme.textTheme.titleMedium,
            ),
            value: selectedCurrency,
            isExpanded: true,
            items: availableCurrencies.map((currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(
                  currency,
                  style: context.theme.textTheme.titleMedium,
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
              child: Text(
                "Cancel",
                style: context.theme.textTheme.titleMedium!
                    .copyWith(color: ColorCodes.errorColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorCodes.successColor,
              ),
              onPressed: () {
                if (selectedCurrency != null) {
                  // Add the selected currency to the target list
                  if (!context
                      .read<ConvertorBloc>()
                      .state
                      .preferredCurrencies
                      .contains(selectedCurrency)) {
                    context
                        .read<ConvertorBloc>()
                        .add(AddPreferredCurrency(selectedCurrency!));
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Add",
                style: context.theme.textTheme.titleMedium,
              ),
            ),
          ],
        );
      });
    },
  );
}
