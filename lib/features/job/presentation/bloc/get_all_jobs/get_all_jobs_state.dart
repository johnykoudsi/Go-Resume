part of 'get_all_jobs_bloc.dart';

sealed class GetAllJobsState extends Equatable {
  const GetAllJobsState();
}

class GetAllJobsLoadingState extends GetAllJobsState {
  @override
  List<Object> get props => [];
}

class GetAllJobsLoadedState extends GetAllJobsState {
  List<JobEntity> jobList;
  bool hasReachedMax;

  GetAllJobsLoadedState(
      {this.jobList = const <JobEntity>[],
        required this.hasReachedMax});

  GetAllJobsLoadedState copyWith({
    List<JobEntity>? jobList,
    bool? hasReachedMax,
  }) {
    return GetAllJobsLoadedState(
      jobList: jobList ?? this.jobList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [jobList, hasReachedMax];
}


class GetAllJobsErrorState extends GetAllJobsState {
  GetAllJobsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}