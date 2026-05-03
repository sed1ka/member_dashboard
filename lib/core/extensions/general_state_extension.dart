import 'package:hdi_mini_test/core/bloc/general_state.dart';

extension GeneralStateListX<T> on GeneralState<List<T>> {
  bool get hasData {
    return this is Success<List<T>> &&
        (this as Success<List<T>>).data.isNotEmpty;
  }
}