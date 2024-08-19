

import 'package:smart_recruitment_flutter_user/features/public_features/report/domain/repositories/report_user_repo.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/report/presentation/bloc/report_user_bloc.dart';

class ReportUserUseCase {
  final ReportUserRepo reportUserRepo;

  ReportUserUseCase(this.reportUserRepo);

  Future call(ReportUserApiEvent reportUserApiEvent) async {
    return await reportUserRepo.reportUser(reportUserApiEvent);
  }
}
