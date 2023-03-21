import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/blocObs.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:dashborad/firebase_options.dart';
import 'package:dashborad/presentation/screens/homeScreen.dart';
import 'package:dashborad/presentation/screens/login_screen.dart';
import 'package:dashborad/presentation/theams.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  final repository = Repository();

  runApp(MyApp(
    adminCubit: AdminCubit(repository),
  ));
}

class MyApp extends StatelessWidget {
  final AdminCubit adminCubit;

  MyApp({super.key, required this.adminCubit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final repository = Repository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AdminCubit>(
          create: (context) => AdminCubit(repository)..getAllUsers(),
        ),
        BlocProvider<ArticlesCubit>(
          create: (context) => ArticlesCubit(repository)..getAllArticles(),
        ),
        BlocProvider<IconsCubit>(
          create: (context) => IconsCubit()..getIconsData(),
        ),
        BlocProvider<TagsCubit>(
          create: (context) => TagsCubit()..getAllTagsData(),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(
            adminCubit: context.read<AdminCubit>(),
            iconsCubit: context.read<IconsCubit>(),
            tagsCubit: context.read<TagsCubit>(),
            articlesCubit: context.read<ArticlesCubit>(),
            uid: FirebaseAuth.instance.currentUser?.uid ?? '',
          )..init(),
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
