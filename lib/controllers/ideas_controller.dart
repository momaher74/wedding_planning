import 'package:get/get.dart';
import '../models/idea_model.dart';

class IdeasController extends GetxController {
  final selectedFilter = 'الجميع'.obs;
  final filters = [
    'الجميع',
    'مكان',
    'ميك أب',
    'قبل الزفاف',
    'العروس ارتداء',
  ].obs;
  
  final ideas = <IdeaModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadIdeas();
  }

  void _loadIdeas() {
    // Load ideas based on selected filter - using actual asset images
    final imagePaths = [
      'assets/images/img1.jpg',
      'assets/images/img2.jpg',
      'assets/images/img3.jpg',
      'assets/images/img4.jpg',
      'assets/images/img5.jpg',
    ];
    
    // Create multiple ideas cycling through available images
    ideas.value = List.generate(15, (index) {
      final imageIndex = index % imagePaths.length;
      return IdeaModel(
        id: '${index + 1}',
        imageUrl: imagePaths[imageIndex],
        likes: 50 + (index * 7) % 200, // Varying likes count
      );
    });
  }

  void selectFilter(String filter) {
    selectedFilter.value = filter;
    _loadIdeas(); // Reload ideas based on filter
  }
}

