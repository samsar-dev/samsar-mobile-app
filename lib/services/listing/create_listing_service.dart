import 'dart:io';
import 'package:dio/dio.dart';
import 'package:samsar/constants/api_route_constants.dart';
import 'package:samsar/models/api_error.dart';
import 'package:samsar/models/api_response.dart';
import 'package:samsar/models/listing/create_listing/create_car_listing.dart';
import 'package:http_parser/http_parser.dart';         
import 'package:mime/mime.dart';                     
import 'package:path/path.dart';  


class CreateListingService {
  final _dio = Dio();

  Future<ApiResponse<CreateCarListing>> createCarListingService(
    String accessToken,
    CarModel carDetails,
  ) async {
    try {
      // Prepare multipart form data
      final formData = FormData.fromMap({
        'title': carDetails.title,
        'description': carDetails.description,
        'price': carDetails.price.toString(),
        'mainCategory': carDetails.mainCategory,
        'subCategory': carDetails.subCategory,
        'location': carDetails.location,
        'latitude': carDetails.latitude,
        'longitude': carDetails.longitude,
        'condition': carDetails.condition,
        'listingAction': carDetails.listingAction,
        'vehicles': carDetails.details.toJson(), 
        'listingImage': await Future.wait(
          carDetails.listingImage.map((filePath) async {
            final mimeType = lookupMimeType(filePath) ?? 'image/jpeg';
            return await MultipartFile.fromFile(
              filePath,
              contentType: MediaType.parse(mimeType),
              filename: basename(filePath),
            );
          }),
        ),
      });

      final response = await _dio.post(
        createListingRoute,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final model = CreateCarListing.fromJson(response.data);
        return ApiResponse.success(model);
      } else {
        return ApiResponse.failure(ApiError.fromJson(response.data));
      }
    } on DioException catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        return ApiResponse.failure(ApiError.fromJson(dioError.response!.data));
      }
      return ApiResponse.failure(ApiError(fastifyErrorResponse: null, errorResponse: null));
    } catch (e) {
      return ApiResponse.failure(ApiError(fastifyErrorResponse: null, errorResponse: null));
    }
  }
}



class CarModel {
  final String title;
  final String description;
  final int price;
  final String mainCategory;
  final String subCategory;
  final String location;
  final String latitude;
  final String longitude;
  final String condition;
  final String listingAction;
  final Details details;
  final List<String> listingImage;

