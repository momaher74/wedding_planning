import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/shop_category_model.dart';

class ShopController extends GetxController {
  final userName = 'Samantha'.obs;
  final selectedLocation = 'نيويورك'.obs;
  final savedItemsCount = 3.obs;
  
  final categories = <ShopCategoryModel>[].obs;
  final products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
    _loadProducts();
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
      ShopCategoryModel(
        id: '1',
        name: 'Accessories',
        imageUrl: imagePaths[0],
      ),
      ShopCategoryModel(
        id: '2',
        name: 'Jewellery',
        imageUrl: imagePaths[1],
      ),
      ShopCategoryModel(
        id: '3',
        name: 'Groom Wear',
        imageUrl: imagePaths[2],
      ),
      ShopCategoryModel(
        id: '4',
        name: 'Bridal Wear',
        imageUrl: imagePaths[3],
      ),
    ];
  }

  void _loadProducts() {
    // Use available asset images (cycling through img1.jpg to img5.jpg)
    final imagePaths = [
      'assets/images/img1.jpg',
      'assets/images/img2.jpg',
      'assets/images/img3.jpg',
      'assets/images/img4.jpg',
      'assets/images/img5.jpg',
    ];
    
    products.value = [
      ProductModel(
        id: '1',
        name: 'White wedding gown',
        brand: 'Jiahna Dresses',
        location: 'New York',
        price: '\$180.00',
        imageUrl: imagePaths[0],
      ),
      ProductModel(
        id: '2',
        name: 'Long white weding dress',
        brand: 'Keli\'s Fashion',
        location: 'New York',
        price: '\$200.00',
        imageUrl: imagePaths[1],
      ),
      ProductModel(
        id: '3',
        name: 'Elegant white dress',
        brand: 'Bridal Collection',
        location: 'New York',
        price: '\$250.00',
        imageUrl: imagePaths[2],
      ),
      ProductModel(
        id: '4',
        name: 'Classic white gown',
        brand: 'Wedding Dreams',
        location: 'New York',
        price: '\$220.00',
        imageUrl: imagePaths[3],
      ),
    ];
  }

  void changeLocation(String location) {
    selectedLocation.value = location;
  }
}

