part of 'my_notifications_bloc.dart';

abstract class MyNotificationsEvent extends Equatable {
  const MyNotificationsEvent();
}
class GetMyNotificationsEvent extends MyNotificationsEvent{
  GetMyNotificationsEvent({required this.searchFilterProperties});

  NotificationsSearchFilter searchFilterProperties;

  @override
  List<Object?> get props => [searchFilterProperties];
}

class ChangeToLoadingApiMyNotificationsEvent extends MyNotificationsEvent {
  ChangeToLoadingApiMyNotificationsEvent(
      { this.searchFilterProperties});

  NotificationsSearchFilter? searchFilterProperties;

  @override
  List<Object?> get props => [searchFilterProperties];
}