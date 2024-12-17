import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_codes.dart';
import '../../bloc/convertor_bloc.dart';
import 'add_currency_widget.dart';

class ConverterButtonWidget extends StatelessWidget {
  const ConverterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorCodes.successColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          showAddConverterDialog(
            context,
            context.read<ConvertorBloc>().state.currencies.keys.toList(),
          );
        },
        child: Text(
          "+ ADD CONVERTER",
          style: context.theme.textTheme.titleSmall,
        ),
      ),
    );
  }
}
