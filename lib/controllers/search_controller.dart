import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/venue_model.dart';
import '../models/product_model.dart';
import '../models/service_category_model.dart';

class SearchController extends GetxController {
  final searchQuery = ''.obs;
  final isSearching = false.obs;
  final searchTextController = TextEditingController();
  
  // All searchable items
  final allVenues = <VenueModel>[].obs;
  final allProducts = <ProductModel>[].obs;
  final allCategories = <ServiceCategoryModel>[].obs;
  
  // Search results
  final searchResults = <dynamic>[].obs;
  final recentSearches = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAllData();
  }

  void _loadAllData() {
    // Load venues
    allVenues.value = [
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

    // Load products
    allProducts.value = [
      ProductModel(
        id: '1',
        name: 'Wedding Dress',
        brand: 'Elegant Bridal',
        location: 'New York',
        price: '\$500',
        imageUrl: 'assets/images/img4.jpg',
      ),
      ProductModel(
        id: '2',
        name: 'Bridal Bouquet',
        brand: 'Floral Design',
        location: 'New York',
        price: '\$150',
        imageUrl: 'assets/images/img5.jpg',
      ),
    ];

    // Load categories
    allCategories.value = [
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
        name: 'Catering',
        imageUrl: 'assets/images/img4.jpg',
      ),
      ServiceCategoryModel(
        id: '5',
        name: 'Decor',
        imageUrl: 'assets/images/img5.jpg',
      ),
    ];
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value = false;
    } else {
      isSearching.value = true;
      performSearch(query);
    }
  }

  void performSearch(String query) {
    final results = <dynamic>[];
    final lowerQuery = query.toLowerCase();

    // Search venues
    for (var venue in allVenues) {
      if (venue.name.toLowerCase().contains(lowerQuery) ||
          venue.location.toLowerCase().contains(lowerQuery)) {
        results.add({'type': 'venue', 'data': venue});
      }
    }

    // Search products
    for (var product in allProducts) {
      if (product.name.toLowerCase().contains(lowerQuery) ||
          product.brand.toLowerCase().contains(lowerQuery)) {
        results.add({'type': 'product', 'data': product});
      }
    }

    // Search categories
    for (var category in allCategories) {
      if (category.name.toLowerCase().contains(lowerQuery)) {
        results.add({'type': 'category', 'data': category});
      }
    }

    searchResults.value = results;
  }

  void clearSearch() {
    searchQuery.value = '';
    searchTextController.clear();
    searchResults.clear();
    isSearching.value = false;
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  void addToRecentSearches(String query) {
    if (query.isNotEmpty && !recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
    }
  }

  void selectRecentSearch(String query) {
    searchQuery.value = query;
    searchTextController.text = query;
    searchTextController.selection = TextSelection.collapsed(offset: query.length);
    performSearch(query);
    isSearching.value = true;
  }
}

