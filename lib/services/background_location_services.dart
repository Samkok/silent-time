import 'dart:developer';

import 'package:background_location/background_location.dart' as bgLocation;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundLocationService {
  @pragma('vm:entry-point')
  void initBackgroundLocationTracking() async {
    try {
      print(
          'initBackgroundLocationTracking:......................................');

      // await bgLocation.BackgroundLocation.setAndroidNotification(
      //   title: 'Location tracking',
      //   message: 'Background location is active',
      //   icon: '@mipmap/ic_launcher',
      // );
      log(".......................1....................");

      await bgLocation.BackgroundLocation.startLocationService();
      log(".......................2....................");
      await bgLocation.BackgroundLocation.getLocationUpdates((location) {
        log(".......................3....................");

        log("BackgroundLocation listen ${location.latitude}");
        print("BackgroundLocation listen");
      });
      log(".......................4....................");
    } catch (e) {
      print("Error initializing background location: $e");
      // Handle the exception appropriately
    }
  }

  // stopBackgoundLocationTracking() {
  //   bgLocation.BackgroundLocation.stopLocationService();
  // }

  getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    SharedPreferences pref = await SharedPreferences.getInstance();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.changeSettings(interval: 0, distanceFilter: 0.0);
    location.enableBackgroundMode(enable: true);

    locationData = await location.getLocation();

    double lat = locationData.latitude ?? 0.0;
    double long = locationData.longitude ?? 0.0;

    location.onLocationChanged.listen((event) {
      log("onLocationChanged: $event");
      lat = event.latitude ?? 0.0;
      long = event.longitude ?? 0.0;
    });
    // location.changeNotificationOptions(
    //   title: 'Geolocation',
    //   subtitle: 'Geolocation detection',
    // );

    print("Current_location: ${lat}:${long}");

    pref.setDouble("lat", lat);
    pref.setDouble("long", long);
  }
}
