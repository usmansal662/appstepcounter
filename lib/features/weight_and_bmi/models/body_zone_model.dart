import '../data/body_zone.dart';

class BodyZoneModel {
  final String selectedImage;
  final String image;
  final double minBodyMass;
  final double maxBodyMass;
  final BodyMass bodyMass;

  BodyZoneModel({
    required this.image,
    required this.selectedImage,
    required this.minBodyMass,
    required this.maxBodyMass,
    required this.bodyMass,
  });
}