  CarModel({
    required this.title,
    required this.description,
    required this.price,
    required this.mainCategory,
    required this.subCategory,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.condition,
    required this.listingAction,
    required this.details,
    required this.listingImage,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      mainCategory: json['mainCategory'],
      subCategory: json['subCategory'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      condition: json['condition'],
      listingAction: json['listingAction'],
      details: Details.fromJson(json['vehicles']),
      listingImage: List<String>.from(json['listingImage'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'condition': condition,
      'listingAction': listingAction,
      'vehicles': details.toJson(),
      'listingImage': listingImage,
    };
  }

  @override
  String toString() {
    return 'CarModel(title: $title, description: $description, price: $price, mainCategory: $mainCategory, subCategory: $subCategory, location: $location, latitude: $latitude, longitude: $longitude, condition: $condition, listingAction: $listingAction, details: $details, listingImage: $listingImage)';
  }
}


class Details {
  final String vehicleType;
  final String make;
  final String model;
  final String year;
  final int mileage;
  final int previousOwners;
  final int horsepower;
  final int torque;
  final int engineSize;
  final String engineNumber;
  final String vin;
  final String transmissionType;
  final String fuelType;
  final String interiorColor;
  final String color;
  final String registrationStatus;
  final String registrationExpiry;
  final List<String> serviceHistory;
  final String warranty;
  final bool accidentFree;
  final bool customsCleared;
  final int airbags;
  final bool abs;
  final bool tractionControl;
  final bool laneAssist;
  final List<String> features;
  final String driveType;
  final String bodyType;
  final String wheelSize;
  final String wheelType;
  final String fuelEfficiency;
  final String emissionClass;
  final String parkingSensor;
  final String parkingBreak;

  Details({
    required this.vehicleType,
    required this.make,
    required this.model,
    required this.year,
    required this.mileage,
    required this.previousOwners,
    required this.horsepower,
    required this.torque,
    required this.engineSize,
    required this.engineNumber,
    required this.vin,
    required this.transmissionType,
    required this.fuelType,
    required this.interiorColor,
    required this.color,
    required this.registrationStatus,
    required this.registrationExpiry,
    required this.serviceHistory,
    required this.warranty,
    required this.accidentFree,
    required this.customsCleared,
    required this.airbags,
    required this.abs,
    required this.tractionControl,
    required this.laneAssist,
    required this.features,
    required this.driveType,
    required this.bodyType,
    required this.wheelSize,
    required this.wheelType,
    required this.fuelEfficiency,
    required this.emissionClass,
    required this.parkingSensor,
    required this.parkingBreak,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      vehicleType: json['vehicleType'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      mileage: json['mileage'],
      previousOwners: json['previousOwners'],
      horsepower: json['horsepower'],
      torque: json['torque'],
      engineSize: json['engineSize'],
      engineNumber: json['engineNumber'],
      vin: json['vin'],
      transmissionType: json['transmissionType'],
      fuelType: json['fuelType'],
      interiorColor: json['interiorColor'],
      color: json['color'],
      registrationStatus: json['registrationStatus'],
      registrationExpiry: json['registrationExpiry'],
      serviceHistory: List<String>.from(json['serviceHistory'] ?? []),
      warranty: json['warranty'],
      accidentFree: json['accidentFree'],
      customsCleared: json['customsCleared'],
      airbags: json['airbags'],
      abs: json['abs'],
      tractionControl: json['tractionControl'],
      laneAssist: json['laneAssist'],
      features: List<String>.from(json['features'] ?? []),
      driveType: json['driveType'],
      bodyType: json['bodyType'],
      wheelSize: json['wheelSize'],
      wheelType: json['wheelType'],
      fuelEfficiency: json['fuelEfficiency'],
      emissionClass: json['emissionClass'],
      parkingSensor: json['parkingSensor'],
      parkingBreak: json['parkingBreak'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleType': vehicleType,
      'make': make,
      'model': model,
      'year': year,
      'mileage': mileage,
      'previousOwners': previousOwners,
      'horsepower': horsepower,
      'torque': torque,
      'engineSize': engineSize,
      'engineNumber': engineNumber,
      'vin': vin,
      'transmissionType': transmissionType,
      'fuelType': fuelType,
      'interiorColor': interiorColor,
      'color': color,
      'registrationStatus': registrationStatus,
      'registrationExpiry': registrationExpiry,
      'serviceHistory': serviceHistory,
      'warranty': warranty,
      'accidentFree': accidentFree,
      'customsCleared': customsCleared,
      'airbags': airbags,
      'abs': abs,
      'tractionControl': tractionControl,
      'laneAssist': laneAssist,
      'features': features,
      'driveType': driveType,
      'bodyType': bodyType,
      'wheelSize': wheelSize,
      'wheelType': wheelType,
      'fuelEfficiency': fuelEfficiency,
      'emissionClass': emissionClass,
      'parkingSensor': parkingSensor,
      'parkingBreak': parkingBreak,
    };
  }

  @override
  String toString() {
    return 'Details(vehicleType: $vehicleType, make: $make, model: $model, year: $year, mileage: $mileage, previousOwners: $previousOwners, horsepower: $horsepower, torque: $torque, engineSize: $engineSize, engineNumber: $engineNumber, vin: $vin, transmissionType: $transmissionType, fuelType: $fuelType, interiorColor: $interiorColor, color: $color, registrationStatus: $registrationStatus, registrationExpiry: $registrationExpiry, serviceHistory: $serviceHistory, warranty: $warranty, accidentFree: $accidentFree, customsCleared: $customsCleared, airbags: $airbags, abs: $abs, tractionControl: $tractionControl, laneAssist: $laneAssist, features: $features, driveType: $driveType, bodyType: $bodyType, wheelSize: $wheelSize, wheelType: $wheelType, fuelEfficiency: $fuelEfficiency, emissionClass: $emissionClass, parkingSensor: $parkingSensor, parkingBreak: $parkingBreak)';
  }
}
