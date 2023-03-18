part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardDataLoaded extends DashboardState {
  final List<AdminModel> adminData;
  final List<IconsModel> iconsData;
  final List<TagsModel> tagsData;
  final List<ArticlesModel> articlesData;
  final AdminModel loggedInAdmin;

  const DashboardDataLoaded({
    required this.loggedInAdmin,
    required this.adminData,
    required this.iconsData,
    required this.tagsData,
    required this.articlesData,
  });

  @override
  List<Object> get props =>
      [adminData, iconsData, tagsData, articlesData, loggedInAdmin];
}

class DashboardInitial extends DashboardState {}

class AppThemeModeLight extends DashboardState {}

class AppThemeModeDark extends DashboardState {}

class OpenSideBar extends DashboardState {}

class CloseSideBar extends DashboardState {}

class ChangePageState extends DashboardState {}

class NextPageState extends DashboardState {}

class PreviousPageState extends DashboardState {}

class OpenAdminState extends DashboardState {}

class OpenArticlesState extends DashboardState {}

class OpenTagsState extends DashboardState {}

class OpenIconsState extends DashboardState {}

class OpenDashboardState extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {}

class DashboardErrorState extends DashboardState {
  final String error;

  const DashboardErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
