part of 'my_notifications_bloc.dart';

abstract class MyNotificationsState extends Equatable {
  const MyNotificationsState();
}

class MyNotificationsLoadingState extends MyNotificationsState {
  @override
  List<Object> get props => [];
}
class MyNotificationsLoadedState extends MyNotificationsState {
  List<NotificationsModel> notifications;
  bool hasReachedMax;

  MyNotificationsLoadedState(
      {this.notifications = const <NotificationsModel>[],
        required this.hasReachedMax});

  MyNotificationsLoadedState copyWith({
    List<NotificationsModel>? notifications,
    bool? hasReachedMax,
  }) {
    return MyNotificationsLoadedState(
      notifications: notifications ?? this.notifications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [notifications, hasReachedMax];
}


class MyNotificationsErrorState extends MyNotificationsState {
  MyNotificationsErrorState({required this.helperResponse});
  HelperResponse helperResponse;

  @override
  List<Object> get props =>
      [helperResponse.servicesResponse, helperResponse.response];
}