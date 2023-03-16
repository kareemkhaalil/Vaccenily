import 'package:dashborad/bloc/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Carousel extends StatelessWidget {
  void Function(int)? onPageChanged;
  PageController? pageController;
  double? scale;
  double? activePageIndex;
  Widget? child;
  int? itemCount;
  Carousel({
    this.itemCount,
    this.child,
    this.activePageIndex,
    this.scale,
    this.pageController,
    this.onPageChanged,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DashboardCubit.get(context);
          return SizedBox(
            height: 200,
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: pageController,
              itemCount: itemCount,
              onPageChanged: onPageChanged,
              itemBuilder: (c, i) {
                return AnimatedScale(
                  scale: scale! == null
                      ? activePageIndex == i
                          ? 1
                          : 0.85
                      : scale!,
                  duration: const Duration(milliseconds: 300),
                  child: child == null
                      ? Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              ),
                            ],
                          ),
                          child: const Center(
                              child:
                                  Text('foo')), // Add your Panorama widget here
                        )
                      : child,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
