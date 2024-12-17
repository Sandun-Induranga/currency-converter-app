import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_paddings.dart';
import '../../../../core/widgets/gap_widgets/horizontal_gap_consistent.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';

class CurrencyCardWidget extends StatelessWidget {
  const CurrencyCardWidget({
    super.key,
    required this.targetCurrency,
    this.convertedValue = 0.0,
  });

  final String targetCurrency;
  final double convertedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppPaddings.p8.h),
      padding: EdgeInsets.symmetric(
        vertical: AppPaddings.p12.h,
        horizontal: AppPaddings.p16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            convertedValue.toStringAsFixed(2),
            style: context.theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            children: [
              Icon(Icons.flag_circle, color: Colors.white, size: 18.r),
              HorizontalGapWidget(AppPaddings.p4.w),
              Text(
                targetCurrency,
                style: context.theme.textTheme.titleMedium,
              ),
              HorizontalGapWidget(AppPaddings.p8.w),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  context.read<HomeBloc>().add(
                        DeletePreferredCurrency(targetCurrency),
                      );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
