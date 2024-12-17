import 'package:currency_converter_app/core/constants/app_paddings.dart';
import 'package:currency_converter_app/core/widgets/gap_widgets/vertical_gap_consistent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _amountController = TextEditingController();
  final List<String> _preferredCurrencies = ["EUR", "GBP", "JPY"];
  final List<String> _availableCurrencies = ["USD", "EUR", "GBP", "JPY", "AUD"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter amount",
                border: OutlineInputBorder(),
              ),
            ),
            VerticalGapWidget(AppPaddings.p20.h),
            const Text(
              "Select Input Currency:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select Currency"),
              value: "USD",
              items: _availableCurrencies.map((currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            VerticalGapWidget(AppPaddings.p20.h),
            const Text(
              "Preferred Target Currencies:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _preferredCurrencies.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_preferredCurrencies[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _preferredCurrencies.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
