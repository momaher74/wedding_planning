import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/planning_controller.dart';
import '../controllers/home_controller.dart';
import '../widgets/countdown_timer.dart';

// Body-only version for MainLayout
class PlanningViewBody extends StatelessWidget {
  const PlanningViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlanningController());
    Get.put(HomeController());

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        PlanningViewBackground(),

        Column(
          children: [
            SizedBox(height: 180.h),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Obx(() {
                final controller = Get.find<PlanningController>();
                return CountdownTimer(
                  days: controller.days.value,
                  hours: controller.hours.value,
                  minutes: controller.minutes.value,
                  seconds: controller.seconds.value,
                );
              }),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    // Countdown Timer
                    SizedBox(height: 20.h),
                    // ListView
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h);
                        },
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return _buildWeddingProgressSection();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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
                    Obx(
                      () => Text(
                        '${controller.weddingProgress.value.toInt()}% تم القيام به',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                      ),
                    ),
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
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/img2.jpg',
                width: 70.w,
                height: 140.h,
                fit: BoxFit.cover,

                cacheWidth: 250,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint(
                    'Error loading wedding progress image: assets/images/img4.jpg',
                  );
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
}

// Keep original PlanningView for backward compatibility
class PlanningView extends StatelessWidget {
  const PlanningView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlanningViewBody();
  }
}

class PlanningViewBackground extends StatelessWidget {
  const PlanningViewBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return // Header Section with Background
    Column(
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/img1.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
             Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(color: Colors.black.withOpacity(0.5)),
             ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container(color: Colors.white)),
      ],
    );
  }
}
