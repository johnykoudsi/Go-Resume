
import 'package:smart_recruitment_flutter_user/features/public_features/ads/presentation/bloc/get_ads_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/report/presentation/bloc/report_user_bloc.dart';

abstract class ReportUserRepo {

  Future reportUser(ReportUserApiEvent event);

}