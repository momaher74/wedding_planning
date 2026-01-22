import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/places_controller.dart';
import '../core/app_colors.dart';
import '../core/routes/app_routes.dart';
import '../models/venue_model.dart';

// Body-only version for MainLayout
class PlacesViewBody extends StatelessWidget {
  const PlacesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlacesController());
    
    return Column(
      children: [
        // Navigation Bar with bookmark and search
        _buildNavigationBar(),
        
        // Main Content - Venue List
        Expanded(
          child: _buildVenueList(),
        ),
      ],
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios, size: 16.sp, color: AppColors.darkBrown)),
          SizedBox(width: 8.w),
            Text("أماكن", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.darkBrown),) , 
            Spacer(),
          Icon(
            Icons.bookmark,
            size: 24.sp,
            color: AppColors.darkBrown,
          ),
          SizedBox(width: 16.w),
          Icon(
            Icons.search,
            size: 24.sp,
            color: AppColors.darkBrown,
          ),

        
        ],
      ),
    );
  }

  Widget _buildVenueList() {
    final controller = Get.find<PlacesController>();
    return Obx(() => ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: controller.venues.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade300,
      ),
      itemBuilder: (context, index) {
        final venue = controller.venues[index];
        return _buildVenueItem(venue);
      },
    ));
  }

  Widget _buildVenueItem(VenueModel venue) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.venueDetails, arguments: venue);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                venue.imageUrl,
                width: 110.w,
                height: 110.h,
                fit: BoxFit.cover,
                cacheWidth: 300,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110.w,
                    height: 110.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 40.sp,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 16.w),
            // Venue Details
            Expanded(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Venue Name
                  Text(
                    venue.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
            
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Location
                  Text(
                    venue.location,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.darkBrown,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Rating and Reviews
                  if (venue.rating != null && venue.reviewCount != null)
                    Row(
                      children: [
                        // Review Count
                        Text(
                          '(${venue.reviewCount} reviews)',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        // Rating Number
                        Text(
                          venue.rating!.toString(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkBrown,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        // Star Icon
                        Icon(
                          Icons.star,
                          size: 12.sp,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  if (venue.rating != null && venue.reviewCount != null)
                    SizedBox(height: 10.h),
                  // Price
                  Text(
                    venue.price,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

// Keep original PlacesView for backward compatibility
class PlacesView extends StatelessWidget {
  const PlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlacesViewBody();
  }
}

