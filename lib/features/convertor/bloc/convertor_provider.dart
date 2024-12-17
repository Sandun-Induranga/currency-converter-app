import 'package:flutter_bloc/flutter_bloc.dart';

import 'convertor_bloc.dart';

class ConvertorProvider extends BlocProvider<ConvertorBloc> {
  ConvertorProvider({
    super.key,
  }) : super(
    create: (context) => ConvertorBloc(),
  );
}
