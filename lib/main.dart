import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/blocObs.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:dashborad/data/local/hive/hiveServices.dart';
import 'package:dashborad/data/models/userHiveModel.dart';
import 'package:dashborad/data/remote/repo.dart';
import 'package:dashborad/firebase_options.dart';
import 'package:dashborad/presentation/screens/homeScreen.dart';
import 'package:dashborad/presentation/screens/login_screen.dart';
import 'package:dashborad/presentation/theams.dart';
import 'package:dashborad/presentation/wedgits/custom_scaffold.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  final repository = Repository();
  await Hive.initFlutter('Vaccenily Dashboard');
  Hive.registerAdapter<UserHive>(UserHiveAdapter());
  runApp(MyApp(
    adminCubit: AdminCubit(repository),
  ));
}

class MyApp extends StatelessWidget {
  final AdminCubit adminCubit;
  final Repository _repository = Repository();

  MyApp({super.key, required this.adminCubit});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final repository = Repository();
    var screenSize = MediaQuery.of(context).size;

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
          return MaterialApp(
            title: 'Vaccenily',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.darkTheme,
            home: FutureBuilder(
              future: HiveService().getUser(),
              builder:
                  (BuildContext context, AsyncSnapshot<UserHive?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CustomScaffold(
                    child: GlassmorphismContainer(
                      height: screenSize.height * 0.97,
                      width: screenSize.width * 0.97,
                      child: Center(
                        child: Container(
                          color: Colors.transparent,
                          height: screenSize.height * 0.1,
                          width: screenSize.width * 0.05,
                          child: CircularProgressIndicator(
                            color: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ); // عرض مؤشر التحميل أثناء الانتظار
                }

                if (snapshot.hasData) {
                  // إذا كانت هناك بيانات في Hive، قم بجلب بيانات المستخدم من Firestore
                  _repository.getCurrentAdmin(snapshot.data!.id!);
                  return HomeScreen(
                      adminCubit:
                          adminCubit); // عرض الصفحة الرئيسية للمستخدم المصادق
                } else {
                  return LoginScreen(); // عرض صفحة تسجيل الدخول
                }
              },
            ),
          );
        },
      ),
    );
  }
}
