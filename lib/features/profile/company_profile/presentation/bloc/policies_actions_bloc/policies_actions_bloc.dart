import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../data/data_sources/company_profile_datasource.dart';
import '../../../data/repositories/company_profile_repo_impl.dart';
import '../../../domain/use_cases/add_policy_usecase.dart';
import '../../../domain/use_cases/delete_policy_usecase.dart';

part 'policies_actions_event.dart';
part 'policies_actions_state.dart';

class PoliciesActionsBloc extends Bloc<PoliciesActionsEvent, PoliciesActionsState> {
  PoliciesActionsBloc() : super(PoliciesActionsInitial()) {
    final CompanyProfileRepoImpl policiesActionsRepoImpl =
    CompanyProfileRepoImpl(
        CompanyProfileDataSource(NetworkHelpers()));

    on<AddPolicyEvent>((event, emit) async {
      emit(PoliciesActionsLoadingState());

      AddPolicyUsecase useCase =
      AddPolicyUsecase(policiesActionsRepoImpl);

      final response = await useCase.call(event);

      emit(PoliciesActionsResponseState(helperResponse: response));
    });
    on<DeletePolicyEvent>((event, emit) async {
      emit(PoliciesActionsLoadingState());

      DeletePolicyUsecase useCase = DeletePolicyUsecase(policiesActionsRepoImpl);

      final response = await useCase.call(event);

      emit(PoliciesActionsResponseState(helperResponse: response));

    });
  }
}
