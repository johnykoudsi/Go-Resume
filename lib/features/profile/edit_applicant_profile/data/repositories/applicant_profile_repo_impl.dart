

import 'package:smart_recruitment_core/features/auth/data/data_sources/user_datasource.dart';
import 'package:smart_recruitment_core/features/auth/domain/entities/user_entity.dart';
import 'package:smart_recruitment_core/features/auth/domain/repositories/user_repo.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';

import '../../domain/repositories/applicant_profile_repo.dart';
import '../../presentation/bloc/applicant_profile_bloc.dart';
import '../data_sources/applicant_profile_datasource.dart';

class ApplicantProfileRepoImpl extends ApplicantProfileRepo {
  ApplicantProfileDataSource applicantProfileDataSource;
  ApplicantProfileRepoImpl(this.applicantProfileDataSource);
  @override
  Future edit(UpdateApplicantProfileEvent updateApplicantProfileEvent) async {
    return applicantProfileDataSource.editApplicantProfileDataSource(updateApplicantProfileEvent);
  }
}
