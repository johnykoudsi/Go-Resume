part of 'get_job_applicants_bloc.dart';

sealed class GetJobApplicantsEvent extends Equatable {
  const GetJobApplicantsEvent();
}
class GetJobApplicantsSearchEvent extends GetJobApplicantsEvent {
  GetJobApplicantsSearchEvent({required this.searchFilter});

  JobApplicantsSearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingJobApplicantsEvent extends GetJobApplicantsEvent {
  ChangeToLoadingJobApplicantsEvent({this.searchFilter});

  JobApplicantsSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class JobApplicantsSearchFilter {
  JobApplicantsSearchFilter({this.page = 1});
  int page;

  JobApplicantsSearchFilter copyWith({
    int? page,
  }) =>
      JobApplicantsSearchFilter(
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
