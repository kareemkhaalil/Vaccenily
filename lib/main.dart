import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/blocObs.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/firebase_options.dart';
import 'package:dashborad/presentation/screens/homeScreen.dart';
import 'package:dashborad/presentation/screens/login_screen.dart';
import 'package:dashborad/presentation/theams.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit()..init(),
        ),
        BlocProvider<AdminCubit>(
          create: (context) => AdminCubit()..getAllUsers(),
        ),
        BlocProvider<ArticlestCubit>(
          create: (context) => ArticlestCubit()..getAllArticles(),
        ),
        BlocProvider<IconsCubit>(
          create: (context) => IconsCubit()..getIconsData(),
        ),
        BlocProvider<TagsCubit>(
          create: (context) => TagsCubit()..getAllTagsData(),
        ),
      ],
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DashboardCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.darkTheme,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
