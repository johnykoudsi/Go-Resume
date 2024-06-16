import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_recruitment_core/features/auth/presentation/bloc/user/user_bloc.dart';


final GlobalKey<NavigatorState> globalNavigatorKey =
GlobalKey<NavigatorState>();

UserBloc globalUserBloc = UserBloc();

const int kGetLimit = 10;
const int kTagGetLimit = 20;

const double mapRadius = 200;

bool isEnglish(BuildContext context) {
  if (context.locale.languageCode == "ar") {
    return false;
  }
  return true;
}

bool userIsLoggedIn(BuildContext context) {
  final state = context.read<UserBloc>().state;
  if (state is UserLoggedState) {
    return true;
  }
  return false;
}



bool getStatuesFromResponse(String streamRes) {
  Map<String, dynamic> jsonError = json.decode(streamRes);
  if (jsonError.containsKey("success")) {
    return jsonError["success"];
  }
  return false;
}
