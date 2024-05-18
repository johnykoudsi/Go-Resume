



import '../../domain/reposotories/education_actions_repo.dart';
import '../../presentation/bloc/education_actions_bloc.dart';
import '../data_sources/education_actions_datasource.dart';

class EducationActionsRepoImpl extends EducationActionsRepo {
  EducationActionsRepoImpl(this.educationActionsDataSource);

  EducationActionsDataSource educationActionsDataSource;

  @override
  Future addNewEducation(AddEducationEvent addEducationEvent) async {
    return await educationActionsDataSource.addEducationDataSource(addEducationEvent);
  }

  @override
  Future deleteEducation(DeleteEducationEvent deleteEducationEvent) async{
    return await educationActionsDataSource.deleteEducationDataSource(deleteEducationEvent);
  }


}