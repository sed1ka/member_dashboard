import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

/// Handler when the Bloc/Cubit is closed but still emitting state.
/// Issue Ref:
/// https://github.com/felangel/bloc/issues/4165
abstract class SafeCubit<State> extends Cubit<State> {
  SafeCubit(super.initialState);

  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    } else {
      //❗️Log untuk debugging (tidak crash, tapi tetap deteksi)
      log(
        '⚠️ emit(${state.runtimeType}) called after close on $runtimeType',
        name: 'SafeCubit',
      );
      assert(() {
        throw Exception('emit() called after close on $runtimeType');
      }());
    }
  }
}
