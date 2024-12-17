import 'package:bloc/bloc.dart';
import 'package:currency_converter_app/features/home/bloc/home_event.dart';
import 'package:currency_converter_app/features/home/bloc/home_state.dart';
import 'package:currency_converter_app/features/home/data/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository = HomeRepository();

  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async => switch (event) {
          GetAllCurrencies() => _getAllCurrencies(event, emit),
          AddPreferredCurrency() => _addPreferredCurrency(event, emit),
          DeletePreferredCurrency() => _deletePreferredCurrency(event, emit),
          UpdateAmount() => _updateAmount(event, emit),
          GetAllPreferredCurrencies() => _loadPreferredCurrencies(event, emit),
        });
    add(GetAllCurrencies());
    add(GetAllPreferredCurrencies());
  }

  // Fetch all currencies from API
  Future<void> _getAllCurrencies(
      GetAllCurrencies event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final currencies = await homeRepository.fetchAllCurrencies();
      emit(state.copyWith(currencies: currencies, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Add a preferred currency
  Future<void> _addPreferredCurrency(
      AddPreferredCurrency event, Emitter<HomeState> emit) async {
    if (!state.preferredCurrencies.contains(event.currency)) {
      final updatedCurrencies = [...state.preferredCurrencies, event.currency];
      emit(state.copyWith(preferredCurrencies: updatedCurrencies));
      await homeRepository.updatePreferredCurrencies(updatedCurrencies);
    }
  }

  // Delete a preferred currency
  Future<void> _deletePreferredCurrency(
      DeletePreferredCurrency event, Emitter<HomeState> emit) async {
    final updatedCurrencies = state.preferredCurrencies
        .where((currency) => currency != event.currency)
        .toList();
    emit(state.copyWith(preferredCurrencies: updatedCurrencies));
    await homeRepository.updatePreferredCurrencies(updatedCurrencies);
  }

  // Update the amount
  void _updateAmount(UpdateAmount event, Emitter<HomeState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  // Load preferred currencies from local storage
  Future<void> _loadPreferredCurrencies(
      GetAllPreferredCurrencies event, Emitter<HomeState> emit) async {
    final storedCurrencies = await homeRepository.loadPreferredCurrencies();
    emit(state.copyWith(preferredCurrencies: storedCurrencies));
  }
}
