import 'package:currency_converter_app/core/constants/app_paddings.dart';
import 'package:currency_converter_app/core/constants/color_codes.dart';
import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:currency_converter_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/convertor_bloc.dart';
import '../../bloc/convertor_state.dart';
import '../widgets/base_currency_widget.dart';
import '../widgets/converter_button_widget.dart';
import '../widgets/preferred_currency_list_widget.dart';

class ConvertorView extends StatelessWidget {
  const ConvertorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCodes.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorCodes.primaryColor,
        title: Text(
          "Advanced Exchanger",
          style: context.theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ConvertorBloc, ConvertorState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            return state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "INSERT AMOUNT:",
                          style: context.theme.textTheme.titleSmall,
                        ),
                        VerticalGapWidget(AppPaddings.p8.h),

                        // BaseCurrencyWidget
                        const BaseCurrencyWidget(),
                        VerticalGapWidget(AppPaddings.p20.h),
                        Text(
                          "CONVERT TO:",
                          style: context.theme.textTheme.titleSmall,
                        ),
                        VerticalGapWidget(AppPaddings.p8.h),

                        // PreferredCurrencyListWidget
                        const Expanded(
                          child: PreferredCurrencyListWidget(),
                        ),

                        // Error message
                        BlocListener<ConvertorBloc, ConvertorState>(
                          listenWhen: (previous, current) =>
                              previous.error != current.error,
                          listener: (context, state) {
                            if (state.error?.isNotEmpty == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.error!),
                                  backgroundColor: ColorCodes.errorColor,
                                ),
                              );
                            }
                          },
                          child: Text(state.error ?? ""),
                        ),
                        // ConverterButtonWidget
                        const ConverterButtonWidget(),
                      ],
                    ),
                  );
          }),
    );
  }
}
