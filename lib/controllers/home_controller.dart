import 'package:get/get.dart';
import '../models/service_category_model.dart';
import '../models/venue_model.dart';

class HomeController extends GetxController {
  final userName = 'Samantha'.obs;
  final selectedLocation = 'نيويورك'.obs;
  final weddingProgress = 10.0.obs;
  
  final categories = <ServiceCategoryModel>[].obs;
  final nearbyVenues = <VenueModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
    _loadVenues();
  }

  void _loadCategories() {
    categories.value = [
      ServiceCategoryModel(
        id: '1',
        name: 'Makeup',
        imageUrl: 'assets/images/img1.jpg',
      ),
      ServiceCategoryModel(
        id: '2',
        name: 'Photographer',
        imageUrl: 'assets/images/img2.jpg',
      ),
      ServiceCategoryModel(
        id: '3',
        name: 'Venue',
        imageUrl: 'assets/images/img3.jpg',
      ),
      ServiceCategoryModel(
        id: '4',
        name: 'View 19 more +',
        imageUrl: 'assets/images/img3.jpg', // Same as Venue but will be faded
      ),
      ServiceCategoryModel(
        id: '5',
        name: 'Catering',
        imageUrl: 'assets/images/img4.jpg',
      ),
      ServiceCategoryModel(
        id: '6',
        name: 'Decor',
        imageUrl: 'assets/images/img5.jpg',
      ),
    ];
  }

  void _loadVenues() {
    nearbyVenues.value = [
      VenueModel(
        id: '1',
        name: 'Time Venue',
        location: 'erhaman Point',
        price: '\$22 فصاعدا',
        imageUrl: 'assets/images/img1.jpg',
      ),
      VenueModel(
        id: '2',
        name: 'GreenLeaf Resort',
        location: 'Operum Tower',
        price: '\$18 فصاعدا',
        imageUrl: 'assets/images/img2.jpg',
      ),
      VenueModel(
        id: '3',
        name: 'Central Wednue',
        location: 'Hemilton Bridge',
        price: '\$20 فصاعدا',
        imageUrl: 'assets/images/img3.jpg',
      ),
    ];
  }

  void changeLocation(String location) {
    selectedLocation.value = location;
  }
}

