import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/benefits/benefits_bloc.dart';
import '../../presentation/bloc/work_fields/work_fields_bloc.dart';

abstract class JobRepo {
  Future addJob(AddNewJobEvent addNewJobEvent);
  Future getBenefits(GetBenefitsEvent getBenefitsEvent);
  Future getWorkFields(GetWorkFieldsEvent getWorkFieldsEvent);
}
