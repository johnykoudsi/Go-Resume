import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/core/enums.dart';

part 'add_job_event.dart';
part 'add_job_state.dart';

class AddJobBloc extends Bloc<AddJobEvent, AddJobState> {
  AddJobBloc() : super(AddJobInitialState()) {
    on<AddJobEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
