part of 'get_all_company_bloc.dart';

sealed class GetAllCompanyEvent extends Equatable {
  const GetAllCompanyEvent();
}

class GetAllCompanySearchEvent extends GetAllCompanyEvent {
  GetAllCompanySearchEvent({required this.searchFilter});

  AllCompanySearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingAllCompanyEvent extends GetAllCompanyEvent {
  ChangeToLoadingAllCompanyEvent({this.searchFilter});

  AllCompanySearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class AllCompanySearchFilter {
  AllCompanySearchFilter({this.page = 1});
  int page;

  AllCompanySearchFilter copyWith({
    int? page,
  }) =>
      AllCompanySearchFilter(
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
