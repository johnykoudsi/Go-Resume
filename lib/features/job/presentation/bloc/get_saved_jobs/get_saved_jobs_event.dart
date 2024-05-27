part of 'get_saved_jobs_bloc.dart';

sealed class GetSavedJobsEvent extends Equatable {
  const GetSavedJobsEvent();
}

class GetSavedJobsSearchEvent extends GetSavedJobsEvent {
  GetSavedJobsSearchEvent({required this.searchFilter});

  SavedJobsSearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingSavedJobsEvent extends GetSavedJobsEvent {
  ChangeToLoadingSavedJobsEvent({this.searchFilter});

  SavedJobsSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class SavedJobsSearchFilter {
  SavedJobsSearchFilter({this.page = 1});
  int page;

  SavedJobsSearchFilter copyWith({
    int? page,
  }) =>
      SavedJobsSearchFilter(
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
