import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wedding_planning/core/constants.dart';
import '../controllers/shop_controller.dart';
import '../core/app_colors.dart';

// Body-only version for MainLayout
class ShopViewBody extends StatelessWidget {
  const ShopViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShopController());
    
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
                  // SizedBox(height: 16.h),
                  
                  // // Search and Greeting Section
                  // _buildSearchAndGreeting(),
                  
                  SizedBox(height: 24.h),
                  
                  // Categories Section
                  _buildCategories(),
                  
                  SizedBox(height: 24.h),
                  
                  // Wedding Shopping & Saved Items
                  _buildSavedItemsBanner(),
                  
                  SizedBox(height: 24.h),
                  
                  // Nearby Sellers Section
                  _buildNearbySellers(),
                  
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
    final controller = Get.find<ShopController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.1),
      //       blurRadius: 4,
      //       offset: const Offset(0, 2),
      //     ),
      //   ],
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Icons
          Row(
            children: [
              Icon(Icons.person_outline, size: 24.sp, color: AppColors.darkBrown),
              SizedBox(width: 16.w),
              Icon(Icons.message_outlined, size: 24.sp, color: AppColors.darkBrown),
              SizedBox(width: 16.w),
              Icon(Icons.bookmark_border, size: 24.sp, color: AppColors.darkBrown),
            ],
          ),
          // Right side - Location
          GestureDetector(
            onTap: () {
              // TODO: Show location picker
            },
            child: Row(
              children: [
                Icon(Icons.location_on, size: 20.sp, color: Get.theme.colorScheme.primary),
                SizedBox(width: 4.w),
                Obx(() => Text(
                  controller.selectedLocation.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.darkBrown,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                Icon(Icons.keyboard_arrow_down, size: 20.sp, color: AppColors.darkBrown),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndGreeting() {
    final controller = Get.find<ShopController>();
    return Row(
      children: [
        // Search Button
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: 28.sp,
          ),
        ),
        SizedBox(width: 16.w),
        // Greeting Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                'يا ${controller.userName.value}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              )),
              SizedBox(height: 4.h),
              Text(
                'دردشة وشراء مباشرة من البائع.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildCategories() {
    final controller = Get.find<ShopController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return _buildCategoryCard(category);
            },
          ),
        )),
      ],
    );
  }

  Widget _buildCategoryCard(category) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to category
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(left: 12.w),
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
                  debugPrint('Error loading category image: ${category.imageUrl}');
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

  Widget _buildSavedItemsBanner() {
    final controller = Get.find<ShopController>();
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
                      '${controller.savedItemsCount.value} العناصر المحفوظة',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade700,
                        height: 1.3,
                      ),
                    )),
                    SizedBox(height: 10.h),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to saved items
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'عرض العناصر المحفوظة',
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
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/img3.jpg',
                width: 70.w,
                height: 140.h,
                fit: BoxFit.cover,
                cacheWidth: 250,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading saved items image: assets/images/img3.jpg');
                  debugPrint('Error: $error');
                  return Container(
                    width: 120.w,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.shopping_bag,
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

  Widget _buildNearbySellers() {
    final controller = Get.find<ShopController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الباعة القريبة منك',
          style: homeViewTitleStyle
        ),
        SizedBox(height: 16.h),
        Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return _buildProductCard(product);
          },
        )),
      ],
    );
  }

  Widget _buildProductCard(product) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to product details
      },
      child: Container(
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
                product.imageUrl,
                fit: BoxFit.cover,
                cacheWidth: 400,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading product image: ${product.imageUrl}');
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
                      Colors.white.withOpacity(0.6),  // Medium white
                      Colors.white.withOpacity(0.9),  // Heavy white at bottom
                      Colors.white,                    // Full white at bottom
                    ],
                  ),
                ),
              ),
              // Product info text at the bottom
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
                        product.name,
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
                        product.brand,
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
                        product.price,
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
}

// Keep original ShopView for backward compatibility
class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShopViewBody();
  }
}
