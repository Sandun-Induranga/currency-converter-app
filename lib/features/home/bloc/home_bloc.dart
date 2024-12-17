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
        });
  }

  // Fetch all currencies from API
  Future<void> _getAllCurrencies(
      GetAllCurrencies event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final currencies =
          await homeRepository.fetchAllCurrencies();
      emit(state.copyWith(currencies: currencies, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
      print(e);
    }
  }

  // Add a preferred currency
  void _addPreferredCurrency(
      AddPreferredCurrency event, Emitter<HomeState> emit) {
    if (!state.preferredCurrencies.contains(event.currency)) {
      emit(state.copyWith(
          preferredCurrencies: [...state.preferredCurrencies, event.currency]));
    }
  }

  // Delete a preferred currency
  void _deletePreferredCurrency(
      DeletePreferredCurrency event, Emitter<HomeState> emit) {
    emit(state.copyWith(
        preferredCurrencies: state.preferredCurrencies
            .where((currency) => currency != event.currency)
            .toList()));
  }

  // Update the amount
  void _updateAmount(UpdateAmount event, Emitter<HomeState> emit) {
    emit(state.copyWith(amount: event.amount));
  }
}
