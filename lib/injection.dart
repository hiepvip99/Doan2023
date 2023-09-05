import 'dart:async';
// import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service/netcommon/dio_service.dart';

class Injection {
  Injection._();

  static final Injection instance = Injection._();

  Future<void> injection() async {
    await _injectService();
    await Future.wait([
      // _injectRealm(),
      _injectSharedPreferences(),
      // _getAppVersion(),
      // _initStash(),
      // _injectionLogger(),
    ]);
  }

  Future<void> _injectSharedPreferences() async {
    // SharePreferenceProvider.prefs =
    await Get.putAsync(() => SharedPreferences.getInstance());
  }

  Future<void> _injectService() async {
    print('Start _injectService:${DateTime.now()}');
    // Get.lazyPut(() => UserServiceImpl(), fenix: true);
    // Get.lazyPut(() => FreeItemServiceImpl(), fenix: true);
    // Get.lazyPut(() => InformationServiceImpl(), fenix: true);
    // Get.lazyPut(() => ShelterServiceImpl(), fenix: true);
    // Get.lazyPut(() => ShelterDataServiceImpl(), fenix: true);
    // Get.lazyPut(() => MunicipalServiceImpl(), fenix: true);
    // Get.lazyPut(() => MunicipalCodeServiceImpl(), fenix: true);
    Get.lazyPut(() => DioService(), fenix: true);
    // Get.lazyPut(() => ChatServiceImpl(), fenix: true);
    // Get.lazyPut(() => EvacuationServiceImpl(), fenix: true);
    // Get.lazyPut(() => StaffServiceImpl(), fenix: true);
    // Get.lazyPut(() => DataExportServiceImpl(), fenix: true);
    // Get.lazyPut(() => NativeProviderServiceImpl(), fenix: true);
    // Get.lazyPut(() => InventoryServiceImpl(), fenix: true);
    // Get.lazyPut(() => CommonServiceImpl(), fenix: true);
    // Get.lazyPut(() => EvacueeSearchServiceImpl(), fenix: true);
    // Get.lazyPut(() => EvacueesSettingImpl(), fenix: true);
    // Get.lazyPut(() => SettingShelterSituationServiceImpl(), fenix: true);
    // Get.lazyPut(() => SettingGoodsMasterServiceImpl(), fenix: true);
    // Get.lazyPut(() => SettingCustomReceptionistServiceImpl(), fenix: true);
    // Get.lazyPut(() => SettingContactImpl(), fenix: true);
    // Get.lazyPut(() => ShelterCheckListServiceImpl(), fenix: true);
  }
}
