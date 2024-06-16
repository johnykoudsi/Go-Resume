import '../../domain/repositories/my_notifications_repo.dart';
import '../data_sources/my_notifications_data_source.dart';

class MyNotificationsRepoImpl extends MyNotificationsRepo {
  MyNotificationsRepoImpl(this.myNotificationsDataSource);
  MyNotificationsDataSource myNotificationsDataSource;

  @override
  Future getMyNotificationsRequestRepo(event) async{
    return await myNotificationsDataSource.getMyNotificationsDataSource(event: event);
  }

}