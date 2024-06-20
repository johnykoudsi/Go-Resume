part of 'get_all_jobs_bloc.dart';

sealed class GetAllJobsEvent extends Equatable {
  const GetAllJobsEvent();
}

class GetAllJobsSearchEvent extends GetAllJobsEvent {
  GetAllJobsSearchEvent({required this.searchFilter});

  AllJobsSearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingAllJobsEvent extends GetAllJobsEvent {
  ChangeToLoadingAllJobsEvent({this.searchFilter});

  AllJobsSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class AllJobsSearchFilter {
  AllJobsSearchFilter({
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

  AllJobsSearchFilter copyWith({
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
      AllJobsSearchFilter(
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
