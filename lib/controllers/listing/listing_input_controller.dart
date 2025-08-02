import 'package:get/get.dart';

class ListingInputController extends GetxController {

  //Basic Listing fields
  RxString title = "".obs;
  RxString description = "".obs;
  RxInt price = 0.obs;
  RxString mainCategory = "".obs;
  RxString subCategory = "".obs;
  RxString location = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;
  RxString make = "".obs;
  RxString model = "".obs;
  RxInt year = 0.obs;

  //listing image path
  RxList<String> listingImage = <String>[].obs;

  //advance listing fields
  RxString bodyType = "".obs;
  RxString driveType = "".obs;
  RxString fuelType = "".obs;
  RxString transmissionType = "".obs;
  RxString engineNumber = "".obs;
  RxString engineSize = "".obs;
  RxString horsepower = "".obs;
  RxString torque = "".obs;
  RxString mileage = "".obs;
  RxString serviceHistory = "".obs;
  RxString accidental = "".obs;
  RxString warranty = "".obs;
  RxInt previousOwners = 0.obs;
  RxString condition = "".obs;
  RxString importStatus = "".obs;
  RxString registrationExpiry = "".obs;
  RxString interiorColor = "".obs;
  RxString exteriorColor = "".obs;

  //features and extras
  RxBool airbags = false.obs;
  RxInt noOfAirbags = 0.obs;
  RxBool abs = false.obs;
  RxBool tractionControl = false.obs;
  RxBool laneAssist = false.obs;
  RxBool isBlindSpotMonitor = false.obs;
  RxBool isEmergencyBraking = false.obs;
  RxBool isAdaptiveCruiseControl = false.obs;
  RxBool isLaneDepartureWarning = false.obs;
  RxBool isFatigueWarningSystem = false.obs;
  RxBool isIsofix = false.obs;
  RxBool isEmergencyCallSystem = false.obs;
  RxBool isSpeedLimited = false.obs;
  RxBool isTirePressureMonitoring = false.obs;
  RxBool parkingSensor = false.obs;
  RxBool isRearCamera = false.obs;
  RxBool isThreeSixtyCamera = false.obs;
  RxBool isTrafficSignRecognition = false.obs;

  RxBool cruiseControl = false.obs;
  RxBool automaticHighBeam = false.obs;
  RxBool lightSensor = false.obs;
  RxBool hillStartAssist = false.obs;
  RxBool parkingAssistOrSelfParking = false.obs;

  RxBool isLedHeadlights = false.obs;
  RxBool isAdaptiveHeadlights = false.obs;
  RxBool isFogLights = false.obs;
  RxBool isDaytimeRunningLights = false.obs;
  RxBool isAmbientLighting = false.obs;

  RxBool isBluetooth = false.obs;
  RxBool isAppleCarPlay = false.obs;
  RxBool isAndroidAuto = false.obs;
  RxBool isPremiumSoundSystem = false.obs;
  RxBool isWirelessCharging = false.obs;
  RxBool isUsbPorts = false.obs;
  RxBool isOnboardComputer = false.obs;
  RxBool isDabOrFmRadio = false.obs;
  RxBool isWifiHotspot = false.obs;
  RxBool isIntegratedStreaming = false.obs;
  RxBool isRearSeatEntertainment = false.obs;

  RxBool isCentralLocking = false.obs;
  RxBool isImmobilizer = false.obs;
  RxBool isAlarmSystem = false.obs;
  RxBool isPowerSteering = false.obs;
  RxBool isSummerTires = false.obs;
  



  //to set the basic details
  void setBasicDetails({
    String title = '',
    String description = '',
    int price = 0,
    String mainCategory = '',
    String subCategory = '',
    String location = '',
    String latitude = '',
    String longitude = '',
    String make = '',
    String model = '',
    int year = 0,
  }) {
    this.title.value = title;
    this.description.value = description;
    this.price.value = price;
    this.mainCategory.value = mainCategory;
    this.subCategory.value = subCategory;
    this.location.value = location;
    this.latitude.value = latitude;
    this.longitude.value = longitude;
    this.make.value = make;
    this.model.value = model;
    this.year.value = year; 
  }


  //set images for listing
  void setImages(List<String> listingImage) {
    this.listingImage.assignAll(listingImage);
  }

  //set advance details
  void setAdvanceDetails({
    String bodyType = '',
    String driveType = '',
    String fuelType = '',
    String transmissionType = '',
    String engineNumber = '',
    String engineSize = '',
    String horsepower = '',
    String torque = '',
    String mileage = '',
    String serviceHistory = '',
    String accidental = '',
    String warranty = '',
    String previousOwners = '0',
    String condition = '',
    String importStatus = '',
    String registrationExpiry = '',
    String interiorColor = '',
    String exteriorColor = '',
  }) {
    this.bodyType.value = bodyType;
    this.driveType.value = driveType;
    this.fuelType.value = fuelType;
    this.transmissionType.value = transmissionType;
    this.engineNumber.value = engineNumber;
    this.engineSize.value = engineSize;
    this.horsepower.value = horsepower;
    this.torque.value = torque;
    this.mileage.value = mileage;
    this.serviceHistory.value = serviceHistory;
    this.accidental.value = accidental;
    this.warranty.value = warranty;
    this.previousOwners.value = int.tryParse(previousOwners) ?? 0;
    this.condition.value = condition;
    this.importStatus.value = importStatus;
    this.registrationExpiry.value = registrationExpiry;
    this.interiorColor.value = interiorColor;
    this.exteriorColor.value = exteriorColor;
  }


