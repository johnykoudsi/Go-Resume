part of 'get_favorite_companies_bloc.dart';

abstract class GetFavoriteCompaniesEvent extends Equatable {
  const GetFavoriteCompaniesEvent();
}
class GetFavoriteCompaniesSearchEvent extends GetFavoriteCompaniesEvent {
  GetFavoriteCompaniesSearchEvent({required this.searchFilter});

  FavoriteCompaniesSearchFilter searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class ChangeToLoadingFavoriteCompaniesEvent extends GetFavoriteCompaniesEvent {
  ChangeToLoadingFavoriteCompaniesEvent({this.searchFilter});

  FavoriteCompaniesSearchFilter? searchFilter;

  @override
  List<Object?> get props => [searchFilter];
}

class FavoriteCompaniesSearchFilter {
  FavoriteCompaniesSearchFilter({this.page = 1});
  int page;

  FavoriteCompaniesSearchFilter copyWith({
    int? page,
  }) =>
      FavoriteCompaniesSearchFilter(
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