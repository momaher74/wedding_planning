class VenueArea {
  final String name;
  final int seatingCapacity;
  final int maxCapacity;

  VenueArea({
    required this.name,
    required this.seatingCapacity,
    required this.maxCapacity,
  });
}

class VenueGalleryItem {
  final String areaName;
  final String imageUrl;
  final int photoCount;

  VenueGalleryItem({
    required this.areaName,
    required this.imageUrl,
    required this.photoCount,
  });
}

class VenueModel {
  final String id;
  final String name;
  final String location;
  final String price;
  final String imageUrl;
  final double? rating;
  final int? reviewCount;
  final List<VenueArea>? availableAreas;
  final List<VenueGalleryItem>? gallery;

  VenueModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    this.rating,
    this.reviewCount,
    this.availableAreas,
    this.gallery,
  });
}

