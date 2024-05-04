import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/applicant_features/my_submissions/domain/entities/job_entity.dart';

part 'my_submissions_event.dart';
part 'my_submissions_state.dart';

class MySubmissionsBloc extends Bloc<MySubmissionsEvent, MySubmissionsState> {
  MySubmissionsBloc() : super(MySubmissionsInitial()) {
    on<MySubmissionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
