import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/di/dpendency_injection.dart';
import 'package:flutter_ecommerce_app/core/utils/startup_methods.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/my_bloc_observer.dart';
import 'app.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  // ensure all method in main is finished then run app
  WidgetsFlutterBinding.ensureInitialized();
  // To show Bloc States and changes in debug console terminal
  Bloc.observer = MyBlocObserver();
  // To fix texts hidden bug in flutter ScreenUtil in release mode.
  await ScreenUtil.ensureScreenSize();
  // Setup Dependency Injection
  await ServiceLocator.setUpGetIt();
  // Check if user open app for first time to display OnBoard Screen
  await showOnBoarding();
  // Check if user loggedIn or not to navigate to home Or login screen
  await isUserLoggedIn();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) {
        return const App();
      },
    ),
  );
}
