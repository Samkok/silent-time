import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as lat;
// import 'package:latlong2/latlong.dart' as latlon;
// import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:silenttime/screens/my_rules/controller/myrules_controller.dart';
import 'package:silenttime/screens/my_rules/pages/location_picker.dart';
import 'package:silenttime/utils/app_imaes.dart';
import 'package:silenttime/utils/colors.dart';
import 'package:silenttime/widges/custom_text.dart';

// import 'location_picker.dart';

// var mapKey = "AIzaSyDdKJjEi61s6sSfSQv2IceTYzBm-o-o7G8";

// locationPiker(context) async {
//   MyRulesController myRulesController = Get.put(MyRulesController());
//   var latlng = await getCurrentLocation();
//   print('latlng: ${latlng}');
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PlacePicker(
//         apiKey: mapKey,
//         onPlacePicked: (result) {
//           myRulesController.updateLocationDetail(result);
//           Navigator.of(context).pop();
//         },
//         initialPosition:
//             LatLng(latlng.latitude ?? 56.462002, latlng.longitude ?? -2.970700),
//         useCurrentLocation: true,
//         resizeToAvoidBottomInset:
//             false, // only works in page mode, less flickery, remove if wrong offsets
//       ),
//     ),
//   );
// }

// getCurrentLocation() async {
//   Location location = new Location();

//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;
//   LocationData _locationData;

//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return;
//     }
//   }

//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return;
//     }
//   }

//   _locationData = await location.getLocation();
//   return lat.LatLng(_locationData.latitude ?? 56.462002,
//       _locationData.longitude ?? -2.970700);
// }

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  // MapController mapController = MapController();
  MyRulesController myRulesController = Get.put(MyRulesController());
  // double currentZoom = 13.0;

  Completer<GoogleMapController> _controller = Completer();
  LatLng _initialPosition = LatLng(0, 0);
  Location _location = Location();
  late StreamSubscription<LocationData> _locationSubscription;
  Set<Marker> _markers = {};
  late Circle _circle;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  FutureOr<void> _getCurrentLocation() async {
    try {
      // LocationData locationData = await _location.getLocation();
      setState(() {
        _initialPosition = LatLng(
            double.parse(myRulesController.trigerModelSaveIndex!.locationLat!),
            double.parse(
                myRulesController.trigerModelSaveIndex!.locationLong!));
        _markers.clear();
        _markers.add(Marker(
          markerId: MarkerId("current_location"),
          position: _initialPosition,
          infoWindow: InfoWindow(title: "Current Location"),
        ));

        _circle = Circle(
          circleId: CircleId("current_circle"),
          center: _initialPosition,
          radius: double.parse(myRulesController
              .trigerModelSaveIndex!.zoneRadious!), // initial radius, in meters
          fillColor: Colors.red.withOpacity(0.3),
          strokeWidth: 2,
          strokeColor: Colors.red,
        );
        // LatLng(locationData.latitude!, locationData.longitude!);
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _updateCircle(double zoom) {
    if (_circle != null) {
      double newRadius =
          double.parse(myRulesController.trigerModelSaveIndex!.zoneRadious!) *
              (1 / zoom); // Adjust radius based on zoom level
      setState(() {
        _circle = _circle.copyWith(radiusParam: newRadius);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyRulesController>(
        init: MyRulesController(),
        builder: (controller) {
          return Container(
            width: Get.width,
            decoration: const BoxDecoration(
                // color: AppColors.black,
                // image: DecorationImage(
                //   image: AssetImage(AppImaes.mapImage),
                //   fit: BoxFit.cover,
                // ),
                ),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          double.parse(
                              controller.trigerModelSaveIndex!.locationLat!),
                          double.parse(
                              controller.trigerModelSaveIndex!.locationLong!)),
                      zoom: 16.0,
                    ),
                    markers: _markers,
                    circles: Set.of([_circle]),
                    onCameraMove: (CameraPosition position) {
                      _updateCircle(position.zoom);
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    ].toSet(),
                  ),
                  // FlutterMap(
                  //   // ignore: sort_child_properties_last
                  //   children: [
                  //     TileLayer(
                  //       urlTemplate:
                  //           'https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png',
                  //       subdomains: const ['a', 'b', 'c'],
                  //     ),
                  //     CircleLayer(
                  //       circles: [
                  //         CircleMarker(
                  //           point: lat.LatLng(
                  //               double.parse(controller
                  //                   .trigerModelSaveIndex!.locationLat!),
                  //               double.parse(controller
                  //                   .trigerModelSaveIndex!.locationLong!)),
                  //           color: Colors.green.withOpacity(0.5),
                  //           radius: controller.circleRadius.value,
                  //           //  double.parse(controller
                  //           //         .trigerModelSaveIndex!.zoneRadious
                  //           //         .toString()) ??
                  //           //     0.0, // Radius in meters
                  //           borderColor: Colors.green,
                  //           borderStrokeWidth: 2,
                  //         ),
                  //       ],
                  //     ),
                  //     MarkerLayer(
                  //       markers: [
                  //         Marker(
                  //           width: 40,
                  //           height: 40,
                  //           point: lat.LatLng(
                  //               double.parse(controller
                  //                   .trigerModelSaveIndex!.locationLat!),
                  //               double.parse(controller
                  //                   .trigerModelSaveIndex!.locationLong!)),
                  //           //  LatLng(bin.latitude ?? 0.0, bin.longitude ?? 0.0),

                  //           builder: (ctx) => Opacity(
                  //             opacity: 1,
                  //             child: Icon(
                  //               Icons.location_on,
                  //               color: Colors.blue,
                  //               size: 40,
                  //             ),
                  //             //  Image(
                  //             //   image:
                  //             //       const AssetImage(AppImaes.locationLogog),
                  //             //   height: 15.h,
                  //             //   width: 15.w,
                  //             // ),
                  //           ),
                  //           rotate: true,
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  //   options: MapOptions(
                  //       interactiveFlags:
                  //           InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                  //       center: lat.LatLng(
                  //           double.parse(
                  //               controller.trigerModelSaveIndex!.locationLat!),
                  //           double.parse(controller
                  //               .trigerModelSaveIndex!.locationLong!)),
                  //       maxZoom: 16,
                  //       minZoom: 1,
                  //       zoom: currentZoom,
                  //       onPositionChanged: (position, hasGesture) {
                  //         currentZoom = position.zoom!;
                  //         print('currentZoom: ${currentZoom}');
                  //         var circleRadius = 50 * (currentZoom / 18);

                  //         print("..circleRadius..  :$circleRadius");
                  //         controller.circleRadiusUpdate(circleRadius);
                  //       },
                  //       onTap: (_, latLng) {},
                  //       onMapReady: () {
                  //         print('currentZoom: ${currentZoom}');
                  //         var circleRadius = 50 * (currentZoom / 18);

                  //         print("..circleRadius..  :$circleRadius");
                  //         controller.circleRadiusUpdate(circleRadius);
                  //       }),
                  // ),
                ),
                Container(
                  // height: 25.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                  decoration: BoxDecoration(color: AppColors.blueF4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: CText(
                          text: controller.trigerModelSaveIndex!.zoneName!,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      CText(
                        text:
                            '   Radious :(${controller.trigerModelSaveIndex!.zoneRadious})',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      // color: Colors.amber,
                      width: Get.width * 0.85,
                      padding: EdgeInsets.only(top: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // locationPiker(context);
                              addZoneDialog(context, isFromUpdate: true);
                            },
                            child: Container(
                              height: 55.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.primaryBlue,
                              ),
                              child: Center(
                                child: CText(
                                  text: 'Change trigger',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.updateTrigerSteps(1);
                            },
                            child: Container(
                              height: 55.h,
                              width: 140.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                color: AppColors.primaryBlue,
                              ),
                              child: Center(
                                child: CText(
                                  text: 'Next',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
