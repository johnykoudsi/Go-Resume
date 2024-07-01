import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/data_source/job_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/job/data_sources/reposetries/job_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/entities/salary_expectation_entity.dart';
import 'package:smart_recruitment_flutter_user/features/job/domain/use_cases/generate_salary_usecase.dart';

part 'salary_expectation_event.dart';
part 'salary_expectation_state.dart';

class SalaryExpectationBloc
    extends Bloc<SalaryExpectationEvent, SalaryExpectationState> {
  static final JobRepoImpl jobRepoImpl =
      JobRepoImpl(JobDataSource(NetworkHelpers()));
  GetSalaryExpectationUseCase getSalaryExpectationUseCase =
      GetSalaryExpectationUseCase(jobRepoImpl);
  SalaryExpectationBloc() : super(GetSalaryInitialState()) {
    on<GetSalaryEvent>((event, emit) async {
      emit(GetSalaryLoadingState());
      final response = await getSalaryExpectationUseCase.call(event);
      Future.delayed(const Duration(seconds: 6));
      if (response is SalaryExpectationEntity) {
        emit(GetSalaryDoneState(salaryExpectationEntity: response));
      } else {
        emit(GetSalaryErrorState(helperResponse: response));
      }
    });
  }
}
