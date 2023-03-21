import 'package:dashborad/bloc/admin/admin_cubit.dart';
import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:dashborad/bloc/icons/icons_cubit.dart';
import 'package:dashborad/bloc/tags/tags_cubit.dart';
import 'package:dashborad/data/local/constans/appImages.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomScaffold extends StatelessWidget {
  Widget? child;
  Widget? customBody;
  Widget? drawer;
  Key? customKey;

  CustomScaffold({
    this.customBody,
    this.customKey,
    this.drawer,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => DashboardCubit(
        adminCubit: context.read<AdminCubit>(),
        iconsCubit: context.read<IconsCubit>(),
        tagsCubit: context.read<TagsCubit>(),
        articlesCubit: context.read<ArticlesCubit>(),
        uid: FirebaseAuth.instance.currentUser?.uid ?? '',
      ),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            key: key,
            drawer: drawer,
            body: customBody == null
                ? Container(
                    height: screenSize.height,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.backGround),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: child,
                  )
                : customBody,
          );
        },
      ),
    );
  }
}
