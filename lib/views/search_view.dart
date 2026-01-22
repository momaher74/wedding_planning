import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as search_ctrl;
import '../core/app_colors.dart';
import '../core/routes/app_routes.dart';
import '../models/venue_model.dart';
import '../models/product_model.dart';
import '../models/service_category_model.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(search_ctrl.SearchController());
    final controller = Get.find<search_ctrl.SearchController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar Header
            _buildSearchHeader(controller),
            
            // Content
            Expanded(
              child: Obx(() {
                if (controller.searchQuery.value.isEmpty) {
                  return _buildEmptyState(controller);
                } else if (controller.searchResults.isEmpty && controller.isSearching.value) {
                  return _buildNoResults();
                } else {
                  return _buildSearchResults(controller);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader(search_ctrl.SearchController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.05),
      //       blurRadius: 4,
      //       offset: const Offset(0, 2),
      //     ),
      //   ],
      // ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(width: 12.w),
          
          // Search field
          Expanded(
            child: Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                autofocus: true,
                controller: controller.searchTextController,
                onChanged: controller.onSearchChanged,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkBrown,
                ),
                decoration: InputDecoration(
                  hintText: 'ابحث عن مكان، منتج، أو خدمة...',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20.sp,
                    color: Colors.grey.shade600,
                  ),
                  suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                      ? GestureDetector(
                          onTap: controller.clearSearch,
                          child: Icon(
                            Icons.clear,
                            size: 20.sp,
                            color: Colors.grey.shade600,
                          ),
                        )
                      : const SizedBox.shrink()),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(search_ctrl.SearchController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          
          // Recent Searches
          Obx(() {
            if (controller.recentSearches.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'البحث الأخير',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                SizedBox(height: 12.h),
                ...controller.recentSearches.map((search) => _buildRecentSearchItem(controller, search)),
                SizedBox(height: 24.h),
              ],
            );
          }),

          // Popular Categories
          Text(
            'الفئات الشائعة',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(height: 12.h),
          Obx(() => Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: controller.allCategories.take(6).map((category) {
              return GestureDetector(
                onTap: () {
                  controller.searchQuery.value = category.name;
                  controller.performSearch(category.name);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Get.theme.colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildRecentSearchItem(search_ctrl.SearchController controller, String search) {
    return GestureDetector(
      onTap: () => controller.selectRecentSearch(search),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.history,
              size: 18.sp,
              color: Colors.grey.shade600,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                search,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.darkBrown,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.sp,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16.h),
          Text(
            'لا توجد نتائج',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'جرب البحث بكلمات مختلفة',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(search_ctrl.SearchController controller) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: controller.searchResults.length,
      itemBuilder: (context, index) {
        final result = controller.searchResults[index];
        final type = result['type'] as String;
        final data = result['data'];

        if (type == 'venue') {
          return _buildVenueResult(data as VenueModel);
        } else if (type == 'product') {
          return _buildProductResult(data as ProductModel);
        } else if (type == 'category') {
          return _buildCategoryResult(data as ServiceCategoryModel, controller);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildVenueResult(VenueModel venue) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.venueDetails, arguments: venue);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
              child: Image.asset(
                venue.imageUrl,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100.w,
                    height: 100.h,
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12.w),
            
            // Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      venue.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            venue.location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      venue.price,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Arrow
            Padding(
              padding: EdgeInsets.all( 12),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey.shade400,
              ),
            ),

                        SizedBox(width: 12.w),

          ],
        ),
      ),
    );
  }

  Widget _buildProductResult(ProductModel product) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r),
            ),
            child: Image.asset(
              product.imageUrl,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100.w,
                  height: 100.h,
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.image,
                    color: Colors.grey.shade400,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12.w),
          
          // Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.brand,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Arrow
          Padding(
            padding: EdgeInsets.all( 12.w),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryResult(ServiceCategoryModel category, search_ctrl.SearchController controller) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.places);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
              child: Image.asset(
                category.imageUrl,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100.w,
                    height: 100.h,
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.image,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12.w),
            
            // Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'فئة',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Arrow
            Padding(
              padding: EdgeInsets.all( 12.w),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

