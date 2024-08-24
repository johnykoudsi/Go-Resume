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
class GetJobApplicantsTopSearchEvent extends GetJobApplicantsEvent {
  GetJobApplicantsTopSearchEvent({required this.searchFilter,required this.jobId});
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
class ChangeToLoadingJobTopApplicantsEvent extends GetJobApplicantsEvent {
  ChangeToLoadingJobTopApplicantsEvent({this.searchFilter,required this.jobId});
  int jobId;
  JobApplicantsSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter,jobId];
}

class JobApplicantsSearchFilter {
  JobApplicantsSearchFilter({
    this.page = 1,
    this.search,
    this.sort,
    this.workFieldId,
  });
  int page;
  String? search;
  int? workFieldId;
  // in:contract,full_time,part_time,task_based,out_sourcing
  JobSorts? sort;

  JobApplicantsSearchFilter copyWith({
    int? page,
    String? search,
    num? minSalary,
    num? maxSalary,
    int? workFieldId,
    // in:contract,full_time,part_time,task_based,out_sourcing
    JobSorts? sort,
  }) =>
      JobApplicantsSearchFilter(
          page: page ?? this.page,
          search: search ?? this.search,
          workFieldId: workFieldId ?? this.workFieldId,
          sort: sort ?? this.sort,
      );

  Map<String, String?> toJson() {
    Map<String, String?> map = {
      "page": page.toString(),
      "per_page": kGetLimit.toString(),
      "filter[search]": search,
      "filter[work_field_id]": workFieldId.toString(),
      "sort":  sort != JobSorts.none ? sort?.name : null,
    }..removeWhere(
            (key, value) => value == null || value == "null" || value == "");
    ;
    return map;
  }
}
