class IndividualListingDetailModel {
    IndividualListingDetailModel({
        required this.success,
        required this.data,
        required this.status,
    });

    final bool? success;
    final Data? data;
    final int? status;

    factory IndividualListingDetailModel.fromJson(Map<String, dynamic> json){ 
        return IndividualListingDetailModel(
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "status": status,
    };

    @override
    String toString(){
        return "$success, $data, $status, ";
    }
}

class Data {
    Data({
        required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.category,
        required this.location,
        required this.images,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
        required this.views,
        required this.details,
        required this.listingAction,
        required this.status,
        required this.seller,
        required this.savedBy,
    });

    final String? id;
    final String? title;
    final String? description;
    final int? price;
    final Category? category;
    final String? location;
    final List<String> images;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? userId;
    final int? views;
    final Details? details;
    final String? listingAction;
    final String? status;
    final Seller? seller;
    final List<dynamic> savedBy;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            price: json["price"],
            category: json["category"] == null ? null : Category.fromJson(json["category"]),
            location: json["location"],
            images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            userId: json["userId"],
            views: json["views"],
            details: json["details"] == null ? null : Details.fromJson(json["details"]),
            listingAction: json["listingAction"],
            status: json["status"],
            seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
            savedBy: json["savedBy"] == null ? [] : List<dynamic>.from(json["savedBy"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "category": category?.toJson(),
        "location": location,
        "images": images.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "views": views,
        "details": details?.toJson(),
        "listingAction": listingAction,
        "status": status,
        "seller": seller?.toJson(),
        "savedBy": savedBy.map((x) => x).toList(),
    };

    @override
    String toString(){
        return "$id, $title, $description, $price, $category, $location, $images, $createdAt, $updatedAt, $userId, $views, $details, $listingAction, $status, $seller, $savedBy, ";
    }
}

class Category {
    Category({
        required this.mainCategory,
        required this.subCategory,
    });

    final String? mainCategory;
    final String? subCategory;

    factory Category.fromJson(Map<String, dynamic> json){ 
        return Category(
            mainCategory: json["mainCategory"],
            subCategory: json["subCategory"],
        );
    }

    Map<String, dynamic> toJson() => {
        "mainCategory": mainCategory,
        "subCategory": subCategory,
    };

    @override
    String toString(){
        return "$mainCategory, $subCategory, ";
    }
}

class Details {
    Details({
        required this.vehicles,
    });

    final Vehicles? vehicles;

