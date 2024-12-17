import 'package:currency_converter_app/core/constants/app_paddings.dart';
import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:currency_converter_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter_app/features/home/bloc/home_bloc.dart';
import 'package:currency_converter_app/features/home/bloc/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/base_currency_widget.dart';
import '../widgets/converter_button_widget.dart';
import '../widgets/preferred_currency_list_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Advanced Exchanger",
          style: context.theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
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

                // ConverterButtonWidget
                const ConverterButtonWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
