import 'dart:math';
import 'package:latlong2/latlong.dart';

double calculateDistanceInMeters(LatLng start, LatLng end) {
  const double earthRadius = 6371000; // Earth's radius in meters

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  double startLatRadians = degreesToRadians(start.latitude);
  double startLngRadians = degreesToRadians(start.longitude);
  double endLatRadians = degreesToRadians(end.latitude);
  double endLngRadians = degreesToRadians(end.longitude);

  double latDiff = endLatRadians - startLatRadians;
  double lngDiff = endLngRadians - startLngRadians;

  double a = sin(latDiff / 2) * sin(latDiff / 2) +
      cos(startLatRadians) *
          cos(endLatRadians) *
          sin(lngDiff / 2) *
          sin(lngDiff / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;

  return distance;
}



double degreesToRadians(double degrees) {
  return degrees * (pi / 180.0);
}