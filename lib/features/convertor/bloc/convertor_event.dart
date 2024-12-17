sealed class ConvertorEvent {}

// Event to fetch all currencies
class GetAllCurrencies extends ConvertorEvent {}

// Event to add a preferred currency
class AddPreferredCurrency extends ConvertorEvent {
  final String currency;

  AddPreferredCurrency(this.currency);
}

// Event to delete a preferred currency
class DeletePreferredCurrency extends ConvertorEvent {
  final String currency;

  DeletePreferredCurrency(this.currency);
}

// Event to update the amount
class UpdateAmount extends ConvertorEvent {
  final double amount;

  UpdateAmount(this.amount);
}

// Event to load preferred currencies
class GetAllPreferredCurrencies extends ConvertorEvent {}

// Event to update the base currency
class UpdateBaseCurrency extends ConvertorEvent {
  final String currency;

  UpdateBaseCurrency(this.currency);
}
