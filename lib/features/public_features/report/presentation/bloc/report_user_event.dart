part of 'report_user_bloc.dart';

sealed class ReportUserEvent extends Equatable {
  const ReportUserEvent();
}
class ReportUserLoadingEvent extends ReportUserEvent{

  @override
  List<Object?> get props => [];
}

class ReportUserApiEvent extends ReportUserEvent {

  ReportUserApiEvent({
    this.category,
    this.description,
    this.id,
  });
  ReportCategory? category;
  String? description;
  int? id;

  Map<String, String> toMapBody() {

    Map<String, String> map = {
      "reported_id":id.toString()??"",
      "category": category?.name ??"",
      "description": description??"",
    };
    map.removeWhere(
            (key, value) => value == "" || value == null || value == "null");
    return map;
  }
  @override
  List<Object?> get props => [
    category,
    description,
    id,
  ];
}

