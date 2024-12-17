import 'package:currency_converter_app/features/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';

class BaseCurrencyWidget extends StatelessWidget {
  const BaseCurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Enter amount",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                context.read<HomeBloc>().add(
                      UpdateAmount(double.tryParse(value) ?? 0),
                    );
              },
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  previous.selectedBaseCurrency !=
                      current.selectedBaseCurrency ||
                  previous.currencies != current.currencies,
              builder: (context, state) {
                return DropdownButton<String>(
                  value: state.selectedBaseCurrency,
                  dropdownColor: Colors.grey[800],
                  style: const TextStyle(color: Colors.white),
                  underline: const SizedBox(),
                  items: state.currencies.keys.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    context.read<HomeBloc>().add(UpdateBaseCurrency(value!));
                  },
                );
              }),
        ],
      ),
    );
  }
}
