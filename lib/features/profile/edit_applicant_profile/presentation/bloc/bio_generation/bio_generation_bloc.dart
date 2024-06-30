import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/data/data_sources/applicant_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/data/repositories/applicant_profile_repo_impl.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/domain/repositories/applicant_profile_repo.dart';
import 'package:smart_recruitment_flutter_user/features/profile/edit_applicant_profile/domain/use_cases/bio_generation_usecase.dart';

part 'bio_generation_event.dart';
part 'bio_generation_state.dart';

class BioGenerationBloc extends Bloc<BioGenerationEvent, BioGenerationState> {
  static final ApplicantProfileRepoImpl applicantProfileRepoImpl =
      ApplicantProfileRepoImpl(ApplicantProfileDataSource(NetworkHelpers()));

  BioGenerationBloc() : super(BioGenerationInitialState()) {
    BioGenerationUsecase bioGenerationUsecase =
        BioGenerationUsecase(applicantProfileRepoImpl);

    on<PostBioGenerationEvent>((event, emit) async {
      emit(BioGenerationLoadingState());

      final response = await bioGenerationUsecase.call(event);

      if (response is String) {
        emit(BioGenerationDoneState(generation: response));
      } else {
        emit(BioGenerationErrorState(response: response));
      }
    });
  }
}
