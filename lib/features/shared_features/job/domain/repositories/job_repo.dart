import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';

abstract class JobRepo {
  Future addJob(AddNewJobEvent addNewJobEvent);
}
