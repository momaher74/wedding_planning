import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/login_view.dart';
import '../../views/registration_view.dart';
import '../../views/otp_verification_view.dart';
import '../../views/main_layout.dart';
import '../../views/places_view.dart';
import '../../views/venue_details_view.dart';
import '../../views/search_view.dart';
import '../../core/app_colors.dart';
import 'app_routes.dart';

class AppPages {
  // Custom transition duration
  static const Duration _transitionDuration = Duration(milliseconds: 450);
  static const Duration _fastTransitionDuration = Duration(milliseconds: 350);

  static final List<GetPage> routes = [
    // Auth routes - Fade in for smooth entrance
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => const RegistrationView(),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () {
        final phoneNumber = Get.arguments as String? ?? '';
        return OTPVerificationView(phoneNumber: phoneNumber);
      },
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    // Main app routes - All screens use MainLayout - Right to left for RTL
    GetPage(
      name: AppRoutes.home,
      page: () => const MainLayout(),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.vendor,
      page: () => const MainLayout(),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.ideas,
      page: () => const MainLayout(),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.shop,
      page: () => const MainLayout(),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.planning,
      page: () => const MainLayout(),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    // Places screen - standalone (not using MainLayout) - Right to left slide
    GetPage(
      name: AppRoutes.places,
      page: () => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: const PlacesViewBody(),
          ),
        ),
      ),
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    // Venue Details screen - Fade in with scale for elegant entrance
    GetPage(
      name: AppRoutes.venueDetails,
      page: () {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: const VenueDetailsView(),
            ),
          ),
        );
      },
      transition: Transition.fadeIn,
      transitionDuration: _transitionDuration,
    ),
    // Search screen - Bottom to top for search overlay feel
    GetPage(
      name: AppRoutes.search,
      page: () {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: const SearchView(),
        );
      },
      transition: Transition.downToUp,
      transitionDuration: _fastTransitionDuration,
    ),
  ];
}