    factory Details.fromJson(Map<String, dynamic> json){ 
        return Details(
            vehicles: json["vehicles"] == null ? null : Vehicles.fromJson(json["vehicles"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "vehicles": vehicles?.toJson(),
    };

    @override
    String toString(){
        return "$vehicles, ";
    }
}

class Vehicles {
    Vehicles({
        required this.vehicleType,
        required this.make,
        required this.model,
        required this.year,
        required this.mileage,
        required this.fuelType,
        required this.transmissionType,
        required this.color,
        required this.condition,
        required this.interiorColor,
        required this.warranty,
        required this.previousOwners,
        required this.engineSize,
        required this.accidentFree,
        required this.adaptiveCruiseControl,
        required this.additionalNotes,
        required this.automaticEmergencyBraking,
        required this.bodyStyle,
        required this.cruiseControl,
        required this.curtainAirbags,
        required this.customsCleared,
        required this.driveType,
        required this.frontAirbags,
        required this.horsepower,
        required this.importStatus,
        required this.kneeAirbags,
        required this.laneDepartureWarning,
        required this.laneKeepAssist,
        required this.navigationSystem,
        required this.roofType,
        required this.serviceHistoryDetails,
        required this.sideAirbags,
        required this.torque,
        required this.warrantyPeriod,
        required this.serviceHistory,
        required this.registrationExpiry,
        required this.engineNumber,
    });

    final String? vehicleType;
    final String? make;
    final String? model;
    final int? year;
    final int? mileage;
    final String? fuelType;
    final String? transmissionType;
    final String? color;
    final String? condition;
    final String? interiorColor;
    final String? warranty;
    final int? previousOwners;
    final String? engineSize;
    final bool? accidentFree;
    final bool? adaptiveCruiseControl;
    final String? additionalNotes;
    final bool? automaticEmergencyBraking;
    final String? bodyStyle;
    final bool? cruiseControl;
    final bool? curtainAirbags;
    final bool? customsCleared;
    final String? driveType;
    final bool? frontAirbags;
    final int? horsepower;
    final String? importStatus;
    final bool? kneeAirbags;
    final bool? laneDepartureWarning;
    final bool? laneKeepAssist;
    final String? navigationSystem;
    final String? roofType;
    final String? serviceHistoryDetails;
    final bool? sideAirbags;
    final int? torque;
    final String? warrantyPeriod;
    final List<String> serviceHistory;
    final String? registrationExpiry;
    final String? engineNumber;

    factory Vehicles.fromJson(Map<String, dynamic> json){ 
        return Vehicles(
            vehicleType: json["vehicleType"],
            make: json["make"],
            model: json["model"],
            year: json["year"],
            mileage: json["mileage"],
            fuelType: json["fuelType"],
            transmissionType: json["transmissionType"],
            color: json["color"],
            condition: json["condition"],
            interiorColor: json["interiorColor"],
            warranty: json["warranty"],
            previousOwners: json["previousOwners"],
            engineSize: json["engineSize"],
            accidentFree: json["accidentFree"],
            adaptiveCruiseControl: json["adaptiveCruiseControl"],
            additionalNotes: json["additionalNotes"],
            automaticEmergencyBraking: json["automaticEmergencyBraking"],
            bodyStyle: json["bodyStyle"],
            cruiseControl: json["cruiseControl"],
            curtainAirbags: json["curtainAirbags"],
            customsCleared: json["customsCleared"],
            driveType: json["driveType"],
            frontAirbags: json["frontAirbags"],
            horsepower: json["horsepower"],
            importStatus: json["importStatus"],
            kneeAirbags: json["kneeAirbags"],
            laneDepartureWarning: json["laneDepartureWarning"],
            laneKeepAssist: json["laneKeepAssist"],
            navigationSystem: json["navigationSystem"],
            roofType: json["roofType"],
            serviceHistoryDetails: json["serviceHistoryDetails"],
            sideAirbags: json["sideAirbags"],
            torque: json["torque"],
            warrantyPeriod: json["warrantyPeriod"],
            serviceHistory: json["serviceHistory"] == null ? [] : List<String>.from(json["serviceHistory"]!.map((x) => x)),
            registrationExpiry: json["registrationExpiry"],
            engineNumber: json["engineNumber"],
        );
    }

    Map<String, dynamic> toJson() => {
        "vehicleType": vehicleType,
        "make": make,
        "model": model,
        "year": year,
        "mileage": mileage,
        "fuelType": fuelType,
        "transmissionType": transmissionType,
        "color": color,
        "condition": condition,
        "interiorColor": interiorColor,
        "warranty": warranty,
        "previousOwners": previousOwners,
        "engineSize": engineSize,
        "accidentFree": accidentFree,
        "adaptiveCruiseControl": adaptiveCruiseControl,
        "additionalNotes": additionalNotes,
        "automaticEmergencyBraking": automaticEmergencyBraking,
        "bodyStyle": bodyStyle,
        "cruiseControl": cruiseControl,
        "curtainAirbags": curtainAirbags,
        "customsCleared": customsCleared,
        "driveType": driveType,
        "frontAirbags": frontAirbags,
        "horsepower": horsepower,
        "importStatus": importStatus,
        "kneeAirbags": kneeAirbags,
        "laneDepartureWarning": laneDepartureWarning,
        "laneKeepAssist": laneKeepAssist,
        "navigationSystem": navigationSystem,
        "roofType": roofType,
        "serviceHistoryDetails": serviceHistoryDetails,
        "sideAirbags": sideAirbags,
        "torque": torque,
        "warrantyPeriod": warrantyPeriod,
        "serviceHistory": serviceHistory.map((x) => x).toList(),
        "registrationExpiry": registrationExpiry,
        "engineNumber": engineNumber,
    };

    @override
    String toString(){
        return "$vehicleType, $make, $model, $year, $mileage, $fuelType, $transmissionType, $color, $condition, $interiorColor, $warranty, $previousOwners, $engineSize, $accidentFree, $adaptiveCruiseControl, $additionalNotes, $automaticEmergencyBraking, $bodyStyle, $cruiseControl, $curtainAirbags, $customsCleared, $driveType, $frontAirbags, $horsepower, $importStatus, $kneeAirbags, $laneDepartureWarning, $laneKeepAssist, $navigationSystem, $roofType, $serviceHistoryDetails, $sideAirbags, $torque, $warrantyPeriod, $serviceHistory, $registrationExpiry, $engineNumber, ";
    }
}

class Seller {
    Seller({
        required this.id,
        required this.username,
        required this.profilePicture,
        required this.allowMessaging,
        required this.privateProfile,
    });

    final String? id;
    final String? username;
    final String? profilePicture;
    final bool? allowMessaging;
    final bool? privateProfile;

    factory Seller.fromJson(Map<String, dynamic> json){ 
        return Seller(
            id: json["id"],
            username: json["username"],
            profilePicture: json["profilePicture"],
            allowMessaging: json["allowMessaging"],
            privateProfile: json["privateProfile"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profilePicture": profilePicture,
        "allowMessaging": allowMessaging,
        "privateProfile": privateProfile,
    };

    @override
    String toString(){
        return "$id, $username, $profilePicture, $allowMessaging, $privateProfile, ";
    }
}
