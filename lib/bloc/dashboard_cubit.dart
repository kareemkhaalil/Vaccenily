import 'dart:async';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/data/local/constans/constans.dart';
import 'package:dashborad/data/models/adminModel.dart';
import 'package:dashborad/data/models/articlesModel.dart';
import 'package:dashborad/data/models/iconsModel.dart';
import 'package:dashborad/data/models/tagsModel.dart';
import 'package:file/file.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required this.adminCubit,
    required this.iconsCubit,
    required this.tagsCubit,
    required this.articlesCubit,
    required this.uid,
  }) : super(DashboardInitial());

  static DashboardCubit get(context) => BlocProvider.of(context);
  final AdminCubit adminCubit;
  final IconsCubit iconsCubit;
  final TagsCubit tagsCubit;
  final ArticlestCubit articlesCubit;
  String uid;
  StreamController<AdminModel> adminModelController =
      StreamController<AdminModel>.broadcast();
  // Future<void> fetchData() async {
  //   try {
  //     await adminCubit.getUserData(uid);
  //     // await adminCubit.getAllUsers();
  //     // await iconsCubit.getIconsData();
  //     // await tagsCubit.getAllTagsData();
  //     // await articlesCubit.getAllArticles();
  //   } catch (e) {
  //     print('Error in fetchData: $e');
  //     emit(DashboardErrorState(
  //       error: e.toString(),
  //     ));
  //   }
  // }

  Future<void> fetchData() async {
    // استدعاء دوال الحصول على البيانات من الـcubits الأخرى
    final adminData = await adminCubit.getData();
    final allAdminsData = await adminCubit.getAllUsers();

    // استخدم Future.wait للتأكد من أن جميع الطلبات قد انتهت قبل الانتقال إلى الخطوة التالية
    await Future.wait([
      iconsCubit.getIconsData(),
      tagsCubit.getAllTagsData(),
      articlesCubit.getAllArticles(),
    ]);

    // تحقق من حالات الـcubits الأخرى بعد الانتهاء من تحميل البيانات
    final iconsState = iconsCubit.state;
    final tagsState = tagsCubit.state;
    final articlesState = articlesCubit.state;
    print('iconsState: $iconsState');
    print('tagsState: $tagsState');
    print('articlesState: $articlesState');

    if (adminData != null &&
        iconsState is IconsLoaded &&
        tagsState is TagsLoaded &&
        articlesState is ArticlesLoaded) {
      emit(DashboardDataLoaded(
        loggedInAdmin: adminData,
        adminData: allAdminsData,
        iconsData: iconsState.iconsData,
        tagsData: tagsState.tagsData,
        articlesData: articlesState.articlesData,
      ));
      print('data is loaded');
      print('admin data is ${adminData.name}');
    } else {
      print('error in data');
    }
  }

  var sliderSmall = 0.05;
  double xOffset = 60;
  double yOffset = 0;
  double scalX = 0.000527;
  bool sidebarOpen = false;
  double? adminOpacity = 0;
  double? tagsOpacity = 0;
  double? articlesOpacity = 0;
  double? iconsOpacity = 0;
  double? dashboardOpacity = 1;
  AdminModel? adminModel;
  TagsModel? tagsModel;
  IconsModel? iconsModel;
  ArticlesModel? articleModel;

  bool isDark = false;
  CarouselController buttonCarouselController = CarouselController();

  PageController? pageController;

  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  int activePageIndex = 0;

  void slideBar() {
    if (sliderSmall == 0.05 || scalX == 0.00051) {
      sliderSmall = 0.13;
      scalX = 0.000483;
      emit(OpenSideBar());
      print('slider is open');
    } else {
      sliderSmall = 0.05;
      scalX = 0.000527;
      emit(CloseSideBar());
      print('slider is close');
    }
  }

  void changeAppMode() {
    isDark = !isDark;
    if (isDark) {
      emit(AppThemeModeDark());
    } else {
      emit(AppThemeModeLight());
    }
  }

  init() {
    xOffset = 60;
    yOffset = 0;
    sidebarOpen = false;
    dashboardOpacity = 1;
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 0;
    adminModel = AdminModel();
    tagsModel = TagsModel();
    iconsModel = IconsModel();
    articleModel = ArticlesModel();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
    super.emit(DashboardInitial());
  }

  void nextCaro() {
    buttonCarouselController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    emit(NextPageState());
  }

  void prevCaro() {
    try {
      buttonCarouselController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      emit(PreviousPageState());
    } on Exception catch (e) {
      emit(PreviousPageState());
      print(e.toString());
    }
  }

  void changePage(int index) {
    buttonCarouselController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    emit(ChangePageState());
  }

  void openAdmin(context) {
    adminOpacity = 1;
    tagsOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 0;
    dashboardOpacity = 0;
    AdminCubit().getUserData(Constants().adminUID.toString());
    print(Constants().adminUID.toString());
    emit(OpenAdminState());
  }

  void openTags(context) {
    adminOpacity = 0;
    tagsOpacity = 1;
    articlesOpacity = 0;
    iconsOpacity = 0;
    dashboardOpacity = 0;
    emit(OpenTagsState());
  }

  void openArticles(context) {
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 1;
    iconsOpacity = 0;
    dashboardOpacity = 0;
    emit(OpenArticlesState());
  }

  void openIcons(context) {
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 1;
    dashboardOpacity = 0;
    emit(OpenIconsState());
  }

  void openDashboard(context) {
    adminOpacity = 0;
    tagsOpacity = 0;
    articlesOpacity = 0;
    iconsOpacity = 0;
    dashboardOpacity = 1;
    emit(OpenDashboardState());
  }
}
