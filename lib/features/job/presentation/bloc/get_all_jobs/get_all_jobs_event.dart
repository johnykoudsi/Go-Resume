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
  AllJobsSearchFilter({this.page = 1});
  int page;

  AllJobsSearchFilter copyWith({
    int? page,
  }) =>
      AllJobsSearchFilter(
        page: page ?? this.page,
      );

  Map<String, String> toJson() {
    Map<String, String> map = {
      "page": page.toString(),
      "per_page": kGetLimit.toString(),
    }..removeWhere((key, value) => value.isEmpty);
    return map;
  }
}
