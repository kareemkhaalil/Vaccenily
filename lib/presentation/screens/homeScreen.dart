import 'package:carousel_slider/carousel_slider.dart';
import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/data/local/constans/appColors.dart';
import 'package:dashborad/data/local/constans/appImages.dart';
import 'package:dashborad/data/models/adminModel.dart';

import 'package:dashborad/presentation/wedgits/auth/custom_auth_text_form.dart';
import 'package:dashborad/presentation/wedgits/custom_scaffold.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardCubit = context.read<DashboardCubit>();
    var screenSize = MediaQuery.of(context).size;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AdminCubit(),
          ),
          BlocProvider(
            create: (context) => ArticlestCubit(),
          ),
          BlocProvider(
            create: (context) => IconsCubit(),
          ),
          BlocProvider(
            create: (context) => TagsCubit(),
          ),
          BlocProvider(
            create: (context) => DashboardCubit(
              adminCubit: context.read<AdminCubit>(),
              iconsCubit: context.read<IconsCubit>(),
              tagsCubit: context.read<TagsCubit>(),
              articlesCubit: context.read<ArticlestCubit>(),
              uid: FirebaseAuth.instance.currentUser!.uid,
            ),
          ),
        ],
        child: BlocConsumer<DashboardCubit, DashboardState>(
            listener: (context, state) {},
            builder: (context, state) {
              return FutureBuilder(
                future: dashboardCubit.fetchData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData == false) {
                    print(snapshot.data);
                    return CircularProgressIndicator();
                  }
// يمكنك استبدا
                  else if (snapshot.error != null) {
                    return Text(snapshot.error
                        .toString()); // يمكنك استبداله بشاشة خطأ مناسبة
                  } else if (state is DashboardDataLoaded) {
                    List<AdminModel> allAdmins = state.adminData;
                    AdminModel loggedInAdmin = state.loggedInAdmin;

                    var cubit = DashboardCubit.get(context);
                    return CustomScaffold(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: screenSize.height * 0.07,
                              width: screenSize.width,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // dashboard
                                    GlassmorphismContainer(
                                      width: screenSize.width * 0.08,
                                      height: screenSize.height * 0.05,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.openDashboard(context);
                                        },
                                        child: Text(
                                          'Dashboard',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.cairo().fontFamily,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.01,
                                    ),
                                    // articles
                                    GlassmorphismContainer(
                                      width: screenSize.width * 0.08,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.openArticles(context);
                                        },
                                        child: Text(
                                          'Articles',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.cairo().fontFamily,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.01,
                                    ),
                                    // tags

                                    GlassmorphismContainer(
                                      width: screenSize.width * 0.08,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.openTags(context);
                                        },
                                        child: Text(
                                          'Tags',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.cairo().fontFamily,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.01,
                                    ),
                                    // icons
                                    GlassmorphismContainer(
                                      width: screenSize.width * 0.08,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        onPressed: () {
                                          cubit.openIcons(context);
                                        },
                                        child: Text(
                                          'Icons',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.cairo().fontFamily,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                            color: AppColors.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width * 0.01,
                                    ),
                                    CustomAuthTextForm(
                                      width: screenSize.width * 0.2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 2,
                              width: screenSize.width,
                              color: AppColors.backgroundColor,
                            ),
                            Stack(
                              children: [
                                // Slide Menue
                                GestureDetector(
                                  onTap: () {
                                    cubit.slideBar();
                                  },
                                  child: Container(
                                    width: screenSize.width * cubit.sliderSmall,
                                    //0.13
                                    height: screenSize.height,

                                    decoration: BoxDecoration(
                                      color: AppColors.darkColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 80),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //dashboard
                                            GestureDetector(
                                              onTap: () {
                                                cubit.openDashboard(context);
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    child: Icon(
                                                      Icons
                                                          .dashboard_customize_rounded,
                                                      size: 25,
                                                      color:
                                                          AppColors.darkColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.01,
                                                  ),
                                                  Text(
                                                    'Dashboard',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.04,
                                            ),
                                            //articles
                                            GestureDetector(
                                              onTap: () {
                                                cubit.openArticles(context);
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    child: Icon(
                                                      Icons.article_rounded,
                                                      size: 25,
                                                      color:
                                                          AppColors.darkColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.01,
                                                  ),
                                                  Text(
                                                    'Articles',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.04,
                                            ),
                                            //tags
                                            GestureDetector(
                                              onTap: () {
                                                cubit.openTags(context);
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    child: Icon(
                                                      Icons.tag_rounded,
                                                      size: 25,
                                                      color:
                                                          AppColors.darkColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.01,
                                                  ),
                                                  Text(
                                                    'Tags',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.04,
                                            ),
                                            //icons
                                            GestureDetector(
                                              onTap: () {
                                                cubit.openIcons(context);
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    child: Icon(
                                                      Icons.edit_rounded,
                                                      size: 25,
                                                      color:
                                                          AppColors.darkColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.01,
                                                  ),
                                                  Text(
                                                    'Icons',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.04,
                                            ),
                                            //Admins
                                            GestureDetector(
                                              onTap: () {
                                                cubit.openAdmin(context);
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    child: Icon(
                                                      Icons.person_rounded,
                                                      size: 25,
                                                      color:
                                                          AppColors.darkColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.01,
                                                  ),
                                                  Text(
                                                    'Admin',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.04,
                                            ),
                                            //logout
                                            GestureDetector(
                                              onTap: () {
                                                print('logout');
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    child: Icon(
                                                      Icons.logout,
                                                      size: 25,
                                                      color:
                                                          AppColors.darkColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.01,
                                                  ),
                                                  Text(
                                                    'Logout',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          GoogleFonts.cairo()
                                                              .fontFamily,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: AppColors
                                                          .backgroundColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: screenSize.height * 0.04,
                                            ),

                                            ///dashboard
                                            // SizedBox(
                                            //   height: screenSize.height * 0.1,
                                            // ),
                                            // Row(
                                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            //   children: [
                                            //     GlassmorphismContainer(
                                            //       width: screenSize.width * 0.2,
                                            //       height: screenSize.height * 0.2,
                                            //       child: Column(
                                            //         mainAxisAlignment: MainAxisAlignment.center,
                                            //         children: [
                                            //           Text(
                                            //             'Total Articles',
                                            //             style: TextStyle(
                                            //               fontFamily:
                                            //                   GoogleFonts.cairo().fontFamily,
                                            //               fontSize: 20,
                                            //               fontWeight: FontWeight.w900,
                                            //               color: AppColors.backgroundColor,
                                            //             ),
                                            //           ),
                                            //           SizedBox(
                                            //             height: screenSize.height * 0.01,
                                            //           ),
                                            //           Text(
                                            //             '100',
                                            //             style: TextStyle(
                                            //               fontFamily:
                                            //                   GoogleFonts.cairo().fontFamily,
                                            //               fontSize: 20,
                                            //               fontWeight: FontWeight.w900,
                                            //               color: AppColors.backgroundColor,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     GlassmorphismContainer(
                                            //       width: screenSize.width * 0.2,
                                            //       height: screenSize.height * 0.2,
                                            //       child: Column(
                                            //         mainAxisAlignment: MainAxisAlignment.center,
                                            //         children: [
                                            //           Text(
                                            //             'Total Tags',
                                            //             style: TextStyle(
                                            //               fontFamily:
                                            //                   GoogleFonts.cairo().fontFamily,
                                            //               fontSize: 20,
                                            //               fontWeight: FontWeight.w900,
                                            //               color: AppColors.backgroundColor,
                                            //             ),
                                            //           ),
                                            //           SizedBox(
                                            //             height: screenSize.height * 0.01,
                                            //           ),
                                            //           Text(
                                            //             '100',
                                            //             style: TextStyle(
                                            //               fontFamily:
                                            //                   GoogleFonts.cairo().fontFamily,
                                            //               fontSize: 20,
                                            //               fontWeight: FontWeight.w900,
                                            //               color: AppColors.backgroundColor,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //     GlassmorphismContainer(
                                            //       width: screenSize.width * 0.2,
                                            //       height: screenSize.height * 0.2,
                                            //       child: Column(
                                            //         mainAxisAlignment: MainAxisAlignment.center,
                                            //         children: [
                                            //           Text(
                                            //             'Total Icons',
                                            //             style: TextStyle(
                                            //               fontFamily:
                                            //                   GoogleFonts.cairo().fontFamily,
                                            //               fontSize: 20,
                                            //               fontWeight: FontWeight.w900,
                                            //               color: AppColors.backgroundColor,
                                            //             ),
                                            //           ),
                                            //           SizedBox(
                                            //             height: screenSize.height * 0.01,
                                            //           ),
                                            //           Text(
                                            //             '100',
                                            //             style: TextStyle(
                                            //               fontFamily:
                                            //                   GoogleFonts.cairo().fontFamily,
                                            //               fontSize: 20,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Transform.scale(
                                  alignment: Alignment.centerRight,
                                  scaleY: screenSize.height * 0.00105,
                                  scaleX: screenSize.width * cubit.scalX,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: screenSize.height * 0.00018,
                                        left: screenSize.width * 0.03,
                                        right: screenSize.width * 0.001,
                                        bottom: 0,
                                      ),
                                      child: GlassmorphismContainer(
                                        width: screenSize.width,
                                        height: screenSize.height,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SingleChildScrollView(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                /// Dashboard Page
                                                AnimatedOpacity(
                                                  opacity:
                                                      cubit.dashboardOpacity!,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  child: Column(
                                                    children: [
                                                      cubit.iconsModel?.iId ==
                                                              null
                                                          ? Center(
                                                              child:
                                                                  GlassmorphismContainer(
                                                                width:
                                                                    screenSize
                                                                        .width,
                                                                height: screenSize
                                                                        .height *
                                                                    0.2,
                                                                child: Center(
                                                                  child: Text(
                                                                    'No Data',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          GoogleFonts.cairo()
                                                                              .fontFamily,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      color: AppColors
                                                                          .backgroundColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : CarouselSlider
                                                              .builder(
                                                              options:
                                                                  CarouselOptions(
                                                                height: screenSize
                                                                        .height *
                                                                    0.3,
                                                                aspectRatio:
                                                                    2.0,
                                                                enlargeCenterPage:
                                                                    false,
                                                                viewportFraction:
                                                                    1,
                                                                enableInfiniteScroll:
                                                                    true,
                                                                onPageChanged:
                                                                    (index,
                                                                        reason) {
                                                                  cubit.changePage(
                                                                      index);
                                                                },
                                                              ),
                                                              itemCount: (cubit
                                                                      .iconsModel!
                                                                      .iId!
                                                                      .length)
                                                                  .round(),
                                                              itemBuilder:
                                                                  (context,
                                                                      index,
                                                                      realIdx) {
                                                                final int
                                                                    first =
                                                                    index * 2;
                                                                final int
                                                                    second =
                                                                    first + 1;
                                                                final int
                                                                    third =
                                                                    second + 1;
                                                                final int
                                                                    fourth =
                                                                    third + 1;
                                                                final int
                                                                    fifth =
                                                                    fourth + 1;
                                                                final int
                                                                    sixth =
                                                                    fifth + 1;
                                                                final int
                                                                    seventh =
                                                                    sixth + 1;
                                                                final int
                                                                    eighth =
                                                                    seventh + 1;

                                                                return Row(
                                                                  children: [
                                                                    first,
                                                                    second,
                                                                    third,
                                                                    fourth,
                                                                    fifth,
                                                                    sixth,
                                                                    seventh,
                                                                    eighth,
                                                                  ].map((idx) {
                                                                    return Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Stack(
                                                                        alignment:
                                                                            Alignment.topCenter,
                                                                        children: [
                                                                          GlassmorphismContainer(
                                                                            height:
                                                                                screenSize.height * 0.3,
                                                                            width:
                                                                                screenSize.width * 0.1,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                GlassmorphismContainer(
                                                                              height: screenSize.height * 0.15,
                                                                              width: screenSize.width * 0.085,
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                            top:
                                                                                screenSize.height * 0.17,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Text(
                                                                                  cubit.iconsModel!.title![idx].toString(),
                                                                                  style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    fontFamily: GoogleFonts.cairo().fontFamily,
                                                                                    fontWeight: FontWeight.w900,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: screenSize.height * 0.01,
                                                                                ),
                                                                                GlassmorphismContainer(
                                                                                  height: screenSize.height * 0.05,
                                                                                  width: screenSize.width * 0.08,
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.symmetric(
                                                                                      horizontal: 10.0,
                                                                                    ),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Articles',
                                                                                          style: TextStyle(
                                                                                            fontSize: 20,
                                                                                            fontFamily: GoogleFonts.cairo().fontFamily,
                                                                                            fontWeight: FontWeight.w900,
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: screenSize.width * 0.01,
                                                                                        ),
                                                                                        Text(
                                                                                          cubit.iconsModel!.posts!.length.toString(),
                                                                                          style: TextStyle(
                                                                                            fontSize: 20,
                                                                                            fontFamily: GoogleFonts.cairo().fontFamily,
                                                                                            fontWeight: FontWeight.w900,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                );
                                                              },
                                                            ),
                                                      SizedBox(
                                                        height:
                                                            screenSize.height *
                                                                0.02,
                                                      ),
                                                      GlassmorphismContainer(
                                                        width: screenSize.width,
                                                        height:
                                                            screenSize.height *
                                                                0.3,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 12.0,
                                                              ),
                                                              child:
                                                                  GlassmorphismContainer(
                                                                width: screenSize
                                                                        .width /
                                                                    3,
                                                                height: screenSize
                                                                        .height *
                                                                    0.27,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    /// Icon
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "20",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                60,
                                                                            color:
                                                                                AppColors.backgroundColor,
                                                                            fontFamily:
                                                                                GoogleFonts.cairo().fontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              screenSize.height * 0.003,
                                                                        ),
                                                                        Text(
                                                                          'Icons',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColors.backgroundColor,
                                                                            fontSize:
                                                                                27,
                                                                            fontFamily:
                                                                                GoogleFonts.cairo().fontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: screenSize
                                                                              .width *
                                                                          0.04,
                                                                    ),
                                                                    Container(
                                                                      height: screenSize
                                                                              .height *
                                                                          0.24,
                                                                      width: 1,
                                                                      color: AppColors
                                                                          .backgroundColor
                                                                          .withOpacity(
                                                                              0.6),
                                                                    ),
                                                                    SizedBox(
                                                                      width: screenSize
                                                                              .width *
                                                                          0.03,
                                                                    ),

                                                                    /// Tags
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "20",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                60,
                                                                            color:
                                                                                AppColors.backgroundColor,
                                                                            fontFamily:
                                                                                GoogleFonts.cairo().fontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              screenSize.height * 0.003,
                                                                        ),
                                                                        Text(
                                                                          'Tags',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColors.backgroundColor,
                                                                            fontSize:
                                                                                27,
                                                                            fontFamily:
                                                                                GoogleFonts.cairo().fontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: screenSize
                                                                              .width *
                                                                          0.03,
                                                                    ),
                                                                    Container(
                                                                      height: screenSize
                                                                              .height *
                                                                          0.24,
                                                                      width: 1,
                                                                      color: AppColors
                                                                          .backgroundColor
                                                                          .withOpacity(
                                                                              0.6),
                                                                    ),
                                                                    SizedBox(
                                                                      width: screenSize
                                                                              .width *
                                                                          0.03,
                                                                    ),

                                                                    /// Articles
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "20",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                60,
                                                                            color:
                                                                                AppColors.backgroundColor,
                                                                            fontFamily:
                                                                                GoogleFonts.cairo().fontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              screenSize.height * 0.003,
                                                                        ),
                                                                        Text(
                                                                          'Articles',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                AppColors.backgroundColor,
                                                                            fontSize:
                                                                                27,
                                                                            fontFamily:
                                                                                GoogleFonts.cairo().fontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: (screenSize
                                                                          .width /
                                                                      3) *
                                                                  1.8,
                                                              height: screenSize
                                                                      .height *
                                                                  0.27,
                                                              child:
                                                                  CarouselSlider
                                                                      .builder(
                                                                options:
                                                                    CarouselOptions(
                                                                  height: screenSize
                                                                          .height *
                                                                      0.3,
                                                                  aspectRatio:
                                                                      2.0,
                                                                  enlargeCenterPage:
                                                                      false,
                                                                  viewportFraction:
                                                                      1,
                                                                  enableInfiniteScroll:
                                                                      true,
                                                                ),
                                                                itemCount: 10,
                                                                itemBuilder:
                                                                    (context,
                                                                        index,
                                                                        realIdx) {
                                                                  final int
                                                                      first =
                                                                      index * 2;
                                                                  final int
                                                                      second =
                                                                      first + 1;
                                                                  final int
                                                                      third =
                                                                      second +
                                                                          1;
                                                                  final int
                                                                      fourth =
                                                                      third + 1;
                                                                  final fifth =
                                                                      fourth +
                                                                          1;

                                                                  return Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      first,
                                                                      second,
                                                                      third,
                                                                      fourth,
                                                                      fifth,
                                                                    ].map(
                                                                        (idx) {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(12.0),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            GlassmorphismContainer(
                                                                              height: screenSize.height * 0.3,
                                                                              width: screenSize.width * 0.1,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  GlassmorphismContainer(
                                                                                    height: screenSize.height * 0.08,
                                                                                    width: screenSize.width * 0.1,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        "Tag Name",
                                                                                        style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.cairo().fontFamily, fontWeight: FontWeight.w900, color: AppColors.backgroundColor),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: screenSize.height * 0.03,
                                                                                  ),
                                                                                  GlassmorphismContainer(
                                                                                    height: screenSize.height * 0.05,
                                                                                    width: screenSize.width * 0.08,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(
                                                                                        horizontal: 10.0,
                                                                                      ),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Articles',
                                                                                            style: TextStyle(
                                                                                              fontSize: 20,
                                                                                              fontFamily: GoogleFonts.cairo().fontFamily,
                                                                                              fontWeight: FontWeight.w900,
                                                                                              color: AppColors.backgroundColor.withOpacity(
                                                                                                0.8,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: screenSize.width * 0.01,
                                                                                          ),
                                                                                          Text(
                                                                                            '10',
                                                                                            style: TextStyle(
                                                                                              fontSize: 20,
                                                                                              fontFamily: GoogleFonts.cairo().fontFamily,
                                                                                              fontWeight: FontWeight.w900,
                                                                                              color: AppColors.backgroundColor.withOpacity(
                                                                                                0.7,
                                                                                              ),
                                                                                            ),
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
                                                                      );
                                                                    }).toList(),
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        height:
                                                            screenSize.height *
                                                                0.02,
                                                      ),

                                                      /// Articles
                                                      CarouselSlider.builder(
                                                        options:
                                                            CarouselOptions(
                                                          height: screenSize
                                                                  .height *
                                                              0.3,
                                                          aspectRatio: 2.0,
                                                          enlargeCenterPage:
                                                              false,
                                                          viewportFraction: 1,
                                                          enableInfiniteScroll:
                                                              true,
                                                        ),
                                                        itemCount: (10).round(),
                                                        // (cubit.articleModel!
                                                        //         .aid!.length)
                                                        //     .round(),
                                                        itemBuilder: (context,
                                                            index, realIdx) {
                                                          final int first =
                                                              index * 2;
                                                          final int second =
                                                              first + 1;
                                                          final int third =
                                                              second + 1;
                                                          return Row(
                                                            children: [
                                                              first,
                                                              second,
                                                              third,
                                                            ].map(
                                                              (idx) {
                                                                return Expanded(
                                                                  flex: 1,
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    children: [
                                                                      GlassmorphismContainer(
                                                                        height: screenSize.height *
                                                                            0.3,
                                                                        width: screenSize.width *
                                                                            0.3,
                                                                      ),
                                                                      Positioned(
                                                                        left: screenSize.width *
                                                                            0.01,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                12,
                                                                            horizontal:
                                                                                10,
                                                                          ),
                                                                          child:
                                                                              GlassmorphismContainer(
                                                                            height:
                                                                                screenSize.height * 0.28,
                                                                            width:
                                                                                screenSize.width * 0.15,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: ClipRRect(
                                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                child: Image.asset(
                                                                                  AppImages.backGround,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        right: screenSize.width *
                                                                            0.02,
                                                                        top: screenSize.width *
                                                                            0.007,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(
                                                                            10,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                children: [
                                                                                  Container(
                                                                                    width: screenSize.width * 0.12,
                                                                                    child: Text(
                                                                                      "تطعيم 3500 مواطن ضد فيروس كورونا بمحافظة دمياط",
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      maxLines: 1,
                                                                                      style: TextStyle(
                                                                                        fontSize: 24,
                                                                                        fontFamily: GoogleFonts.cairo().fontFamily,
                                                                                        fontWeight: FontWeight.w900,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: screenSize.height * 0.0001,
                                                                                  ),
                                                                                  Container(
                                                                                    height: screenSize.height * 0.28,
                                                                                    width: screenSize.width * 0.12,
                                                                                    child: Text(
                                                                                      "أعلنت مديرية الصحة بدمياط، عن تنفيذ حملة طرق الأبواب، التي تستهدف الوصول إلى أكبر عدد ممكن من المواطنين، للتطعيم بلقاح الكورونا (جرعة أولى، ثانية، تنشيطية ثالثة، تنشيطية رابعة)أعلنت مديرية الصحة بدمياط، عن تنفيذ حملة طرق الأبواب، التي تستهدف الوصول إلى أكبر عدد ممكن من المواطنين، للتطعيم بلقاح الكورونا (جرعة أولى، ثانية، تنشيطية ثالثة، تنشيطية رابعة).أعلنت مديرية الصحة بدمياط، عن تنفيذ حملة طرق الأبواب، التي تستهدف الوصول إلى أكبر عدد ممكن من المواطنين، للتطعيم بلقاح الكورونا (جرعة أولى، ثانية، تنشيطية ثالثة، تنشيطية رابعة.",
                                                                                      textAlign: TextAlign.right,
                                                                                      maxLines: 5,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(
                                                                                        fontSize: 18,
                                                                                        fontFamily: GoogleFonts.cairo().fontFamily,
                                                                                        fontWeight: FontWeight.w400,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ).toList(),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                /// Admin Page
                                                AnimatedOpacity(
                                                  opacity: cubit.adminOpacity!,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          GlassmorphismContainer(
                                                              width: screenSize
                                                                      .width /
                                                                  3,
                                                              height: screenSize
                                                                  .height,
                                                              child: Column(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      print(
                                                                        loggedInAdmin
                                                                            .name,
                                                                      );
                                                                      print(
                                                                        loggedInAdmin
                                                                            .email,
                                                                      );
                                                                      print(
                                                                        loggedInAdmin
                                                                            .uid,
                                                                      );
                                                                    },
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          50,
                                                                      child: Image.network(loggedInAdmin
                                                                          .image
                                                                          .toString()),
                                                                    ),
                                                                  ),
                                                                  Text(loggedInAdmin
                                                                      .name
                                                                      .toString()),
                                                                  Text(loggedInAdmin
                                                                      .email
                                                                      .toString()),
                                                                ],
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                /// Icons Page
                                                AnimatedOpacity(
                                                  opacity: cubit.iconsOpacity!,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: Text('Icons'),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                /// Tags Page
                                                AnimatedOpacity(
                                                  opacity: cubit.tagsOpacity!,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: Text('Tags'),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                /// Articles Page
                                                AnimatedOpacity(
                                                  opacity:
                                                      cubit.articlesOpacity!,
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  child: Column(
                                                    children: [
                                                      Center(
                                                        child: Text('Articles'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: GoogleFonts.cairo().fontFamily,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }));
  }
}
