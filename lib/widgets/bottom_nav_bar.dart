import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainNavigationController>();
    
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.explore,
                label: 'بالقرب منك',
                index: 0,
                controller: controller,
              ),
              _buildNavItem(
                icon: Icons.checklist,
                label: 'تخطيط',
                index: 1,
                controller: controller,
              ),
              _buildNavItem(
                icon: Icons.shopping_bag,
                label: 'محل',
                index: 2,
                controller: controller,
              ),
              _buildNavItem(
                icon: Icons.lightbulb,
                label: 'الأفكار',
                index: 3,
                controller: controller,
              ),
              _buildNavItem(
                icon: Icons.store,
                label: 'بائع',
                index: 4,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required MainNavigationController controller,
  }) {
    final isSelected = controller.currentIndex.value == index;
    
    return GestureDetector(
      onTap: () {
        controller.changeTab(index);
        // Screen will change automatically via Obx in MainLayout
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected 
                ? Get.theme.colorScheme.primary 
                : Colors.grey.shade400,
            size: 24.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: isSelected 
                  ? Get.theme.colorScheme.primary 
                  : Colors.grey.shade400,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

