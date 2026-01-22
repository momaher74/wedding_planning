import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/venue_model.dart';
import '../core/app_colors.dart';
import '../controllers/places_controller.dart';
import '../core/routes/app_routes.dart';

class VenueDetailsView extends StatelessWidget {
  // Static mock venue data that will always be displayed
  static final VenueModel _mockVenue = VenueModel(
    id: '1',
    name: 'Central Wednue',
    location: 'Hemilton Bridge, Opp, Jacker\'s Park, New York',
    rating: 4.3,
    reviewCount: 198,
    price: '\$20 فصاعدا',
    imageUrl: 'assets/images/img1.jpg',
    availableAreas: [
      VenueArea(name: 'Conferenace Hall', seatingCapacity: 100, maxCapacity: 120),
      VenueArea(name: 'Garden', seatingCapacity: 1200, maxCapacity: 1500),
      VenueArea(name: 'Main Hall', seatingCapacity: 800, maxCapacity: 1000),
      VenueArea(name: 'Dining Area', seatingCapacity: 500, maxCapacity: 800),
    ],
    gallery: [
      VenueGalleryItem(areaName: 'Dining Area', imageUrl: 'assets/images/img1.jpg', photoCount: 35),
      VenueGalleryItem(areaName: 'Main Hall', imageUrl: 'assets/images/img2.jpg', photoCount: 24),
      VenueGalleryItem(areaName: 'Conference Hall', imageUrl: 'assets/images/img3.jpg', photoCount: 35),
      VenueGalleryItem(areaName: 'Garden', imageUrl: 'assets/images/img4.jpg', photoCount: 16),
    ],
  );

  const VenueDetailsView({
    super.key,
    VenueModel? venue, // Made optional, but will be ignored
  });

  VenueModel get venue => _mockVenue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background similar to PlanningViewBackground
          VenueDetailsBackground(venue: venue),
          // Bottom Sheet
          _buildBottomSheet(context),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.66,
      minChildSize: 0.65,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      // Venue Name
                      Text(
                        venue.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                      SizedBox(height: 8.h),
                      // Location
                      Text(
                        venue.location,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Rating and Price Row
                      Row(
                        children: [
                          // Rating
                          if (venue.rating != null && venue.reviewCount != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 18.sp,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  venue.rating!.toString(),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkBrown,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '(${venue.reviewCount} تقييم)',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                             
                              ],
                            ),
                          SizedBox(width: 16.w),
                          // Price
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
            

            
                      SizedBox(height:20.h),
                      // Available Areas Section
                      if (venue.availableAreas != null && venue.availableAreas!.isNotEmpty)
                        _buildAvailableAreasSection(),
                      if (venue.availableAreas != null && venue.availableAreas!.isNotEmpty)
                        Divider(color: Colors.grey.shade300, height: 1.h),
                     
                      SizedBox(height: 10.h),
                      // Gallery Section
                      if (venue.gallery != null && venue.gallery!.isNotEmpty)
                        _buildGallerySection(),
                      SizedBox(height: 10.h),


                      // Places List Section
                      _buildPlacesListSection(),
                      Divider(color: Colors.grey.shade300, height: 1.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvailableAreasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
              'المنطقة المتاحة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
        SizedBox(height: 16.h),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 3.h,
            childAspectRatio: 2,
          ),
          itemCount: venue.availableAreas!.length,
          itemBuilder: (context, index) {
            final area = venue.availableAreas![index];
            return _buildAreaItem(area);
          },
        ),
      ],
    );
  }

  Widget _buildAreaItem(VenueArea area) {
    return Container(
      padding: EdgeInsets.all(12.w),
    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            area.name,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${area.seatingCapacity} جلوس | max ${area.maxCapacity}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacesListSection() {
    // Initialize PlacesController if not already initialized
    if (!Get.isRegistered<PlacesController>()) {
      Get.put(PlacesController());
    }
    final controller = Get.find<PlacesController>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أماكن أخرى',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        SizedBox(height: 16.h),
        Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.venues.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          itemBuilder: (context, index) {
            final venue = controller.venues[index];
            return _buildVenueListItem(venue);
          },
        )),
      ],
    );
  }

  Widget _buildVenueListItem(VenueModel venue) {
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

  Widget _buildGallerySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ملف',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBrown,
              ),
            ),
        
          ],
        ),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.0,
          ),
          itemCount: venue.gallery!.length,
          itemBuilder: (context, index) {
            final galleryItem = venue.gallery![index];
            return _buildGalleryItem(galleryItem);
          },
        ),
                SizedBox(height: 8.h),

              Divider(color: Colors.grey.shade300, height: 1.h),
      ],
    );
  }

  Widget _buildGalleryItem(VenueGalleryItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image at the bottom
            Image.asset(
              item.imageUrl,
              fit: BoxFit.cover,
              cacheWidth: 400,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('Error loading gallery image: ${item.imageUrl}');
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
            // Gallery info text at the bottom
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
                      item.areaName,
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
                      '${item.photoCount} الصور',
                      style: TextStyle(
                        fontSize: 7.sp,
                        color: Colors.grey.shade700,
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
    );
  }

}

class VenueDetailsBackground extends StatelessWidget {
  final VenueModel venue;

  const VenueDetailsBackground({
    super.key,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              Image.asset(
                venue.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.image,
                      size: 60.sp,
                      color: Colors.grey.shade400,
                    ),
                  );
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
              // Back button
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container(color: Colors.white)),
      ],
    );
  }
}

