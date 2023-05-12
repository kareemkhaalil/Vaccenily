import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/auth/auth_cubit.dart';
import 'package:dashborad/bloc/blocObs.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:dashborad/data/local/hive/hiveServices.dart';
import 'package:dashborad/data/models/userHiveModel.dart';
import 'package:dashborad/data/remote/fireAuth.dart';
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

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).catchError((error) {
    print('Error initializing Firebase: $error');
  });
  Bloc.observer = MyBlocObserver();
  final repository = Repository();
  await Hive.initFlutter();
  Hive.registerAdapter<UserHive>(UserHiveAdapter());
  runApp(MyApp(
    adminCubit: AdminCubit(repository),
    fireAuth: Auth(),
  ));
}

class MyApp extends StatelessWidget {
  final AdminCubit adminCubit;
  final Auth fireAuth;
  final Repository _repository = Repository();

  MyApp({super.key, required this.adminCubit, required this.fireAuth});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final repository = Repository();

    return Column(
      children: [
        Container(
          width: 320,
          height: 840,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 320,
                height: 840,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [Color(0xffff6a64), Color(0xffffb199)],
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 27,
                  top: 109,
                  bottom: 30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Scribble.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 103.50),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 37),
                        Text(
                          "Posts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 37),
                        Text(
                          "Categories",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 37),
                        Text(
                          "Media",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 37),
                        Text(
                          "Users",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 37),
                        Text(
                          "Settings",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 103.50),
                    Container(
                      width: 268,
                      height: 102,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 268,
                            height: 102,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 78,
                              top: 25,
                              bottom: 26,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  height: 51,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Opacity(
                                        opacity: 0.50,
                                        child: Container(
                                          width: 51,
                                          height: 51,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: FlutterLogo(size: 51),
                                        ),
                                      ),
                                      SizedBox(width: 9),
                                      Container(
                                        width: 110,
                                        height: 48,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "User Guide",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(
                                              "Documentation",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1010,
          height: 760,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 96,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dashboard",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 5),
                    Opacity(
                      opacity: 0.40,
                      child: Text(
                        "Home / Dashboard",
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 207,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0x19ff6a64),
                      ),
                      padding: const EdgeInsets.all(42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 231,
                            height: 76,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      "10",
                                      style: TextStyle(
                                        color: Color(0xffff6a64),
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 124),
                                Container(
                                  width: 53,
                                  height: 53,
                                  padding: const EdgeInsets.only(
                                    left: 9,
                                    right: 7,
                                    top: 7,
                                    bottom: 9,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Opacity(
                                        opacity: 0.50,
                                        child: Container(
                                          width: 37.54,
                                          height: 37.54,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: FlutterLogo(
                                              size: 37.541282653808594),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Container(
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0x19ff6a64),
                      ),
                      padding: const EdgeInsets.all(42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 231,
                            height: 76,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Categories",
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      "3",
                                      style: TextStyle(
                                        color: Color(0xffff6a64),
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 66),
                                Opacity(
                                  opacity: 0.50,
                                  child: Container(
                                    width: 53,
                                    height: 53,
                                    padding: const EdgeInsets.all(7),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 39.75,
                                          height: 39.75,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: FlutterLogo(size: 39.75),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Container(
                      width: 310,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0x19ff6a64),
                      ),
                      padding: const EdgeInsets.all(42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 231,
                            height: 76,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Users",
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      "2",
                                      style: TextStyle(
                                        color: Color(0xffff6a64),
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 122),
                                Opacity(
                                  opacity: 0.50,
                                  child: Container(
                                    width: 53,
                                    height: 53,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: FlutterLogo(size: 53),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 193,
                    height: 48.23,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48.23,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: FlutterLogo(size: 48),
                        ),
                        SizedBox(width: 21),
                        Container(
                          width: 124,
                          height: 48,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ryan Adhitama",
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 3),
                              Opacity(
                                opacity: 0.40,
                                child: Text(
                                  "Web Developer",
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 660,
                    height: 318,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Visitor Growth",
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Opacity(
                                  opacity: 0.40,
                                  child: Text(
                                    "Overall Information",
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 253),
                            Container(
                              width: 233,
                              height: 60,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 233,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xff333333),
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 42,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 115,
                                          height: 40,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 115,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomRight,
                                                    end: Alignment.topLeft,
                                                    colors: [
                                                      Color(0xffff6a64),
                                                      Color(0xffffb199)
                                                    ],
                                                  ),
                                                ),
                                                padding: const EdgeInsets.only(
                                                  left: 26,
                                                  right: 25,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Monthly",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 17),
                                        Text(
                                          "Yearly",
                                          style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 54),
                        Container(
                          width: 660,
                          height: 197,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: FlutterLogo(size: 197),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 700,
                top: 442,
                child: Container(
                  width: 310,
                  height: 254,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 310,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0x19ff6a64),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Latest Posts",
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 27),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 161,
                            height: 45,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "The Power of Dream",
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.40,
                                  child: Text(
                                    "28 June 2021",
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 19),
                          Container(
                            width: 145,
                            height: 45,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Emotional Healing",
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.40,
                                  child: Text(
                                    "22 June 2021",
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 19),
                          Container(
                            width: 129,
                            height: 45,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Works vs School",
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.40,
                                  child: Text(
                                    "21 June 2021",
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    //    MultiBlocProvider(
    //     providers: [
    //       BlocProvider<AuthCubit>(
    //         create: (context) => AuthCubit(fireAuth, adminCubit),
    //       ),
    //       BlocProvider<AdminCubit>(
    //         create: (context) => AdminCubit(repository)..getAllUsers(),
    //       ),
    //       BlocProvider<ArticlesCubit>(
    //         create: (context) => ArticlesCubit(repository)..getAllArticles(),
    //       ),
    //       BlocProvider<IconsCubit>(
    //         create: (context) => IconsCubit()..getIconsData(),
    //       ),
    //       BlocProvider<TagsCubit>(
    //         create: (context) => TagsCubit()..getAllTagsData(),
    //       ),
    //       BlocProvider<DashboardCubit>(
    //         create: (context) => DashboardCubit(
    //           authCubit: context.read<AuthCubit>(),
    //           adminCubit: context.read<AdminCubit>(),
    //           iconsCubit: context.read<IconsCubit>(),
    //           tagsCubit: context.read<TagsCubit>(),
    //           articlesCubit: context.read<ArticlesCubit>(),
    //           uid: FirebaseAuth.instance.currentUser?.uid ?? '',
    //         )..init(),
    //       ),
    //     ],
    //     child: BlocConsumer<DashboardCubit, DashboardState>(
    //       listener: (context, state) {},
    //       builder: (context, state) {
    //         return MaterialApp(
    //           title: 'Vaccenily',
    //           debugShowCheckedModeBanner: false,
    //           theme: AppThemes.darkTheme,
    //           home: FutureBuilder(
    //             future: HiveService().getUser(),
    //             builder:
    //                 (BuildContext context, AsyncSnapshot<UserHive?> snapshot) {
    //               var screenSize = MediaQuery.of(context).size;
    //               if (snapshot.connectionState == ConnectionState.waiting) {
    //                 return CustomScaffold(
    //                   child: GlassmorphismContainer(
    //                     height: screenSize.height * 0.97,
    //                     width: screenSize.width * 0.97,
    //                     child: Center(
    //                       child: Container(
    //                         color: Colors.transparent,
    //                         height: screenSize.height * 0.1,
    //                         width: screenSize.width * 0.05,
    //                         child: CircularProgressIndicator(
    //                           color: AppColors.backgroundColor,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ); // عرض مؤشر التحميل أثناء الانتظار
    //               }

    //               if (snapshot.hasData) {
    //                 // إذا كانت هناك بيانات في Hive، قم بجلب بيانات المستخدم من Firestore
    //                 _repository.getCurrentAdmin(snapshot.data!.id!);
    //                 return HomeScreen(
    //                   adminCubit: adminCubit,
    //                   fireAuth: fireAuth,
    //                 ); // عرض الصفحة الرئيسية للمستخدم المصادق
    //               } else {
    //                 return LoginScreen(); // عرض صفحة تسجيل الدخول
    //               }
    //             },
    //           ),
    //         );
    //       },
    //     ),
    //   );
    // }
  }
}
