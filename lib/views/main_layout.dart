import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';
import '../core/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_view.dart';
import 'shop_view.dart';
import 'ideas_view.dart';
import 'vendor_view.dart';
import 'planning_view.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(MainNavigationController());
    // Initialize to home (index 0) if not already set
    if (navController.currentIndex.value != 0) {
      navController.changeTab(0);
    }
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() => _getCurrentScreen(navController.currentIndex.value)),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _getCurrentScreen(int index) {
    switch (index) {
      case 0:
        return const HomeViewBody(); // Home screen
      case 1:
        return const PlanningViewBody();
      case 2:
        return const ShopViewBody();
      case 3:
        return const IdeasViewBody();
      case 4:
        return const VendorViewBody();
      default:
        return const HomeViewBody();
    }
  }
}
