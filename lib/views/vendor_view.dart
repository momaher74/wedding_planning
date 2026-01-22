import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wedding_planning/core/constants.dart';
import '../controllers/vendor_controller.dart';
import '../core/app_colors.dart';

// Body-only version for MainLayout
class VendorViewBody extends StatelessWidget {
  const VendorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VendorController());

    return Column(
      children: [
        // Top Bar
        _buildTopBar(),

        // Main Content
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  
                  // Title
                  Text(
                    'البائعين',
                    style: homeViewTitleStyle,
                  ),
                  SizedBox(height: 16.h),
                  
                  // Categories Grid
                  Obx(() {
                    final controller = Get.find<VendorController>();
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 0.82,
                      ),
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return _buildCategoryCard(category);
                      },
                    );
                  }),
                  
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    final controller = Get.find<VendorController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Icons
          Row(
            children: [
              Icon(
                Icons.bookmark_border,
                size: 24.sp,
                color: AppColors.darkBrown,
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.message_outlined,
                size: 24.sp,
                color: AppColors.darkBrown,
              ),
            ],
          ),
          // Right side - Location
          GestureDetector(
            onTap: () {
              // TODO: Show location picker
            },
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 20.sp,
                  color: Get.theme.colorScheme.primary,
                ),
                SizedBox(width: 4.w),
                Obx(() => Text(
                  controller.selectedLocation.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.darkBrown,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                SizedBox(width: 2.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.sp,
                  color: AppColors.darkBrown,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(category) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to category
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.05),
            //   blurRadius: 8,
            //   offset: const Offset(0, 2),
            //   spreadRadius: 0,
            // ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image at the bottom
              Image.asset(
                category.imageUrl,
                fit: BoxFit.cover,
                cacheWidth: 300,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading image: ${category.imageUrl}');
                  debugPrint('Error: $error');
                  return Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 35.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  );
                },
              ),
              // White gradient overlay (white at bottom, transparent at top)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0), // Transparent at top
                      Colors.white.withOpacity(0.3),  // Light white
                      Colors.white.withOpacity(0.6),  // Medium white
                      Colors.white.withOpacity(0.9),  // Heavy white at bottom
                      Colors.white,                    // Full white at bottom
                    ],
                    stops: const [0.0, 0.4, 0.6, 0.8, 1.0],
                  ),
                ),
              ),
              // Category name text in black at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        category.description,
                        style: TextStyle(
                          fontSize: 7.sp,
                          color: Colors.grey.shade700,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Keep original VendorView for backward compatibility
class VendorView extends StatelessWidget {
  const VendorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const VendorViewBody();
  }
}
