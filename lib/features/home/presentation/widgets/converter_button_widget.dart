import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:currency_converter_app/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_currency_widget.dart';

class ConverterButtonWidget extends StatelessWidget {
  const ConverterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          showAddConverterDialog(
              context, context.read<HomeBloc>().state.currencies.keys.toList());
        },
        child: Text(
          "+ ADD CONVERTER",
          style: context.theme.textTheme.titleSmall,
        ),
      ),
    );
  }
}
