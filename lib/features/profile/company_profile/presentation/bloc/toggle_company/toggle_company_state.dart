part of 'toggle_company_bloc.dart';

abstract class ToggleCompanyState extends Equatable {
  const ToggleCompanyState();
}

class ToggleCompanyInitial extends ToggleCompanyState {
  @override
  List<Object> get props => [];
}
class ToggleCompanyLoadingState extends ToggleCompanyState {
  @override
  List<Object> get props => [];
}
class ToggleCompanyLoadedState extends ToggleCompanyState {
  bool isFavorite;

  ToggleCompanyLoadedState(
      {
        required this.isFavorite});

  ToggleCompanyLoadedState copyWith({
    bool? isFavorite,
  }) {
    return ToggleCompanyLoadedState(
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [isFavorite];
}
class ToggleCompanyErrorState extends ToggleCompanyState {
  ToggleCompanyErrorState({required this.helperResponse});

  HelperResponse helperResponse;
  @override
  List<Object> get props => [helperResponse];
}