import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/repositories/my_submissions_repo.dart';

import '../data_sources/my_submissions_data_source.dart';

class MySubmissionsRepoImpl extends MySubmissionsRepo {
  MySubmissionsRepoImpl(this.mySubmissionsDataSource);
  MySubmissionsDataSource mySubmissionsDataSource;

  @override
  Future getMySubmissionsRequestRepo(event) async{
    return await mySubmissionsDataSource.getMySubmissionsDataSource(event: event);
  }

}
