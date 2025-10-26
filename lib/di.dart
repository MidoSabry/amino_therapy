
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/data/constants/shared_preferences_constants.dart';
import 'core/services/base_network/client/dio_client.dart';
import 'core/services/base_network/network_lost/network_info.dart';
import 'core/services/device_info_manager.dart';
import 'core/services/flavorizer/flavors_managment.dart';
import 'core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'core/services/log/app_log.dart';
import 'core/services/security_handler/security_helper.dart';



final GetIt getIt = GetIt.instance;

class AppDependencies {
  Future<void> clearSecureStorageOnFreshInstall() async {
    // Check if app was already launched before
    bool isFirstLaunch = SharedPreferenceService().getBool(
      SharPrefConstants.isFirstTimeToOpenAppKey,
      defaultValue: true,
    );

    AppLog.printValueAndTitle('isFirstOpen', isFirstLaunch);
    if (isFirstLaunch) {
      // Fresh install detected, clear secure storage
      await SecureStorageService().clear();

      // Mark that app has launched before
      await SharedPreferenceService().setBool(
        SharPrefConstants.isFirstTimeToOpenAppKey,
        false,
      );
    }
  }

  Future<void> initialize() async {
    // Future.delayed(Duration(seconds: 3,), () {
    //     FlutterNativeSplash.remove();
    //   },
    // );
    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await Future.wait([
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      // Init localization
      EasyLocalization.ensureInitialized(),
      // Init Firebase
      // Firebase.initializeApp(),

      // Load dotenv file
      dotenv.load(fileName: 'api_end_points.env'),

      // Init shared preference
      SharedPreferenceService().init(),
      // Init device info
      DeviceInfoManager.instance.init(),
    ]);

    // clear secure storage
    // await clearSecureStorageOnFreshInstall();

    // Init flavors must be init but after load dotenv file
    // so we can use base url form the file
    FlavorsManagement.instance.init();

    // Run security checks
    // await runSecurityChecks();

    //bloc
    

    // Use cases
    // getIt.registerLazySingleton<LoginUseCase>(
    //   () => LoginUseCase(loginRepository: getIt()),
    // );
    // getIt.registerLazySingleton<HomeUseCase>(
    //   () => HomeUseCase(homeRepository: getIt()),
    // );

    // getIt.registerLazySingleton<LogoutUseCase>(
    //   () => LogoutUseCase(logoutRepository: getIt()),
    // );

    // getIt.registerLazySingleton<PersonalInfoUseCase>(
    //   () => PersonalInfoUseCase(personalInfoRepository: getIt()),
    // );
    // getIt.registerLazySingleton<BusinessTripsUsecase>(
    //   () => BusinessTripsUsecase(businessTripsRepository: getIt()),
    // );
    // getIt.registerLazySingleton<LetterDefinitionUsecase>(
    //   () => LetterDefinitionUsecase(letterDefinitionRepository: getIt()),
    // );

    // getIt.registerLazySingleton<ResignationUsecase>(
    //   () => ResignationUsecase(resignationRepository: getIt()),
    // );
    // getIt.registerLazySingleton<LookupsUseCase>(
    //   () => LookupsUseCase(lookupsRepository: getIt()),
    // );

    // getIt.registerLazySingleton<ContractUsecase>(
    //   () => ContractUsecase(contractRepository: getIt()),
    // );

    // getIt.registerLazySingleton<PayslipUseCase>(
    //   () => PayslipUseCase(payslipRepository: getIt()),
    // );
    // getIt.registerLazySingleton<HolidayProcessUseCase>(
    //   () => HolidayProcessUseCase(holidayProcessRepository: getIt()),
    // );
    // getIt.registerLazySingleton<OvertimeUsecase>(
    //   () => OvertimeUsecase(overTimeRepository: getIt()),
    // );

    // getIt.registerLazySingleton<LeavesUsecase>(
    //   () => LeavesUsecase(leavesRepository: getIt()),
    // );
    // getIt.registerLazySingleton<DownloadFileUseCase>(
    //   () => DownloadFileUseCase(downloadFileRepository: getIt()),
    // );

    // getIt.registerLazySingleton<TicketUsecase>(
    //   () => TicketUsecase(ticketRepository: getIt()),
    // );

    // getIt.registerLazySingleton<AssignmentUsecase>(
    //   () => AssignmentUsecase(assignmentRepository: getIt()),
    // );

    // getIt.registerLazySingleton<ExitReentryUsecase>(
    //   () => ExitReentryUsecase(exitReentryRepository: getIt()),
    // );

    //  getIt.registerLazySingleton<ExitReentryFamilyUsecase>(
    //   () => ExitReentryFamilyUsecase(exitReentryFamilyRepository: getIt()),
    // );

    // getIt.registerLazySingleton<ExpenseUsecase>(
    //   () => ExpenseUsecase(expenseRepository: getIt()),
    // );
    // getIt.registerLazySingleton<AttendanceUsecase>(
    //   () => AttendanceUsecase(attendanceRepository: getIt()),
    // );
    // getIt.registerLazySingleton<AttendanceInOutUseCase>(
    //   () => AttendanceInOutUseCase(attendanceInOutRepository: getIt()),
    // );
    // // Repositories
    // getIt.registerLazySingleton<LookupsRepository>(
    //   () => LookupsRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );
    // getIt.registerLazySingleton<LoginRepository>(
    //   () => LoginRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );
    // getIt.registerLazySingleton<HomeRepository>(
    //   () => HomeRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<LogoutRepository>(
    //   () => LogoutRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<PersonalInfoRepository>(
    //   () =>
    //       PersonalInfoRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );
    // getIt.registerLazySingleton<BusinessTripsRepository>(
    //   () => BusinessTripsRepositoryImpl(
    //     networkInfo: getIt(),
    //     remoteData: getIt(),
    //   ),
    // );
    // getIt.registerLazySingleton<LetterDefinitionRepository>(
    //   () => LetterDefinitionRepositoryImpl(
    //     networkInfo: getIt(),
    //     remoteData: getIt(),
    //   ),
    // );
    // getIt.registerLazySingleton<ResignationRepository>(
    //   () =>
    //       ResignationRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );
    // getIt.registerLazySingleton<PayslipRepository>(
    //   () => PayslipRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<ContractRepository>(
    //   () => ContractRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );
    // getIt.registerLazySingleton<HolidayProcessRepository>(
    //   () => HolidayProcessRepositoryImpl(
    //     networkInfo: getIt(),
    //     remoteData: getIt(),
    //   ),
    // );
    // getIt.registerLazySingleton<AttendanceInOutRepository>(
    //   () => AttendanceInOutRepositoryImpl(
    //     networkInfo: getIt(),
    //     remoteData: getIt(),
    //   ),
    // );
    // getIt.registerLazySingleton<OverTimeRepository>(
    //   () => OverTimeRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<LeavesRepository>(
    //   () => LeavesRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );
    // getIt.registerLazySingleton<DownloadFileRepository>(
    //   () =>
    //       DownloadFileRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<TicketRepository>(
    //   () => TicketRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<AssignmentRepository>(
    //   () => AssignmentRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<ExpenseRepository>(
    //   () => ExpenseRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );

    // getIt.registerLazySingleton<ExitReentryRepository>(
    //   () => ExitReentryRepositoryImpl(
    //     networkInfo: getIt(),
    //     remoteData: getIt(),
    //   ),
    // );

    //   getIt.registerLazySingleton<ExitReentryFamilyRepository>(
    //   () => ExitReentryFamilyRepositoryImpl(
    //     networkInfo: getIt(),
    //     remoteData: getIt(),
    //   ),
    // );
    // getIt.registerLazySingleton<AttendanceRepository>(
    //   () => AttendanceRepositoryImpl(networkInfo: getIt(), remoteData: getIt()),
    // );
    // Core
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

    getIt.registerSingleton(DioClient());

    await getIt<DioClient>().updateHeader();

    // getIt.registerLazySingleton<LocalData>(() => LocalData(getIt()));

    getIt.registerLazySingleton(
      () => InternetConnectionChecker.createInstance(),
    );
  }
}
