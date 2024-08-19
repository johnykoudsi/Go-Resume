
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/data/data_sources/company_profile_datasource.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/company_profile_bloc/company_profile_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_cities/get_all_cities_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_countries/get_all_countries_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_favorite_companies/get_favorite_companies_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/policies_actions_bloc/policies_actions_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/toggle_company/toggle_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/report/data/data_sources/report_user_data_source.dart';
import 'package:smart_recruitment_flutter_user/features/public_features/report/domain/repositories/report_user_repo.dart';

import '../../presentation/bloc/report_user_bloc.dart';


class ReportUserRepoImpl extends ReportUserRepo {
  ReportUserRepoImpl(this.reportUserDataSource);

  ReportUserDataSource reportUserDataSource;


  @override
  Future reportUser(ReportUserApiEvent reportUserEvent) async{
    return await reportUserDataSource.reportUser(reportUserEvent);
  }


}