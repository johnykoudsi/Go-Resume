part of 'get_all_applicants_bloc.dart';

sealed class GetAllApplicantsEvent extends Equatable {
  const GetAllApplicantsEvent();
}
class GetAllApplicantsSearchEvent extends GetAllApplicantsEvent {
  GetAllApplicantsSearchEvent({required this.searchFilter});

  AllApplicantsSearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingAllApplicantsEvent extends GetAllApplicantsEvent {
  ChangeToLoadingAllApplicantsEvent({this.searchFilter});

  AllApplicantsSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class AllApplicantsSearchFilter {
  AllApplicantsSearchFilter({this.page = 1});
  int page;

  AllApplicantsSearchFilter copyWith({
    int? page,
  }) =>
      AllApplicantsSearchFilter(
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