  //set features and extras
  void featuresAndExtras({
    bool airbags = false,
    int noOfAirbags = 0,
    bool abs = false,
    bool tractionControl = false,
    bool laneAssist = false,
    bool isBlindSpotMonitor = false,
    bool isEmergencyBraking = false,
    bool isAdaptiveCruiseControl = false,
    bool isLaneDepartureWarning = false,
    bool isFatigueWarningSystem = false,
    bool isIsofix = false,
    bool isEmergencyCallSystem = false,
    bool isSpeedLimited = false,
    bool isTirePressureMonitoring = false,
    bool parkingSensor = false,
    bool isRearCamera = false,
    bool isThreeSixtyCamera = false,
    bool isTrafficSignRecognition = false,
    bool cruiseControl = false,
    bool automaticHighBeam = false,
    bool lightSensor = false,
    bool hillStartAssist = false,
    bool parkingAssistOrSelfParking = false,
    bool isLedHeadlights = false,
    bool isAdaptiveHeadlights = false,
    bool isFogLights = false,
    bool isDaytimeRunningLights = false,
    bool isAmbientLighting = false,
    bool isBluetooth = false,
    bool isAppleCarPlay = false,
    bool isAndroidAuto = false,
    bool isPremiumSoundSystem = false,
    bool isWirelessCharging = false,
    bool isUsbPorts = false,
    bool isOnboardComputer = false,
    bool isDabOrFmRadio = false,
    bool isWifiHotspot = false,
    bool isIntegratedStreaming = false,
    bool isRearSeatEntertainment = false,
    bool isCentralLocking = false,
    bool isImmobilizer = false,
    bool isAlarmSystem = false,
    bool isPowerSteering = false,
    bool isSummerTires = false,
  }) {
    this.airbags.value = airbags;
    this.noOfAirbags.value = noOfAirbags;
    this.abs.value = abs;
    this.tractionControl.value = tractionControl;
    this.laneAssist.value = laneAssist;
    this.isBlindSpotMonitor.value = isBlindSpotMonitor;
    this.isEmergencyBraking.value = isEmergencyBraking;
    this.isAdaptiveCruiseControl.value = isAdaptiveCruiseControl;
    this.isLaneDepartureWarning.value = isLaneDepartureWarning;
    this.isFatigueWarningSystem.value = isFatigueWarningSystem;
    this.isIsofix.value = isIsofix;
    this.isEmergencyCallSystem.value = isEmergencyCallSystem;
    this.isSpeedLimited.value = isSpeedLimited;
    this.isTirePressureMonitoring.value = isTirePressureMonitoring;
    this.parkingSensor.value = parkingSensor;
    this.isRearCamera.value = isRearCamera;
    this.isThreeSixtyCamera.value = isThreeSixtyCamera;
    this.isTrafficSignRecognition.value = isTrafficSignRecognition;
    this.cruiseControl.value = cruiseControl;
    this.automaticHighBeam.value = automaticHighBeam;
    this.lightSensor.value = lightSensor;
    this.hillStartAssist.value = hillStartAssist;
    this.parkingAssistOrSelfParking.value = parkingAssistOrSelfParking;
    this.isLedHeadlights.value = isLedHeadlights;
    this.isAdaptiveHeadlights.value = isAdaptiveHeadlights;
    this.isFogLights.value = isFogLights;
    this.isDaytimeRunningLights.value = isDaytimeRunningLights;
    this.isAmbientLighting.value = isAmbientLighting;
    this.isBluetooth.value = isBluetooth;
    this.isAppleCarPlay.value = isAppleCarPlay;
    this.isAndroidAuto.value = isAndroidAuto;
    this.isPremiumSoundSystem.value = isPremiumSoundSystem;
    this.isWirelessCharging.value = isWirelessCharging;
    this.isUsbPorts.value = isUsbPorts;
    this.isOnboardComputer.value = isOnboardComputer;
    this.isDabOrFmRadio.value = isDabOrFmRadio;
    this.isWifiHotspot.value = isWifiHotspot;
    this.isIntegratedStreaming.value = isIntegratedStreaming;
    this.isRearSeatEntertainment.value = isRearSeatEntertainment;
    this.isCentralLocking.value = isCentralLocking;
    this.isImmobilizer.value = isImmobilizer;
    this.isAlarmSystem.value = isAlarmSystem;
    this.isPowerSteering.value = isPowerSteering;
    this.isSummerTires.value = isSummerTires;
  }

}