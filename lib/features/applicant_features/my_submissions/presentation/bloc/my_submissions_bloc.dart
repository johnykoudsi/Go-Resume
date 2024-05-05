import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/data/data_sources/my_submissions_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/data/repositories/my_submissions_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/entities/job_entity.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/use_cases/get_my_submissions_usecase.dart';

import '../../../../../utility/constant_logic_validation.dart';

part 'my_submissions_event.dart';
part 'my_submissions_state.dart';

class MySubmissionsBloc extends Bloc<MySubmissionsEvent, MySubmissionsState> {
  static final MySubmissionsRepoImpl mySubmissionsRepoImpl = MySubmissionsRepoImpl(MySubmissionsDataSource(NetworkHelpers()));

  MySubmissionsBloc() : super(MySubmissionsInitial()) {

    on<GetMySubmissionsEvent>((event, emit) async {
      final currentState = state;
      if (currentState is MySubmissionsLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is MySubmissionsLoadedState) {
          return currentState.jobs.length ~/ kProductsGetLimit + 1;
        }
        return 0;
      }

      var getMySubmissions;

      event.searchFilterProperties.page = getPage();
      GetMySubmissionsUseCase mySubmissionsUseCase = GetMySubmissionsUseCase(mySubmissionsRepoImpl);

      getMySubmissions = await mySubmissionsUseCase.call(event);

      if (getMySubmissions is List<Job>) {
        if (getMySubmissions.isNotEmpty) {
          // copy previous state
          if (currentState is MySubmissionsLoadedState) {
            emit(currentState.copyWith(
                jobs: List.of(currentState.jobs)..addAll(getMySubmissions),
                hasReachedMax:
                getMySubmissions.length < kProductsGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(MySubmissionsLoadedState(
              jobs: getMySubmissions,
              hasReachedMax:
              getMySubmissions.length < kProductsGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is MySubmissionsLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(MySubmissionsLoadedState(
              jobs: getMySubmissions,
              hasReachedMax: true,
            ));
          }
        }
      } else {
        print("Server ${(getMySubmissions as HelperResponse).response}");

        emit(MySubmissionsErrorState(helperResponse: getMySubmissions));
      }
    });

    on<ChangeToLoadingApiMySubmissionsEvent>((event, emit) async {
      emit(MySubmissionsInitial());

      add(GetMySubmissionsEvent(
          searchFilterProperties: JobSearchFilter(page: 1)));
    });
  }
}
