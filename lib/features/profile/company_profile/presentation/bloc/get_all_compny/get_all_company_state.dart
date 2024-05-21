part of 'get_all_company_bloc.dart';

sealed class GetAllCompanyState extends Equatable {
  const GetAllCompanyState();
}

class GetAllCompanyLoadingState extends GetAllCompanyState {
  @override
  List<Object> get props => [];
}

class GetAllCompanyLoadedState extends GetAllCompanyState {
  List<User> companyList;
  bool hasReachedMax;

  GetAllCompanyLoadedState(
      {this.companyList = const <User>[],
        required this.hasReachedMax});

  GetAllCompanyLoadedState copyWith({
    List<User>? companyList,
    bool? hasReachedMax,
  }) {
    return GetAllCompanyLoadedState(
      companyList: companyList ?? this.companyList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [companyList, hasReachedMax];
}


class GetAllCompanyErrorState extends GetAllCompanyState {
  GetAllCompanyErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}