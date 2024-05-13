import 'dart:convert';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/shared_features/job/presentation/bloc/add_job/add_job_bloc.dart';

class JobDataSource {
  JobDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addNewJob(AddNewJobEvent addNewJobEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.addNewJob,
      body: json.encode(addNewJobEvent.toMapBody()),
    );
    return helperResponse;
  }
}
