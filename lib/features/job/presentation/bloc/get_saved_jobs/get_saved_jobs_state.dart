part of 'get_saved_jobs_bloc.dart';

sealed class GetSavedJobsState extends Equatable {
  const GetSavedJobsState();
}

class GetSavedJobsLoadingState extends GetSavedJobsState {
  @override
  List<Object> get props => [];
}

class GetSavedJobsLoadedState extends GetSavedJobsState {
  List<JobEntity> jobList;
  bool hasReachedMax;

  GetSavedJobsLoadedState(
      {this.jobList = const <JobEntity>[],
        required this.hasReachedMax});

  GetSavedJobsLoadedState copyWith({
    List<JobEntity>? jobList,
    bool? hasReachedMax,
  }) {
    return GetSavedJobsLoadedState(
      jobList: jobList ?? this.jobList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [jobList, hasReachedMax];
}


class GetSavedJobsErrorState extends GetSavedJobsState {
  GetSavedJobsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}