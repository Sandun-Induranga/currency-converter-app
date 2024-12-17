import 'package:bloc/bloc.dart';

import '../data/convertor_repository.dart';
import 'convertor_event.dart';
import 'convertor_state.dart';

class ConvertorBloc extends Bloc<ConvertorEvent, ConvertorState> {
  final ConvertorRepository convertorRepository = ConvertorRepository();

  ConvertorBloc() : super(ConvertorState.initial()) {
    on<ConvertorEvent>((event, emit) async => switch (event) {
          GetAllCurrencies() => _getAllCurrencies(event, emit),
          AddPreferredCurrency() => _addPreferredCurrency(event, emit),
          DeletePreferredCurrency() => _deletePreferredCurrency(event, emit),
          UpdateAmount() => _updateAmount(event, emit),
          GetAllPreferredCurrencies() => _loadPreferredCurrencies(event, emit),
          UpdateBaseCurrency() => _updateBaseCurrency(event, emit),
        });
    add(GetAllCurrencies());
    add(GetAllPreferredCurrencies());
  }

  // Fetch all currencies from API
  Future<void> _getAllCurrencies(
      GetAllCurrencies event, Emitter<ConvertorState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final currencies = await convertorRepository.fetchAllCurrencies();
      emit(state.copyWith(currencies: currencies, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Add a preferred currency
  Future<void> _addPreferredCurrency(
      AddPreferredCurrency event, Emitter<ConvertorState> emit) async {
    if (!state.preferredCurrencies.contains(event.currency)) {
      try {
        final updatedCurrencies = [
          ...state.preferredCurrencies,
          event.currency
        ];
        emit(state.copyWith(preferredCurrencies: updatedCurrencies));
        await convertorRepository.updatePreferredCurrencies(updatedCurrencies);
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    }
  }

  // Delete a preferred currency
  Future<void> _deletePreferredCurrency(
      DeletePreferredCurrency event, Emitter<ConvertorState> emit) async {
    try {
      final updatedCurrencies = state.preferredCurrencies
          .where((currency) => currency != event.currency)
          .toList();
      emit(state.copyWith(preferredCurrencies: updatedCurrencies));
      await convertorRepository.updatePreferredCurrencies(updatedCurrencies);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  // Update the amount
  void _updateAmount(UpdateAmount event, Emitter<ConvertorState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  // Load preferred currencies from local storage
  Future<void> _loadPreferredCurrencies(
      GetAllPreferredCurrencies event, Emitter<ConvertorState> emit) async {
    try {
      final storedCurrencies = await convertorRepository.loadPreferredCurrencies();
      emit(state.copyWith(preferredCurrencies: storedCurrencies));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  // Update the base currency
  void _updateBaseCurrency(UpdateBaseCurrency event, Emitter<ConvertorState> emit) {
    emit(state.copyWith(selectedBaseCurrency: event.currency));
  }
}
