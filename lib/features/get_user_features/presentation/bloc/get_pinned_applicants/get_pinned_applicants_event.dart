part of 'get_pinned_applicants_bloc.dart';

sealed class GetPinnedApplicantsEvent extends Equatable {
  const GetPinnedApplicantsEvent();
}
class GetPinnedApplicantsSearchEvent extends GetPinnedApplicantsEvent {
  GetPinnedApplicantsSearchEvent({required this.searchFilter});

  PinnedApplicantsSearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingPinnedApplicantsEvent extends GetPinnedApplicantsEvent {
  ChangeToLoadingPinnedApplicantsEvent({this.searchFilter});

  PinnedApplicantsSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class PinnedApplicantsSearchFilter {
  PinnedApplicantsSearchFilter({this.page = 1});
  int page;

  PinnedApplicantsSearchFilter copyWith({
    int? page,
  }) =>
      PinnedApplicantsSearchFilter(
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
