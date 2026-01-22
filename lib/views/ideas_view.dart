import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../controllers/ideas_controller.dart';
import '../core/app_colors.dart';

// Body-only version for MainLayout
class IdeasViewBody extends StatelessWidget {
  const IdeasViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(IdeasController());
    
    return Column(
      children: [
        // Header
        _buildHeader(),
        
        // Filter Bar
        _buildFilterBar(),
        
        // Main Content - Staggered Image Grid (Instagram-like)
        Expanded(
          child: Obx(() {
            final controller = Get.find<IdeasController>();
            return MasonryGridView.count(
              padding: EdgeInsets.all(8.w),
              crossAxisCount: 2,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              itemCount: controller.ideas.length,
              itemBuilder: (context, index) {
                final idea = controller.ideas[index];
                // Create varying heights for staggered Instagram-like effect
                // More variation: base height + random variation based on index
                final heightVariations = [120.h, 180.h, 200.h, 160.h, 220.h, 140.h];
                final height = heightVariations[index % heightVariations.length];
                return _buildIdeaCard(idea, height);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Heart and Search icons
          Row(
            children: [
              Icon(
                Icons.favorite,
                size: 18.sp,
                color: Get.theme.colorScheme.primary,
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.search,
                size: 18.sp,
                color: AppColors.darkBrown,
              ),
            ],
          ),
          // Right side - Title
          Text(
            'الأفكار',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    final controller = Get.find<IdeasController>();
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.filters.length,
        itemBuilder: (context, index) {
          final filter = controller.filters[index];
          final isSelected = controller.selectedFilter.value == filter;
          
          return GestureDetector(
            onTap: () => controller.selectFilter(filter),
            child: Container(
              margin: EdgeInsets.only(left: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected 
                    ? Get.theme.colorScheme.primary 
                    : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected 
                      ? Get.theme.colorScheme.primary 
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : AppColors.darkBrown,
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  Widget _buildIdeaCard(idea, double height) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to idea details
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Actual image from assets
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                idea.imageUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image,
                      size: 60.sp,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
            // Like count overlay
            Positioned(
              bottom: 8.h,
              left: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 14.sp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${idea.likes}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Keep original IdeasView for backward compatibility
class IdeasView extends StatelessWidget {
  const IdeasView({super.key});

  @override
  Widget build(BuildContext context) {
    return const IdeasViewBody();
  }
}
