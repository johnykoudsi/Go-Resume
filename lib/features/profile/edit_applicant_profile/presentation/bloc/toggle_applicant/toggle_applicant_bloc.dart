
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../data/data_sources/applicant_profile_datasource.dart';
import '../../../data/repositories/applicant_profile_repo_impl.dart';
import '../../../domain/use_cases/get_applicant_status_usecase.dart';
import '../../../domain/use_cases/toggle_applicant_usecase.dart';



part 'toggle_applicant_event.dart';
part 'toggle_applicant_state.dart';

class ToggleApplicantBloc extends Bloc<ToggleApplicantEvent, ToggleApplicantState> {
  ToggleApplicantBloc() : super(ToggleApplicantInitial()) {
    final ApplicantProfileRepoImpl applicantProfileRepoImpl =
    ApplicantProfileRepoImpl(ApplicantProfileDataSource(NetworkHelpers()));
    ToggleApplicantUseCase toggleApplicantUseCase = ToggleApplicantUseCase(applicantProfileRepoImpl);
    GetApplicantStatusUseCase getApplicantStatusUseCase =
    GetApplicantStatusUseCase(applicantProfileRepoImpl);

    on<ToggleApplicantApiEvent>((event, emit) async {
      emit(ToggleApplicantLoadingState());
      dynamic isPinnedResponse;
      isPinnedResponse = await toggleApplicantUseCase.call(event);
      emit(ToggleApplicantLoadedState(isPinned: isPinnedResponse));

    });
    on<GetApplicantStatusEvent>((event, emit) async {
      add(AddView(id: event.id));
      emit(ToggleApplicantLoadingState());
      dynamic isPinnedResponse;
      isPinnedResponse = await getApplicantStatusUseCase.call(event);
      bool isPinned = isPinnedResponse == 0 ? false : true;
      emit(ToggleApplicantLoadedState(isPinned: isPinned));
    });
    on<AddView>((event, emit) async{
      HelperResponse helperResponse = await
      NetworkHelpers.getDeleteDataHelper(
        url: "/applicants/${event.id}",
        useUserToken: true,
      );
      print(helperResponse.response);
    });
  }
}
