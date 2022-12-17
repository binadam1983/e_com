import 'package:e_com/screens/screens.dart';
import 'package:flutter/material.dart';

import '../logic/auth/auth_cubit.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
