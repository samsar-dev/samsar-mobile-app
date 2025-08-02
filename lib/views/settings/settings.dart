import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsar/constants/color_constants.dart';
import 'package:samsar/controllers/features/settings_controller.dart';
import 'package:samsar/controllers/features/theme_controller.dart';
import 'package:samsar/widgets/app_button/app_button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';
  String selectedTimezone = 'UTC +5:30 (IST)';

  final List<String> languages = ['English', 'Arabic'];
  final List<String> timezones = [
    'UTC -8:00 (PST)',
    'UTC -5:00 (EST)',
    'UTC +0:00 (GMT)',
    'UTC +5:30 (IST)',
    'UTC +8:00 (CST)',
  ];

  final List<String> visibilityOptions = ['Public', 'Private'];
  final SettingsController _settingsController = Get.put(SettingsController());
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    _settingsController.getSettingsController();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(color: blackColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_settingsController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel(screenWidth, screenHeight, "Preferences"),
                  SizedBox(height: screenHeight * 0.02),

                  settingCard(
                    screenWidth,
                    screenHeight,
                    title: "Language",
                    child: customDropdown(
                      selectedValue: selectedLanguage,
                      items: languages,
                      onChanged: (val) => setState(() => selectedLanguage = val),
                    ),
                  ),

                  settingCard(
                    screenWidth,
                    screenHeight,
                    title: "Dark Theme",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _themeController.isDarkMode.value ? "Enabled" : "Disabled",
                          style: TextStyle(
                            fontSize: 16,
                             color: _themeController.isDarkMode.value ? Colors.white : Colors.grey[800],
                          ),
                        ),
                        Switch.adaptive(
                          value: _themeController.isDarkMode.value,
                          activeColor: blueColor,
                          onChanged: (val) => _themeController.toggleTheme(),
                        ),
                      ],
                    ),
                  ),

                  settingCard(
                    screenWidth,
                    screenHeight,
                    title: "Timezone",
                    child: customDropdown(
                      selectedValue: selectedTimezone,
                      items: timezones,
                      onChanged: (val) => setState(() => selectedTimezone = val),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),
                  buildLabel(screenWidth, screenHeight, "Notifications"),
                  SizedBox(height: screenHeight * 0.01),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Inbox Messages",
                        child: customCheckbox(
                          title: "Inbox Messages",
                          subtitle: "Get notified about new messages",
                          value: _settingsController.messageNotifications.value,
                          onChanged: (val) => _settingsController.messageNotifications.value = val,
                        ),
                      )),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Listing Updates",
                        child: customCheckbox(
                          title: "Listing Status",
                          subtitle: "Approvals, rejections, etc.",
                          value: _settingsController.listingNotifications.value,
                          onChanged: (val) => _settingsController.listingNotifications.value = val,
                        ),
                      )),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Login Notifications",
                        child: customCheckbox(
                          title: "New Login Alerts",
                          subtitle: "Be notified of new logins",
                          value: _settingsController.loginNotifications.value,
                          onChanged: (val) => _settingsController.loginNotifications.value = val,
                        ),
                      )),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Newsletter",
                        child: customCheckbox(
                          title: "Samsar Weekly",
                          subtitle: "Subscribe to tips, updates, and promotions",
                          value: _settingsController.newsletterSubscribed.value,
                          onChanged: (val) => _settingsController.newsletterSubscribed.value = val,
                        ),
                      )),

                  SizedBox(height: screenHeight * 0.03),
                  buildLabel(screenWidth, screenHeight, "Privacy"),
                  SizedBox(height: screenHeight * 0.01),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Profile Visibility",
                        child: customDropdown(
                          selectedValue: _settingsController.privateProfile.value ? "Private" : "Public",
                          items: visibilityOptions,
                          onChanged: (val) =>
                              _settingsController.privateProfile.value = val == "Private",
                        ),
                      )),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Show Online Status",
                        child: customCheckbox(
                          title: "Show Online",
                          subtitle: "Allow others to see your online status",
                          value: _settingsController.showOnlineStatus.value,
                          onChanged: (val) => _settingsController.showOnlineStatus.value = val,
                        ),
                      )),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Show Phone Number",
                        child: customCheckbox(
                          title: "Phone Visibility",
                          subtitle: "Display your phone number to others",
                          value: _settingsController.showPhoneNumber.value,
                          onChanged: (val) => _settingsController.showPhoneNumber.value = val,
                        ),
                      )),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Show Email",
                        child: customCheckbox(
                          title: "Email Visibility",
                          subtitle: "Display your email address to others",
                          value: _settingsController.showEmail.value,
                          onChanged: (val) => _settingsController.showEmail.value = val,
                        ),
                      )),

                  Obx(() => settingCard(
                        screenWidth,
                        screenHeight,
                        title: "Allow Direct Messaging",
                        child: customCheckbox(
                          title: "Enable DMs",
                          subtitle: "Allow others to send you direct messages",
                          value: _settingsController.allowMessaging.value,
                          onChanged: (val) => _settingsController.allowMessaging.value = val,
                        ),
                      )),

                  SizedBox(height: screenHeight * 0.03),

                  Center(
                    child: AppButton(
                      widthSize: 0.65,
                      heightSize: 0.06,
                      text: "Save Settings",
                      buttonColor: blueColor,
                      textColor: whiteColor,
                      onPressed: () => _settingsController.updateSettingsController(),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildLabel(double screenWidth, double screenHeight, String title) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.01),
      child: Text(
        title,
        style: TextStyle(
          color: blueColor,
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget settingCard(double screenWidth, double screenHeight,
      {required String title, required Widget child}) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget customDropdown({
    required String selectedValue,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedValue,
          borderRadius: BorderRadius.circular(12),
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(Icons.language, color: Colors.grey.shade600, size: 20),
                  const SizedBox(width: 8),
                  Text(item),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) => onChanged(value!),
        ),
      ),
    );
  }

  Widget customCheckbox({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: blueColor,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (val) => onChanged(val!),
    );
  }
}
