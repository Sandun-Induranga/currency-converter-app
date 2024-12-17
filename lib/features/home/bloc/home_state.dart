class HomeState {
  final Map<String, double> currencies;
  final List<String> preferredCurrencies;
  final bool isLoading;
  final String? error;
  final double amount;

  HomeState({
    required this.currencies,
    required this.preferredCurrencies,
    required this.isLoading,
    this.error,
    required this.amount,
  });

  factory HomeState.initial() => HomeState(
    currencies: {},
    preferredCurrencies: [],
    isLoading: false,
    error: null,
    amount: 0,
  );

  HomeState copyWith({
    Map<String, double>? currencies,
    List<String>? preferredCurrencies,
    bool? isLoading,
    String? error,
    double? amount,
  }) {
    return HomeState(
      currencies: currencies ?? this.currencies,
      preferredCurrencies: preferredCurrencies ?? this.preferredCurrencies,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      amount: amount ?? this.amount,
    );
  }
}
