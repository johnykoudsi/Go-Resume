import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:smart_recruitment_core/utility/global_widgets/elevated_button_widget.dart';
import 'package:smart_recruitment_core/utility/global_widgets/somthing_wrong.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/bloc/get_all_jobs/get_all_jobs_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/job/presentation/widgets/job_widget.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/bloc/get_all_compny/get_all_company_bloc.dart';
import 'package:smart_recruitment_flutter_user/features/profile/company_profile/presentation/widget/company_widget.dart';
import 'package:smart_recruitment_flutter_user/generated/assets.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/no_data_widget.dart';
import 'package:smart_recruitment_flutter_user/utility/global_widgets/shimmer.dart';

class CompaniesHorizontalWidget extends StatefulWidget {
  const CompaniesHorizontalWidget({super.key});

  @override
  State<CompaniesHorizontalWidget> createState() => _AllCompaniesScreenState();
}

class _AllCompaniesScreenState extends State<CompaniesHorizontalWidget> {
  GetAllCompanyBloc getAllCompaniesBloc = GetAllCompanyBloc();
  AllCompanySearchFilter companyFilter = AllCompanySearchFilter();

  @override
  void initState() {
    getAllCompaniesBloc.add(ChangeToLoadingAllCompanyEvent());
    super.initState();
  }

  void search() {
    getAllCompaniesBloc.add(
      ChangeToLoadingAllCompanyEvent(
        searchFilter: companyFilter,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllCompaniesBloc,
      child: BlocBuilder<GetAllCompanyBloc, GetAllCompanyState>(
        builder: (context, state) {
          if (state is GetAllCompanyLoadedState &&
              state.companyList.isNotEmpty) {
            return AlignedGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(18),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: 4,
              itemBuilder: (context, index) {
                try {
                  return CompanyWidget(
                    user: state.companyList[index],
                  );
                } catch (e) {
                  return const SizedBox();
                }
              },
            );
          }
          if (state is GetAllCompanyLoadedState) {
            return const NoDataWidget();
          }
          if (state is GetAllCompanyLoadingState) {
            return AlignedGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(18),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: 4,
              itemBuilder: (context, index) {
                return ShimmerLoader(
                  height: 170,
                );
              },
            );
          }
          return SomethingWrongWidget(
            svgPath: Assets.svgNoInternet,
            elevatedButtonWidget: ElevatedButtonWidget(
              title: "Refresh",
              onPressed: () {
                context
                    .read<GetAllJobsBloc>()
                    .add(ChangeToLoadingAllJobsEvent());

                //search(userS);
              },
            ),
          );
        },
      ),
    );
  }
}
