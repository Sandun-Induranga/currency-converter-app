import 'package:currency_converter_app/core/constants/app_paddings.dart';
import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_codes.dart';
import '../../bloc/convertor_bloc.dart';
import '../../bloc/convertor_event.dart';
import '../../bloc/convertor_state.dart';

class BaseCurrencyWidget extends StatelessWidget {
  const BaseCurrencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPaddings.p12.w),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter amount",
                hintStyle: context.theme.textTheme.titleMedium!.copyWith(
                  color: ColorCodes.accentColor.withOpacity(0.5),
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                context.read<ConvertorBloc>().add(
                      UpdateAmount(double.tryParse(value) ?? 0),
                    );
              },
            ),
          ),
          BlocBuilder<ConvertorBloc, ConvertorState>(
              buildWhen: (previous, current) =>
                  previous.selectedBaseCurrency !=
                      current.selectedBaseCurrency ||
                  previous.currencies != current.currencies,
              builder: (context, state) {
                return DropdownButton<String>(
                  value: state.selectedBaseCurrency,
                  dropdownColor: ColorCodes.secondaryColor,
                  underline: const SizedBox(),
                  items: state.currencies.keys.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (value) {
                    context.read<ConvertorBloc>().add(
                          UpdateBaseCurrency(value!),
                        );
                  },
                );
              }),
        ],
      ),
    );
  }
}
