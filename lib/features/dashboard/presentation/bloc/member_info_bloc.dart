import 'package:hdi_mini_test/core/bloc/general_state.dart';
import 'package:hdi_mini_test/core/bloc/safe_bloc.dart';
import 'package:hdi_mini_test/core/usecase/usecase.dart';
import 'package:hdi_mini_test/features/dashboard/domain/entities/member_entity.dart';
import 'package:hdi_mini_test/features/dashboard/domain/usecases/get_member_info_use_case.dart';
import 'package:hdi_mini_test/features/dashboard/presentation/bloc/member_info_event.dart';

class MemberInfoBloc
    extends SafeBloc<MemberInfoEvent, GeneralState<MemberEntity>> {
  final GetMemberInfoUseCase _getMemberInfoUseCase;

  MemberInfoBloc({
    required GetMemberInfoUseCase getMemberInfoUseCase,
  }) : _getMemberInfoUseCase = getMemberInfoUseCase,
       super(const Initial()) {
    on<GetMemberInfo>(_onGetMemberStarted);
  }

  Future<void> _onGetMemberStarted(
    GetMemberInfo event,
    Emitter<GeneralState<MemberEntity>> emit,
  ) async {
    if (state is Loading) return;
    emit(const Loading());
    final result = await _getMemberInfoUseCase(params: const NoParams());
    result.fold(
      (failure) => emit(Error(failure)),
      (member) => emit(Success(member)),
    );
  }
}
