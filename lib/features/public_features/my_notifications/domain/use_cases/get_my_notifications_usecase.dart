




import '../../presentation/bloc/my_notifications_bloc.dart';
import '../repositories/my_notifications_repo.dart';

class GetMyNotificationsUseCase {
  final MyNotificationsRepo myNotificationsRepo;

  GetMyNotificationsUseCase(this.myNotificationsRepo);

  Future call(GetMyNotificationsEvent event) async {
    return await myNotificationsRepo.getMyNotificationsRequestRepo(event);
  }
}
