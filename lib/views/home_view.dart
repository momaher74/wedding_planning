import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wedding_planning/core/constants.dart';
import '../controllers/home_controller.dart';
import '../core/app_colors.dart';
import '../core/routes/app_routes.dart';

// Body-only version for MainLayout
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    
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
                  
                  // Greeting and Search Section
                  _buildGreetingSection(),
                  
                  SizedBox(height: 24.h),
                  
                  // Categories Section
                  _buildCategoriesSection(),
                  
                  SizedBox(height: 24.h),

                     // Title
                    Text(
                      'الزفاف المرجعية',
                      style: homeViewTitleStyle,
                    ),
                  
                  // Wedding Progress Section
                  _buildWeddingProgressSection(),
                  
                  SizedBox(height: 24.h),
                  
                  // Nearby Venues Section
                  _buildNearbyVenuesSection(),
                  
                  SizedBox(height: 24.h),
                  
                  // Recent Searches Section
                  _buildRecentSearchesSection(),
                  
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
    final controller = Get.find<HomeController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Profile and Message icons
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 20.sp,
                color: AppColors.darkBrown,
              ),
              SizedBox(width: 16.w),
              Icon(
                Icons.message_outlined,
                size: 20.sp,
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

  Widget _buildGreetingSection() {
    final controller = Get.find<HomeController>();
    return Row(
      children: [
        // Search icon button on the right
        // Greeting text on the left
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                'يا ${controller.userName.value}',
                style: TextStyle(
                  fontSize:16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                  height: 1.2,
                ),
              )),
              SizedBox(height: 2.h),
              Text(
                'ما تبحث عنه ؟',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
         
         Spacer() ,    

         GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.search);
          },
          child: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              color: Get.theme.colorScheme.primary,
              size: 16.sp,
            ),
          ),
        ),
      
      ],
    );
  }

  Widget _buildCategoriesSection() {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الفئات',
          style: homeViewTitleStyle,
        ),
        SizedBox(height: 16.h),
        Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.92,
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return _buildCategoryCard(category);
          },
        )),
      ],
    );
  }

  Widget _buildCategoryCard(category) {
    return GestureDetector(
      onTap: () {
        // Navigate to places screen when category is clicked
        Get.toNamed(AppRoutes.places);
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
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeddingProgressSection() {
    final controller = Get.find<HomeController>();
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // رمادي
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.05),
          //   blurRadius: 10,
          //   offset: const Offset(0, 2),
          //   spreadRadius: 0,
          // ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Column فيه title و body
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                 
        
                    // Body
                    Obx(() => Text(
                      '${controller.weddingProgress.value.toInt()}% تم القيام به',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade700,
                        height: 1.3,
                      ),
                    )),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to checklist
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'عرض جميع المرجعية',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Get.theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward,
                            size: 14.sp,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 100.w), // Space for the image
            ],
          ),
          // الصورة التي تطلع فوق حدود الكونتينر
          Positioned(
            left: 2.w,
            top: -30.h,
            bottom:0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/img2.jpg',
                width: 70.w,
                height: 140.h,
                fit: BoxFit.cover,
                
                
                cacheWidth: 250,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading wedding progress image: assets/images/img4.jpg');
                  debugPrint('Error: $error');
                  return Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Get.theme.colorScheme.primary,
                      size: 50.sp,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyVenuesSection() {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مكان قريبك',
          style:homeViewTitleStyle,
        ),
        SizedBox(height: 16.h),
        Obx(() => SizedBox(
          height: 150.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.nearbyVenues.length,
            itemBuilder: (context, index) {
              final venue = controller.nearbyVenues[index];
              return _buildVenueCard(venue);
            },
          ),
        )),
      ],
    );
  }

  Widget _buildVenueCard(venue) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.venueDetails, arguments: venue);
      },
      child: Container(
        width: 150.w,
        margin: EdgeInsets.only(left: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.05),
            //   blurRadius: 10,
            //   offset: const Offset(0, 2),
            //   spreadRadius: 0,
            // ),
          ],
        ),
        child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image at the bottom
            Image.asset(
              venue.imageUrl,
              fit: BoxFit.cover,
              cacheWidth: 400,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('Error loading venue image: ${venue.imageUrl}');
                debugPrint('Error: $error');
                return Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 50.sp,
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
               // Transparent at top
  // Light white
                    Colors.white.withOpacity(0.6),  // Medium white
                    Colors.white.withOpacity(0.9),  // Heavy white at bottom
                    Colors.white,                    // Full white at bottom
                  ],
                 
                ),
              ),
            ),
            // Venue info text at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      venue.name,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      venue.location,
                      style: TextStyle(
                        fontSize: 7.sp,
                        color: Colors.grey.shade700,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      venue.price,
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.primary,
                        height: 1.2,
                      ),
                      maxLines: 1,
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

  Widget _buildRecentSearchesSection() {
    final controller = Get.find<HomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مكان عمليات البحث الأخيرة',
          style: homeViewTitleStyle,
        ),
        SizedBox(height: 16.h),
        Obx(() => SizedBox(
          height: 145.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.nearbyVenues.length,
            itemBuilder: (context, index) {
              final venue = controller.nearbyVenues[index];
              return _buildVenueCard(venue);
            },
          ),
        )),
      ],
    );
  }
}

// Keep original HomeView for backward compatibility
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeViewBody();
  }
}
