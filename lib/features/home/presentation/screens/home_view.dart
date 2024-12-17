import 'package:currency_converter_app/core/constants/app_paddings.dart';
import 'package:currency_converter_app/core/utils/extensions.dart';
import 'package:currency_converter_app/core/widgets/gap_widgets/horizontal_gap_consistent.dart';
import 'package:currency_converter_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter_app/features/home/bloc/home_bloc.dart';
import 'package:currency_converter_app/features/home/bloc/home_event.dart';
import 'package:currency_converter_app/features/home/bloc/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _selectedBaseCurrency = "USD";
  final TextEditingController _amountController = TextEditingController();
  final List<String> _selectedTargetCurrencies = ["IDR", "EUR"];

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetAllCurrencies());
  }

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Enter amount",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            context
                                .read<HomeBloc>()
                                .add(UpdateAmount(double.tryParse(value) ?? 0));
                          },
                        ),
                      ),
                      DropdownButton<String>(
                        value: _selectedBaseCurrency,
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
                          setState(() {
                            _selectedBaseCurrency = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                VerticalGapWidget(AppPaddings.p20.h),

                Text(
                  "CONVERT TO:",
                  style: context.theme.textTheme.titleSmall,
                ),
                VerticalGapWidget(AppPaddings.p8.h),

                Expanded(
                  child: ListView.builder(
                    itemCount: _selectedTargetCurrencies.length,
                    itemBuilder: (context, index) {
                      final targetCurrency = _selectedTargetCurrencies[index];

                      // Calculate the converted value based on the base currency
                      final baseRate =
                          state.currencies[_selectedBaseCurrency] ?? 1.0;
                      final targetRate =
                          state.currencies[targetCurrency] ?? 1.0;
                      final amount =
                          double.tryParse(_amountController.text) ?? 0;
                      final convertedValue = (amount / baseRate) * targetRate;

                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: AppPaddings.p8.h),
                        padding: EdgeInsets.symmetric(
                            vertical: AppPaddings.p12.h,
                            horizontal: AppPaddings.p16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              convertedValue.toStringAsFixed(2),
                              style:
                                  context.theme.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.flag_circle,
                                    color: Colors.white, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  targetCurrency,
                                  style: context.theme.textTheme.titleMedium,
                                ),
                                HorizontalGapWidget(AppPaddings.p8.w),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _selectedTargetCurrencies.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Add Converter Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Add new target currency
                      setState(() {
                        _selectedTargetCurrencies.add("GBP");
                      });
                    },
                    child: const Text(
                      "+ ADD CONVERTER",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
