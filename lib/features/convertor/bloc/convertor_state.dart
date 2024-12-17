class ConvertorState {
  final Map<String, double> currencies;
  final List<String> preferredCurrencies;
  final bool isLoading;
  final String? error;
  final double amount;
  final String selectedBaseCurrency;

  ConvertorState({
    required this.currencies,
    required this.preferredCurrencies,
    required this.isLoading,
    this.error,
    required this.amount,
    required this.selectedBaseCurrency,
  });

  factory ConvertorState.initial() => ConvertorState(
    currencies: {},
    preferredCurrencies: [],
    isLoading: false,
    error: null,
    amount: 0,
    selectedBaseCurrency: 'USD',
  );

  ConvertorState copyWith({
    Map<String, double>? currencies,
    List<String>? preferredCurrencies,
    bool? isLoading,
    String? error,
    double? amount,
    String? selectedBaseCurrency,
  }) {
    return ConvertorState(
      currencies: currencies ?? this.currencies,
      preferredCurrencies: preferredCurrencies ?? this.preferredCurrencies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      amount: amount ?? this.amount,
      selectedBaseCurrency: selectedBaseCurrency ?? this.selectedBaseCurrency,
    );
  }
}
