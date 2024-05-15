part of 'benefits_bloc.dart';

abstract class BenefitsEvent extends Equatable {
  const BenefitsEvent();
}
class GetBenefitsEvent extends BenefitsEvent{
  @override
  List<Object?> get props => [];
}