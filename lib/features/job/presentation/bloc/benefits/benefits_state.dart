part of 'benefits_bloc.dart';

abstract class BenefitsState extends Equatable {
  const BenefitsState();
}

class BenefitsInitial extends BenefitsState {
  @override
  List<Object> get props => [];
}
class BenefitsDoneState extends BenefitsState {
  BenefitsDoneState({required this.benefits});

  List<BenefitEntity> benefits;
  @override
  List<Object> get props => [benefits];
}

class BenefitsErrorState extends BenefitsState {
  BenefitsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}