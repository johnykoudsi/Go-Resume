part of 'get_favorite_companies_bloc.dart';

abstract class GetFavoriteCompaniesState extends Equatable {
  const GetFavoriteCompaniesState();
}

class GetFavoriteCompaniesLoadingState extends GetFavoriteCompaniesState {
  @override
  List<Object> get props => [];
}

class GetFavoriteCompaniesLoadedState extends GetFavoriteCompaniesState {
  List<User> companyList;
  bool hasReachedMax;

  GetFavoriteCompaniesLoadedState(
      {this.companyList = const <User>[],
        required this.hasReachedMax});

  GetFavoriteCompaniesLoadedState copyWith({
    List<User>? companyList,
    bool? hasReachedMax,
  }) {
    return GetFavoriteCompaniesLoadedState(
      companyList: companyList ?? this.companyList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [companyList, hasReachedMax];
}


class GetFavoriteCompaniesErrorState extends GetFavoriteCompaniesState {
  GetFavoriteCompaniesErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}