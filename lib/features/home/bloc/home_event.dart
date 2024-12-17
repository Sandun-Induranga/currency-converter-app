sealed class HomeEvent {}

// Event to fetch all currencies
class GetAllCurrencies extends HomeEvent {}

// Event to add a preferred currency
class AddPreferredCurrency extends HomeEvent {
  final String currency;

  AddPreferredCurrency(this.currency);
}

// Event to delete a preferred currency
class DeletePreferredCurrency extends HomeEvent {
  final String currency;

  DeletePreferredCurrency(this.currency);
}

// Event to update the amount
class UpdateAmount extends HomeEvent {
  final double amount;

  UpdateAmount(this.amount);
}

// Event to load preferred currencies
class GetAllPreferredCurrencies extends HomeEvent {}
