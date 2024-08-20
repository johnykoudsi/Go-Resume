part of 'get_job_applicants_bloc.dart';

sealed class GetJobApplicantsEvent extends Equatable {
  const GetJobApplicantsEvent();
}
class GetJobApplicantsSearchEvent extends GetJobApplicantsEvent {
  GetJobApplicantsSearchEvent({required this.searchFilter,required this.jobId});
  int jobId;
  JobApplicantsSearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingJobApplicantsEvent extends GetJobApplicantsEvent {
  ChangeToLoadingJobApplicantsEvent({this.searchFilter,required this.jobId});
  int jobId;
  JobApplicantsSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter,jobId];
}

class JobApplicantsSearchFilter {
  JobApplicantsSearchFilter({
    this.page = 1,
    this.maxSalary,
    this.minSalary,
    this.search,
    this.sort,
    this.type,
    this.workFieldId,
    this.companyId
  });
  int page;
  String? search;
  num? minSalary;
  num? maxSalary;
  int? workFieldId;
  // in:contract,full_time,part_time,task_based,out_sourcing
  JobTypes? type;
  JobSorts? sort;
  int? companyId;

  JobApplicantsSearchFilter copyWith({
    int? page,
    String? search,
    num? minSalary,
    num? maxSalary,
    int? workFieldId,
    // in:contract,full_time,part_time,task_based,out_sourcing
    JobTypes? type,
    JobSorts? sort,
    int? companyId,
  }) =>
      JobApplicantsSearchFilter(
          page: page ?? this.page,
          search: search ?? this.search,
          minSalary: minSalary ?? this.minSalary,
          maxSalary: maxSalary ?? this.maxSalary,
          workFieldId: workFieldId ?? this.workFieldId,
          type: type ?? this.type,
          sort: sort ?? this.sort,
          companyId: companyId ?? this.companyId
      );

  Map<String, String?> toJson() {
    Map<String, String?> map = {
      "page": page.toString(),
      "per_page": kGetLimit.toString(),
      "filter[search]": search,
      "filter[minSalary]": minSalary.toString(),
      "filter[maxSalary]": maxSalary.toString(),
      "filter[work_field_id]": workFieldId.toString(),
      "filter[type]": type != JobTypes.none ? type?.name : null,
      "sort":  sort != JobSorts.none ? sort?.name : null,
      "filter[company_id]":  companyId.toString(),
    }..removeWhere(
            (key, value) => value == null || value == "null" || value == "");
    ;
    return map;
  }
}
