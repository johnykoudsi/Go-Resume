import '../../presentation/bloc/my_notifications_bloc.dart';

abstract class MyNotificationsRepo {

  Future getMyNotificationsRequestRepo(GetMyNotificationsEvent event);

}