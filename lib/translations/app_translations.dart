import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // General
      'app_name': 'Samsar',
      'welcome': 'Welcome',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'search': 'Search',
      'filter': 'Filter',
      'sort': 'Sort',
      'refresh': 'Refresh',
      'email': 'Email',
      
      // Settings
      'settings': 'Settings',
      'preferences': 'Preferences',
      'language': 'Language',
      'dark_theme': 'Dark Theme',
      'timezone': 'Timezone',
      'notifications': 'Notifications',
      'privacy': 'Privacy',
      'save_settings': 'Save Settings',
      'settings_saved': 'Settings saved successfully',
      'settings_error': 'Failed to save settings',
      
      // Notifications Settings
      'inbox_messages': 'Inbox Messages',
      'inbox_messages_desc': 'Get notified about new messages',
      'listing_status': 'Listing Status',
      'listing_status_desc': 'Approvals, rejections, etc.',
      'new_login_alerts': 'New Login Alerts',
      'new_login_alerts_desc': 'Be notified of new logins',
      'samsar_weekly': 'Samsar Weekly',
      'samsar_weekly_desc': 'Subscribe to tips, updates, and promotions',
      
      // Language
      'english': 'English',
      'arabic': 'العربية',
      'language_changed': 'Language changed successfully',
      
      // Notifications
      'listing_updates': 'Listing Updates',
      'listing_updates_desc': 'Get notified when your listings are updated',
      'new_messages': 'New Messages',
      'new_messages_desc': 'Get notified about new inbox messages',
      'login_notifications': 'Login Notifications',
      'login_notifications_desc': 'Get notified about account logins',
      'newsletter': 'Newsletter',
      'newsletter_desc': 'Subscribe to our newsletter for updates',
      
      // Privacy
      'profile_visibility': 'Profile Visibility',
      'profile_visibility_desc': 'Control who can see your profile',
      'show_email': 'Show Email',
      'show_email_desc': 'Display your email on your profile',
      'show_online_status': 'Show Online Status',
      'show_online_status_desc': 'Let others see when you\'re online',
      'show_phone': 'Show Phone Number',
      'show_phone_desc': 'Display your phone number on your profile',
      'enable_dms': 'Enable DMs',
      'enable_dms_desc': 'Allow others to send you direct messages',
      
      // Listings
      'my_listings': 'My Listings',
      'create_listing': 'Create Listing',
      'create_first_listing': 'Create Your First Listing',
      'no_listings': 'You haven\'t listed anything yet.',
      'login_to_view': 'Please log in to view your listings',
      'go_to_login': 'Go to Login',
      
      // Profile
      'my_profile': 'My Profile',
      'username': 'Username',
      'phone_no': 'Phone No',
      'bio': 'Bio',
      'street': 'Street',
      'city': 'City',
      
      // Profile & Settings Screen
      'view_edit_profile': 'View / Edit Profile',
      'logout': 'Logout',
      'logout_confirmation': 'Are you sure you want to log out?',
      'ok': 'Ok',
      
      // Default values
      'no_name_available': 'No name available',
      'no_username_available': 'No username is available',
      'no_email_available': 'No email is available',
      'no_phone_available': 'No phone number is available',
      'no_bio_available': 'No bio is available',
      'no_street_available': 'No street is available',
      'no_city_available': 'No city is available',
      
      // Status
      'enabled': 'Enabled',
      'disabled': 'Disabled',
      'public': 'Public',
      'private': 'Private',
    },
    'ar_SA': {
      // General
      'app_name': 'سمسار',
      'welcome': 'مرحباً',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'نجح',
      'cancel': 'إلغاء',
      'confirm': 'تأكيد',
      'save': 'حفظ',
      'delete': 'حذف',
      'edit': 'تعديل',
      'search': 'بحث',
      'filter': 'تصفية',
      'sort': 'ترتيب',
      'refresh': 'تحديث',
      'email': 'البريد الإلكتروني',
      
      // Settings
      'settings': 'الإعدادات',
      'preferences': 'التفضيلات',
      'language': 'اللغة',
      'dark_theme': 'الوضع المظلم',
      'timezone': 'المنطقة الزمنية',
      'notifications': 'الإشعارات',
      'privacy': 'الخصوصية',
      'save_settings': 'حفظ الإعدادات',
      'settings_saved': 'تم حفظ الإعدادات بنجاح',
      'settings_error': 'فشل في حفظ الإعدادات',
      
      // Notifications Settings
      'inbox_messages': 'رسائل الواردة',
      'inbox_messages_desc': 'احصل على إشعارات حول الرسائل الجديدة',
      'listing_status': 'حالة الإعلان',
      'listing_status_desc': 'الموافقات، الرفض، إلخ.',
      'new_login_alerts': 'تنبيهات تسجيل دخول جديد',
      'new_login_alerts_desc': 'احصل على إشعار عند تسجيل دخول جديد',
      'samsar_weekly': 'نشرة سمسار الأسبوعية',
      'samsar_weekly_desc': 'اشترك في النصائح والتحديثات والعروض',
      
      // Privacy Settings
      'show_online': 'إظهار الاتصال',
      'show_online_desc': 'السماح للآخرين برؤية حالة اتصالك',
      'phone_visibility': 'إظهار الهاتف',
      'phone_visibility_desc': 'عرض رقم هاتفك للآخرين',
      'email_visibility': 'إظهار البريد الإلكتروني',
      'email_visibility_desc': 'عرض عنوان بريدك الإلكتروني للآخرين',
      'allow_direct_messaging': 'السماح بالرسائل المباشرة',
      'enable_dms_title': 'تفعيل الرسائل المباشرة',
      
      // Language
      'english': 'English',
      'arabic': 'العربية',
      'language_changed': 'تم تغيير اللغة بنجاح',
      
      // Notifications
      'listing_updates': 'تحديثات الإعلانات',
      'listing_updates_desc': 'احصل على إشعارات عند تحديث إعلاناتك',
      'new_messages': 'رسائل جديدة',
      'new_messages_desc': 'احصل على إشعارات حول الرسائل الجديدة',
      'login_notifications': 'إشعارات تسجيل الدخول',
      'login_notifications_desc': 'احصل على إشعارات حول تسجيل الدخول للحساب',
      'newsletter': 'النشرة الإخبارية',
      'newsletter_desc': 'اشترك في نشرتنا الإخبارية للحصول على التحديثات',
      
      // Privacy
      'profile_visibility': 'رؤية الملف الشخصي',
      'profile_visibility_desc': 'تحكم في من يمكنه رؤية ملفك الشخصي',
      'show_email': 'إظهار البريد الإلكتروني',
      'show_email_desc': 'عرض بريدك الإلكتروني في ملفك الشخصي',
      'show_online_status': 'إظهار حالة الاتصال',
      'show_online_status_desc': 'السماح للآخرين برؤية متى تكون متصلاً',
      'show_phone': 'إظهار رقم الهاتف',
      'show_phone_desc': 'عرض رقم هاتفك في ملفك الشخصي',
      'enable_dms': 'تفعيل الرسائل المباشرة',
      'enable_dms_desc': 'السماح للآخرين بإرسال رسائل مباشرة لك',
      
      // Listings
      'my_listings': 'إعلاناتي',
      'create_listing': 'إنشاء إعلان',
      'create_first_listing': 'أنشئ إعلانك الأول',
      'no_listings': 'لم تقم بإنشاء أي إعلانات بعد.',
      'login_to_view': 'يرجى تسجيل الدخول لعرض إعلاناتك',
      'go_to_login': 'تسجيل الدخول',
      
      // Profile
      'my_profile': 'ملفي الشخصي',
      'username': 'اسم المستخدم',
      'phone_no': 'رقم الهاتف',
      'bio': 'السيرة الذاتية',
      'street': 'الشارع',
      'city': 'المدينة',
      
      // Profile & Settings Screen
      'view_edit_profile': 'عرض / تعديل الملف الشخصي',
      'logout': 'تسجيل خروج',
      'logout_confirmation': 'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
      'ok': 'موافق',
      
      // Default values
      'no_name_available': 'لا يوجد اسم متاح',
      'no_username_available': 'لا يوجد اسم مستخدم متاح',
      'no_email_available': 'لا يوجد بريد إلكتروني متاح',
      'no_phone_available': 'لا يوجد رقم هاتف متاح',
      'no_bio_available': 'لا توجد سيرة ذاتية متاحة',
      'no_street_available': 'لا يوجد شارع متاح',
      'no_city_available': 'لا توجد مدينة متاحة',
      
      // Status
      'enabled': 'مفعل',
      'disabled': 'معطل',
      'public': 'عام',
      'private': 'خاص',
    },
  };
}
