class PlanningCardModel {
  final String id;
  final String title;
  final String value;
  final String actionText;
  final String illustrationType; // 'checklist', 'vendors', 'ideas', 'shopping'

  PlanningCardModel({
    required this.id,
    required this.title,
    required this.value,
    required this.actionText,
    required this.illustrationType,
  });
}

