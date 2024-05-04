import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:online_course/core/services/injection_container.dart';
import 'package:online_course/firebase_options.dart';
import 'package:online_course/src/features/course/pesentation/bloc/explore/course_bloc.dart';
import 'package:online_course/src/features/course/pesentation/bloc/favorite_course/favorite_course_bloc.dart';
import 'package:online_course/src/features/course/pesentation/bloc/feature/feature_course_bloc.dart';
import 'package:online_course/src/features/course/pesentation/bloc/recommend/recommend_course_bloc.dart';
import 'package:online_course/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:online_course/src/theme/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
MediaKit.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator.get<CourseBloc>()),
        BlocProvider(create: (_) => locator.get<FeatureCourseBloc>()),
        BlocProvider(create: (_) => locator.get<RecommendCourseBloc>()),
        BlocProvider(create: (_) => locator.get<FavoriteCourseBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Course App',
        theme: ThemeData(
          primaryColor: AppColor.primary,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary)
        ),
        home: const  OnboardingScreen(),
      ),
    );
  }
}
