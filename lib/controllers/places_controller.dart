import 'package:get/get.dart';
import '../models/venue_model.dart';

class PlacesController extends GetxController {
  final venues = <VenueModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadVenues();
  }

  void _loadVenues() {
    // Use available asset images (cycling through venue images)
    final imagePaths = [
      'assets/images/img1.jpg',
      'assets/images/img2.jpg',
      'assets/images/img3.jpg',
      'assets/images/img4.jpg',
      'assets/images/img5.jpg',
      'assets/images/img1.jpg', // Cycle back
      'assets/images/img2.jpg',
    ];
    
    venues.value = [
      VenueModel(
        id: '1',
        name: 'Central Wednue',
        location: 'Hemilton Bridge, Opp, Jacker\'s Park, New York',
        rating: 4.3,
        reviewCount: 198,
        price: '\$20 فصاعدا',
        imageUrl: imagePaths[0],
        availableAreas: [
          VenueArea(name: 'Conferenace Hall', seatingCapacity: 100, maxCapacity: 120),
          VenueArea(name: 'Garden', seatingCapacity: 1200, maxCapacity: 1500),
          VenueArea(name: 'Main Hall', seatingCapacity: 800, maxCapacity: 1000),
          VenueArea(name: 'Dining Area', seatingCapacity: 500, maxCapacity: 800),
        ],
        gallery: [
          VenueGalleryItem(areaName: 'Dining Area', imageUrl: imagePaths[0], photoCount: 35),
          VenueGalleryItem(areaName: 'Main Hall', imageUrl: imagePaths[1], photoCount: 24),
          VenueGalleryItem(areaName: 'Conference Hall', imageUrl: imagePaths[2], photoCount: 35),
          VenueGalleryItem(areaName: 'Garden', imageUrl: imagePaths[3], photoCount: 16),
        ],
      ),
      VenueModel(
        id: '2',
        name: 'Good Time Venue',
        location: 'Derhaman Point',
        rating: 4.8,
        reviewCount: 124,
        price: '\$22 فصاعدا',
        imageUrl: imagePaths[1],
        availableAreas: [
          VenueArea(name: 'Main Hall', seatingCapacity: 600, maxCapacity: 800),
          VenueArea(name: 'Garden', seatingCapacity: 800, maxCapacity: 1000),
        ],
        gallery: [
          VenueGalleryItem(areaName: 'Main Hall', imageUrl: imagePaths[1], photoCount: 20),
          VenueGalleryItem(areaName: 'Garden', imageUrl: imagePaths[2], photoCount: 15),
        ],
      ),
      VenueModel(
        id: '3',
        name: 'Celebration Poin',
        location: 'Golden Business Center',
        rating: 4.9,
        reviewCount: 198,
        price: '\$18 فصاعدا',
        imageUrl: imagePaths[2],
        availableAreas: [
          VenueArea(name: 'Grand Hall', seatingCapacity: 1000, maxCapacity: 1200),
          VenueArea(name: 'Outdoor Area', seatingCapacity: 500, maxCapacity: 600),
        ],
        gallery: [
          VenueGalleryItem(areaName: 'Grand Hall', imageUrl: imagePaths[2], photoCount: 30),
          VenueGalleryItem(areaName: 'Outdoor Area', imageUrl: imagePaths[3], photoCount: 18),
        ],
      ),
      VenueModel(
        id: '4',
        name: 'Wedding saga',
        location: 'Royal Plaza Market',
        rating: 5.0,
        reviewCount: 68,
        price: '\$15 فصاعدا',
        imageUrl: imagePaths[3],
        availableAreas: [
          VenueArea(name: 'Ballroom', seatingCapacity: 400, maxCapacity: 500),
        ],
        gallery: [
          VenueGalleryItem(areaName: 'Ballroom', imageUrl: imagePaths[3], photoCount: 25),
        ],
      ),
      VenueModel(
        id: '5',
        name: 'Peral Avenue',
        location: 'Rodriks Point',
        rating: 4.5,
        reviewCount: 128,
        price: '\$23 فصاعدا',
        imageUrl: imagePaths[4],
        availableAreas: [
          VenueArea(name: 'Main Hall', seatingCapacity: 700, maxCapacity: 900),
          VenueArea(name: 'Garden', seatingCapacity: 900, maxCapacity: 1100),
        ],
        gallery: [
          VenueGalleryItem(areaName: 'Main Hall', imageUrl: imagePaths[4], photoCount: 28),
          VenueGalleryItem(areaName: 'Garden', imageUrl: imagePaths[0], photoCount: 22),
        ],
      ),
      VenueModel(
        id: '6',
        name: 'Silver Stone',
        location: 'Hemilton Bridge',
        rating: 4.2,
        reviewCount: 98,
        price: '\$20 فصاعدا',
        imageUrl: imagePaths[5],
        availableAreas: [
          VenueArea(name: 'Hall', seatingCapacity: 500, maxCapacity: 600),
        ],
        gallery: [
          VenueGalleryItem(areaName: 'Hall', imageUrl: imagePaths[5], photoCount: 20),
        ],
      ),
      VenueModel(
        id: '7',
        name: 'Central Wednue',
        location: 'Hemilton Bridge',
        rating: 4.3,
        reviewCount: 198,
        price: '\$20 فصاعدا',
        imageUrl: imagePaths[6],
        availableAreas: [
          VenueArea(name: 'Main Hall', seatingCapacity: 600, maxCapacity: 750),
        ],
        gallery: [
          VenueGalleryItem(areaName: 'Main Hall', imageUrl: imagePaths[6], photoCount: 18),
        ],
      ),
    ];
  }
}

