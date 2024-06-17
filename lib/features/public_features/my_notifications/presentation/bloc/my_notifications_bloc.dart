import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';

import '../../../../../utility/constant_logic_validation.dart';
import '../../data/data_sources/my_notifications_data_source.dart';
import '../../data/repositories/my_notifications_repo_impl.dart';
import '../../domain/entities/my_notifications_entity.dart';
import '../../domain/use_cases/get_my_notifications_usecase.dart';

part 'my_notifications_event.dart';
part 'my_notifications_state.dart';

class MyNotificationsBloc extends Bloc<MyNotificationsEvent, MyNotificationsState> {
  static final MyNotificationsRepoImpl myNotificationsRepoImpl = MyNotificationsRepoImpl(MyNotificationsDataSource(NetworkHelpers()));

  MyNotificationsBloc() : super(MyNotificationsInitial()) {

    on<GetMyNotificationsEvent>((event, emit) async {
      final currentState = state;
      if (currentState is MyNotificationsLoadedState && currentState.hasReachedMax) {
        return;
      }

      int getPage() {
        if (currentState is MyNotificationsLoadedState) {
          return currentState.notifications.length ~/ kGetLimit + 1;
        }
        return 0;
      }

      var getMyNotifications;

      event.searchFilterProperties.page = getPage();
      GetMyNotificationsUseCase myNotificationsUseCase = GetMyNotificationsUseCase(myNotificationsRepoImpl);

      getMyNotifications = await myNotificationsUseCase.call(event);

      if (getMyNotifications is List<NotificationModel>) {
        if (getMyNotifications.isNotEmpty) {
          // copy previous state
          if (currentState is MyNotificationsLoadedState) {
            emit(currentState.copyWith(
                notifications: List.of(currentState.notifications)..addAll(getMyNotifications),
                hasReachedMax:
                getMyNotifications.length < kGetLimit ? true : false));
          }

          // add loaded state
          else {
            emit(MyNotificationsLoadedState(
              notifications: getMyNotifications,
              hasReachedMax:
              getMyNotifications.length < kGetLimit ? true : false,
            ));
          }
        } else {
          // done loading
          if (currentState is MyNotificationsLoadedState) {
            emit(currentState.copyWith(hasReachedMax: true));
          }
          // done but nothing is there
          else {
            emit(MyNotificationsLoadedState(
              notifications: getMyNotifications,
              hasReachedMax: true,
            ));
          }
        }
      }
      else {
        print("Server ${(getMyNotifications as HelperResponse).response}");

        emit(MyNotificationsErrorState(helperResponse: getMyNotifications));
      }
    });

    on<ChangeToLoadingApiMyNotificationsEvent>((event, emit) async {
      emit(MyNotificationsInitial());

      add(GetMyNotificationsEvent(
          searchFilterProperties: NotificationsSearchFilter(page: 1)));
    });
  }
}