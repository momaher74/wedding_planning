import 'package:get/get.dart';
import '../models/vendor_category_model.dart';

class VendorController extends GetxController {
  final selectedLocation = 'نيويورك'.obs;
  
  final categories = <VendorCategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  void _loadCategories() {
    // Use available asset images (cycling through img1.jpg to img5.jpg)
    final imagePaths = [
      'assets/images/img1.jpg',
      'assets/images/img2.jpg',
      'assets/images/img3.jpg',
      'assets/images/img4.jpg',
      'assets/images/img5.jpg',
    ];
    
    categories.value = [
      VendorCategoryModel(
        id: '1',
        name: 'Venue',
        description: '...Lawn, Banquet halls, Farmhouse',
        imageUrl: imagePaths[0],
      ),
      VendorCategoryModel(
        id: '2',
        name: 'Photographer',
        description: '...Photographer, cinematograph',
        imageUrl: imagePaths[1],
      ),
      VendorCategoryModel(
        id: '3',
        name: 'Makeup',
        description: 'Bridal Makeup Hair Stylist Famous',
        imageUrl: imagePaths[2],
      ),
      VendorCategoryModel(
        id: '4',
        name: 'Decor',
        description: '...Decorators, Wedding Planner',
        imageUrl: imagePaths[3],
      ),
      VendorCategoryModel(
        id: '5',
        name: 'Catering',
        description: '...Catering, Cake, Bartenders, Fast',
        imageUrl: imagePaths[4],
      ),
      VendorCategoryModel(
        id: '6',
        name: 'Music & Dance',
        description: '...DJ music, Choreographer Orch',
        imageUrl: imagePaths[0], // Cycle back
      ),
      VendorCategoryModel(
        id: '7',
        name: 'Invitation & Gift',
        description: 'Invitation Card, Guest',
        imageUrl: imagePaths[1], // Cycle back
      ),
    ];
  }

  void changeLocation(String location) {
    selectedLocation.value = location;
  }
}

