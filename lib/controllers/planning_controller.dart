import 'dart:async';
import 'package:get/get.dart';
import '../models/planning_card_model.dart';

class PlanningController extends GetxController {
  final groomName = 'Jonathan'.obs;
  final brideName = 'Samantha'.obs;
  
  // Countdown timer
  final days = 56.obs;
  final hours = 23.obs;
  final minutes = 26.obs;
  final seconds = 59.obs;
  Timer? _countdownTimer;

  final cards = <PlanningCardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCards();
    _startCountdown();
  }

  void _loadCards() {
    cards.value = [
      PlanningCardModel(
        id: '1',
        title: 'تم القيام به',
        value: '10%',
        actionText: 'عرض جميع المرجعية',
        illustrationType: 'checklist',
      ),
      PlanningCardModel(
        id: '2',
        title: 'قائمة مختصرة البائع',
        value: '12',
        actionText: 'عرض الكل',
        illustrationType: 'vendors',
      ),
      PlanningCardModel(
        id: '3',
        title: 'الأفكار المحفوظة',
        value: '29',
        actionText: 'عرض الكل',
        illustrationType: 'ideas',
      ),
      PlanningCardModel(
        id: '4',
        title: 'التسوق المحفوظة',
        value: '09',
        actionText: 'عرض الكل',
        illustrationType: 'shopping',
      ),
    ];
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        seconds.value = 59;
        if (minutes.value > 0) {
          minutes.value--;
        } else {
          minutes.value = 59;
          if (hours.value > 0) {
            hours.value--;
          } else {
            hours.value = 23;
            if (days.value > 0) {
              days.value--;
            } else {
              timer.cancel();
            }
          }
        }
      }
    });
  }

  @override
  void onClose() {
    _countdownTimer?.cancel();
    super.onClose();
  }
}

