class HomeState {
  final List<String> preferredCurrencies;
  final List<String> availableCurrencies;

  const HomeState({
    required this.preferredCurrencies,
    required this.availableCurrencies,
  });

  static HomeState initialState() => const HomeState(
        preferredCurrencies: ["EUR", "GBP", "JPY"],
        availableCurrencies: ["USD", "EUR", "GBP", "JPY", "AUD"],
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeState &&
        other.preferredCurrencies == preferredCurrencies &&
        other.availableCurrencies == availableCurrencies;
  }

  @override
  int get hashCode =>
      preferredCurrencies.hashCode ^ availableCurrencies.hashCode;
}
