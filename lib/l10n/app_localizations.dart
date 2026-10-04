import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ms'),
    Locale('vi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In vi, this message translates to:
  /// **'Salam Vietnam'**
  String get appTitle;

  /// No description provided for @navExplore.
  ///
  /// In vi, this message translates to:
  /// **'Khám phá'**
  String get navExplore;

  /// No description provided for @navMap.
  ///
  /// In vi, this message translates to:
  /// **'Bản đồ'**
  String get navMap;

  /// No description provided for @navSaved.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu'**
  String get navSaved;

  /// No description provided for @navSettings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get navSettings;

  /// No description provided for @searchPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Tìm nhà hàng Halal, Thánh đường, Văn hóa Chăm...'**
  String get searchPlaceholder;

  /// No description provided for @categoryAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get categoryAll;

  /// No description provided for @categoryHalalFood.
  ///
  /// In vi, this message translates to:
  /// **'Ẩm thực Halal'**
  String get categoryHalalFood;

  /// No description provided for @categoryMosque.
  ///
  /// In vi, this message translates to:
  /// **'Thánh đường'**
  String get categoryMosque;

  /// No description provided for @categoryAccommodation.
  ///
  /// In vi, this message translates to:
  /// **'Lưu trú'**
  String get categoryAccommodation;

  /// No description provided for @categoryChamCulture.
  ///
  /// In vi, this message translates to:
  /// **'Văn hóa Chăm'**
  String get categoryChamCulture;

  /// No description provided for @halalStatusVerified.
  ///
  /// In vi, this message translates to:
  /// **'Halal đã xác minh'**
  String get halalStatusVerified;

  /// No description provided for @halalStatusSelfDeclared.
  ///
  /// In vi, this message translates to:
  /// **'Tự công bố Halal'**
  String get halalStatusSelfDeclared;

  /// No description provided for @halalStatusUnverified.
  ///
  /// In vi, this message translates to:
  /// **'Chưa xác minh Halal'**
  String get halalStatusUnverified;

  /// No description provided for @halalStatusExpired.
  ///
  /// In vi, this message translates to:
  /// **'Chứng nhận hết hạn'**
  String get halalStatusExpired;

  /// No description provided for @halalStatusDisputed.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái tranh chấp'**
  String get halalStatusDisputed;

  /// No description provided for @verificationFieldVerified.
  ///
  /// In vi, this message translates to:
  /// **'Xác minh thực địa'**
  String get verificationFieldVerified;

  /// No description provided for @verificationSourceConfirmed.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận nguồn'**
  String get verificationSourceConfirmed;

  /// No description provided for @verificationCommunityConfirmed.
  ///
  /// In vi, this message translates to:
  /// **'Cộng đồng xác nhận'**
  String get verificationCommunityConfirmed;

  /// No description provided for @verificationUnverified.
  ///
  /// In vi, this message translates to:
  /// **'Chưa xác minh'**
  String get verificationUnverified;

  /// No description provided for @sectionFeatured.
  ///
  /// In vi, this message translates to:
  /// **'Địa điểm nổi bật'**
  String get sectionFeatured;

  /// No description provided for @sectionRecentlyUpdated.
  ///
  /// In vi, this message translates to:
  /// **'Mới cập nhật'**
  String get sectionRecentlyUpdated;

  /// No description provided for @sectionExploreRegions.
  ///
  /// In vi, this message translates to:
  /// **'Duyệt theo Tỉnh/Thành'**
  String get sectionExploreRegions;

  /// No description provided for @sectionChamHighlights.
  ///
  /// In vi, this message translates to:
  /// **'Di sản & Văn hóa Chăm'**
  String get sectionChamHighlights;

  /// No description provided for @sampleDataNotice.
  ///
  /// In vi, this message translates to:
  /// **'Dữ liệu mẫu phục vụ thử nghiệm giao diện'**
  String get sampleDataNotice;

  /// No description provided for @viewAll.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get viewAll;

  /// No description provided for @details.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết'**
  String get details;

  /// No description provided for @directions.
  ///
  /// In vi, this message translates to:
  /// **'Chỉ đường'**
  String get directions;

  /// No description provided for @language.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngôn ngữ'**
  String get selectLanguage;

  /// No description provided for @vietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Anh'**
  String get english;

  /// No description provided for @malay.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Mã Lai'**
  String get malay;

  /// No description provided for @settingsTheme.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện'**
  String get settingsTheme;

  /// No description provided for @settingsAbout.
  ///
  /// In vi, this message translates to:
  /// **'Về Salam Vietnam'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản 1.0.0 (MVP)'**
  String get settingsVersion;

  /// No description provided for @savedPlacesEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có địa điểm nào được lưu'**
  String get savedPlacesEmpty;

  /// No description provided for @mapPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Bản đồ tương tác đang được phát triển'**
  String get mapPlaceholder;

  /// No description provided for @filterTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bộ lọc tìm kiếm'**
  String get filterTitle;

  /// No description provided for @filterApply.
  ///
  /// In vi, this message translates to:
  /// **'Áp dụng'**
  String get filterApply;

  /// No description provided for @filterReset.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại'**
  String get filterReset;

  /// No description provided for @filterProvince.
  ///
  /// In vi, this message translates to:
  /// **'Tỉnh / Thành phố'**
  String get filterProvince;

  /// No description provided for @filterHalalStatus.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái Halal'**
  String get filterHalalStatus;

  /// No description provided for @favoriteAdded.
  ///
  /// In vi, this message translates to:
  /// **'Đã thêm vào danh sách yêu thích'**
  String get favoriteAdded;

  /// No description provided for @favoriteRemoved.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa khỏi danh sách yêu thích'**
  String get favoriteRemoved;

  /// No description provided for @submitPlaceTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đóng góp địa điểm mới'**
  String get submitPlaceTitle;

  /// No description provided for @submitPlaceSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Gửi thông tin địa điểm Halal hoặc di sản Chăm cho ban quản trị duyệt'**
  String get submitPlaceSubtitle;

  /// No description provided for @submitFormName.
  ///
  /// In vi, this message translates to:
  /// **'Tên địa điểm'**
  String get submitFormName;

  /// No description provided for @submitFormCategory.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục'**
  String get submitFormCategory;

  /// No description provided for @submitFormAddress.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ'**
  String get submitFormAddress;

  /// No description provided for @submitFormProvince.
  ///
  /// In vi, this message translates to:
  /// **'Tỉnh / Thành phố'**
  String get submitFormProvince;

  /// No description provided for @submitFormPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại liên hệ (nếu có)'**
  String get submitFormPhone;

  /// No description provided for @submitFormNotes.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú & Căn cứ Halal (nếu có)'**
  String get submitFormNotes;

  /// No description provided for @submitButton.
  ///
  /// In vi, this message translates to:
  /// **'Gửi đóng góp'**
  String get submitButton;

  /// No description provided for @submitSuccessTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đóng góp thành công'**
  String get submitSuccessTitle;

  /// No description provided for @submitSuccessMessage.
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn bạn! Thông tin đã được gửi và ở trạng thái CHỜ DUYỆT (pending) bởi moderator.'**
  String get submitSuccessMessage;

  /// No description provided for @reportIssueTitle.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo thông tin sai lệch'**
  String get reportIssueTitle;

  /// No description provided for @reportIssueButton.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo thông tin'**
  String get reportIssueButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ms', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ms':
      return AppLocalizationsMs();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
