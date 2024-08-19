import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../data/data_sources/report_user_data_source.dart';
import '../../data/repositories/report_user_repo_impl.dart';
import '../../domain/use_cases/report_user_usecase.dart';

part 'report_user_event.dart';
part 'report_user_state.dart';

class ReportUserBloc extends Bloc<ReportUserEvent, ReportUserState> {
  ReportUserBloc() : super(ReportUserInitial()) {
    final ReportUserRepoImpl reportUserRepoImpl = ReportUserRepoImpl(ReportUserDataSource(NetworkHelpers()));
ReportUserUseCase reportUserUseCase = ReportUserUseCase(reportUserRepoImpl);
    on<ReportUserApiEvent>((event, emit) async {
      emit(ReportUserLoadingState());

      final response = await reportUserUseCase.call(event);

      emit(ReportUserDoneState());

    });
  }

}
