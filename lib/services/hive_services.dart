// import 'dart:developer';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

// import '../models/triger_model.dart';

// class HiveService {
//   // static String localWishList = 'WsihListBox';
//   // static String localCart = 'CartBox';

//   // static Box<TrigerModel>? locaWishListBox;
//   // // static Box<CartModel>? locaCartBox;

//   // static Future hiveinitialize() async {
//   //   Directory directory = await getApplicationDocumentsDirectory();
//   //   Hive
//   //     ..init(directory.path)
//   //     ..registerAdapter(TrigerModelAdapter());
//   //   // ..registerAdapter(CartModelAdapter());
//   //   locaWishListBox = await Hive.openBox<TrigerModel>(localWishList);
//   // }

//   static getFromHive({required String table, required String key}) async {
//     var box = Hive.box(table);
//     var list = await box.get(key);
//     log(' list  === ${list}');
//     return list;
//   }

//   static addToHive({required String table, required String key, dynamic data}) {
//     String response = "";
//     // adding to hive DB.
//     var box = Hive.box(table);
//     box.put(key, data).then((value) {
//       print("Cart added to hive");
//     }).onError((error, stackTrace) {
//       // print("Error in adding cart to hive");
//       // print(error);
//       // print(stackTrace);
//       response = error.toString();
//     });
//     return response;
//   }

//   static deleteFromHive(
//       {required String table, required String key, required int index}) async {
//     var box = Hive.box(table);
//     List list = await box.get(key);
//     list.removeAt(index);
//     box.put(key, list);
//   }

//   // Future<List<TrigerModel>> getWishlist() async {
//   //   List<TrigerModel> data = [];
//   //   try {
//   //     Box<TrigerModel> box =
//   //         await Hive.openBox<TrigerModel>(HiveService.localWishList);
//   //     data = box.values.toList();
//   //     log("data-----------: $data");
//   //     if (data.isNotEmpty) {
//   //       log(data.toString());
//   //     }
//   //     return data;
//   //   } catch (error) {
//   //     log("Error-log :$error");
//   //     return [];
//   //   }
//   // }

//   // Future<List<TrigerModel>> addWishlist(TrigerModel cartData) async {
//   //   // add new data in hive
//   //   try {
//   //     Box<TrigerModel> box =
//   //         await Hive.openBox<TrigerModel>(HiveService.localWishList);
//   //     box.add(cartData);
//   //     List data = box.values.toList();
//   //     log("Wishlist added Successfully = ${data.length}");

//   //     // localWishList = [...state, cartData];
//   //   } catch (error) {
//   //     log("Error-log :$error");
//   //   }
//   //   return getWishlist();
//   // }

//   // Future<List<TrigerModel>> updateWishlist(
//   //     TrigerModel cartData, int index) async {
//   //   // add new data in temp model list
//   //   try {
//   //     Box<TrigerModel> box =
//   //         await Hive.openBox<TrigerModel>(HiveService.localWishList);
//   //     box.put(index, cartData);
//   //     // List<TrigerModel> tempWishList = state;

//   //     // tempWishList[index] = cartData;
//   //     print("Wishlist Updated Successfully");
//   //     // state = [...state];
//   //   } catch (error) {
//   //     print("Error-log :$error");
//   //   }
//   //   return getWishlist();
//   // }

//   // Future<List<TrigerModel>> deleteWishlist(int index) async {
//   //   try {
//   //     Box<TrigerModel> box =
//   //         await Hive.openBox<TrigerModel>(HiveService.localWishList);
//   //     // int index = box.values.toList().indexWhere((element) {
//   //     //   return element.typeId == productID;
//   //     // });
//   //     box.deleteAt(index);

//   //     // List<TrigerModel> tempCartList = state;
//   //     // tempCartList.removeAt(index);
//   //     log("Wishlist Deleted Successfully");
//   //     // state = [...state];
//   //   } catch (error) {
//   //     log("Error-log :$error");
//   //   }
//   //   return getWishlist();
//   // }
// }
