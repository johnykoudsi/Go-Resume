import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/apply_for_job/apply_for_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/benefits/benefits_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_saved_jobs/get_saved_jobs_bloc.dart';
import '../../presentation/bloc/work_fields/work_fields_bloc.dart';

abstract class JobRepo {
  Future addJob(AddNewJobEvent addNewJobEvent);
  Future getBenefits(GetBenefitsEvent getBenefitsEvent);
  Future getWorkFields(GetWorkFieldsEvent getWorkFieldsEvent);
  Future getAllJobs(GetAllJobsSearchEvent getAllJobsSearchEvent);
  Future getSavedJobs(GetSavedJobsSearchEvent getSavedJobsSearchEvent);
  Future applyForJob(ApplyForJobApiEvent applyForJobApiEvent);
}
