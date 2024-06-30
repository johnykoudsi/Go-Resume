import 'dart:convert';

import 'package:smart_recruitment_core/utility/enums.dart';
import 'package:smart_recruitment_core/utility/networking/endpoints.dart';
import 'package:smart_recruitment_core/utility/networking/network_helper.dart';
import 'package:smart_recruitment_flutter_user/features/profile/my_education_and_certificates/presentation/bloc/experience_generation/education_generation_bloc.dart';

import '../../presentation/bloc/education_actions_bloc.dart';

class EducationActionsDataSource {
  EducationActionsDataSource(this.networkHelpers);
  final NetworkHelpers networkHelpers;

  Future addEducationDataSource(AddEducationEvent addEducationEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      useUserToken: true,
      url: EndPoints.addEducation,
      body: json.encode(addEducationEvent.toJson()),
    );
    return helperResponse;
  }

  Future deleteEducationDataSource(
      DeleteEducationEvent deleteEducationEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.getDeleteDataHelper(
      crud: "DELETE",
      useUserToken: true,
      url: EndPoints.deleteEducation(id: deleteEducationEvent.id),
    );
    return helperResponse;
  }

  Future generateEducationDataSource(
      PostEducationGenerationEvent postEducationGenerationEvent) async {
    HelperResponse helperResponse = await NetworkHelpers.postDataHelper(
      mainUrl: EndPoints.aiMainUrl,
      url: EndPoints.generateEducation,
      body: json.encode(postEducationGenerationEvent.toJson()),
    );
    try {
      // Map responseDummy = {
      //   "education":
      //       "*Bachelor of Information Technology Engineering\n\nDamascus University, Damascus, Syria 2024\n\n Strong foundation in computer science fundamentals, including programming languages, data structures, algorithms, and software development principles.\n* Excellent problem-solving and critical thinking skills to tackle complex software engineering challenges.\n* Strong collaboration and communication abilities, with a proven track record of working effectively in cross-functional teams.\n* Ability to effectively utilize various tools and technologies, including Agile software development methodologies, Git version control, and database management systems.\n* Familiarity with Java, Flutter, Node.js, SQL, MongoDB, and Three.js frameworks, along with basic knowledge of Python and Flask.\n* Fast learner with a strong desire to acquire new skills and stay updated with the latest technological advancements."
      // };
      return json.decode(helperResponse.response)["education"];
    } catch (e) {
      return helperResponse.copyWith(
          servicesResponse: ServicesResponseStatues.modelError);
    }
  }
}
