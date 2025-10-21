import 'package:amino_therapy/core/services/flavorizer/flavors_managment.dart';
import 'package:amino_therapy/core/services/log/app_log.dart';
import 'package:amino_therapy/features/home/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/Splash/presentation/ui/splash_screen.dart';
import '../../../features/parent/ui/page/parent_screen.dart';
import '../../component/inspector/inspector_screen.dart';
import '../../data/constants/app_router.dart';
import '../../data/constants/global_obj.dart';
import '../../global/enums/global_enum.dart';
import '../app_store/app_store_handler.dart';
import '../base_network/interceptors/request_interceptor.dart';
import 'logging_observer.dart';

bool isDialogOpen = false;

class RouterManager {
  static final GoRouter routerManager = GoRouter(
    initialLocation: AppRouter.splash,
    observers: [RouteAwareObserver(), LoggingObserver()],
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    redirect: (context, state) async {
      AppLog.printValue("Redirect method");
      if (FlavorsManagement.instance.getCurrentFlavor.flavorType ==
          FlavorsTypes.prod) {
        // 1. Check update globally
        AppStoreHandler.instance.isUpdateAvailable.then((value) {
          if (value && !isDialogOpen) {
            isDialogOpen = true;
            AppStoreHandler.instance.showUpdateDialog().then((_) {
              isDialogOpen = false;
            });
          }
        });
      }

      // 2. Otherwise, allow navigation
      return null;
    },
    routes: [
      GoRoute(
        name: AppRouter.inspector,
        path: AppRouter.inspector,
        builder: (context, state) =>
            InspectorScreen(inspectorList: inspectList),
      ),
      GoRoute(
        name: AppRouter.splash,
        path: AppRouter.splash,
        builder: (context, state) => const SplashScreen(),
      ),
       GoRoute(
        name: AppRouter.home,
        path: AppRouter.home,
        builder: (context, state) => const HomeScreen(),
      ),
      // GoRoute(
      //   name: AppRouter.onBoarding,
      //   path: AppRouter.onBoarding,
      //   builder: (context, state) => const OnboardScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.login,
      //   path: AppRouter.login,
      //   builder: (context, state) => const LoginScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.otp,
      //   path: AppRouter.otp,
      //   builder: (context, state) => const OtpScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.otp,
      //   path: '/otp',
      //   builder: (context, state) {
      //     final userModel =
      //         state.extra as OtpRequestModel; // 👈 cast to num (int or double)
      //     return OtpScreen(otpUserRequestModel: userModel);
      //   },
      // ),
      // GoRoute(
      //   name: AppRouter.noInternet,
      //   path: AppRouter.noInternet,
      //   builder: (context, state) => NetworkErrorPage(onRetry: () {}),
      // ),

      // GoRoute(
      //   name: AppRouter.employeeFinancialScreen,
      //   path: AppRouter.employeeFinancialScreen,
      //   builder: (context, state) => EmployeeFinancialScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.payslip,
      //   path: AppRouter.payslip,
      //   builder: (context, state) => const PayslipDetailsMainScreen(),
      // ),

      // /////////////////////Requests Page////////////////////////
      // GoRoute(
      //   name: AppRouter.leaveRequests,
      //   path: AppRouter.leaveRequests,
      //   builder: (context, state) => const LeaveRequestsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.businessTripsRequests,
      //   path: AppRouter.businessTripsRequests,
      //   builder: (context, state) => const BusinessTripsRequestsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.resignationRequests,
      //   path: AppRouter.resignationRequests,
      //   builder: (context, state) => const ResignationRequestsScreen(),
      // ),

      // GoRoute(
      //   name: AppRouter.overtimeRequests,
      //   path: AppRouter.overtimeRequests,
      //   builder: (context, state) => const OvertimeRequestsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.letterRequests,
      //   path: AppRouter.letterRequests,
      //   builder: (context, state) => const LetterRequestsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.holidayProcessRequests,
      //   path: AppRouter.holidayProcessRequests,
      //   builder: (context, state) => const HolidayProcessRequestsMainScreen(),
      // ),

      // GoRoute(
      //   name: AppRouter.ticketRequests,
      //   path: AppRouter.ticketRequests,
      //   builder: (context, state) => const TicketRequestsScreen(),
      // ),

      // GoRoute(
      //   name: AppRouter.exitReentryRequests,
      //   path: AppRouter.exitReentryRequests,
      //   builder: (context, state) => const ExitReentryRequestsScreen(),
      // ),

      // GoRoute(
      //   name: AppRouter.exitReentryFamilyRequests,
      //   path: AppRouter.exitReentryFamilyRequests,
      //   builder: (context, state) => const ExitReentryFamilyRequestsScreen(),
      // ),

      // GoRoute(
      //   name: AppRouter.assignmentRequests,
      //   path: AppRouter.assignmentRequests,
      //   builder: (context, state) => const AssignmentRequestsScreen(),
      // ),

      // GoRoute(
      //   name: AppRouter.expensesRequests,
      //   path: AppRouter.expensesRequests,
      //   builder: (context, state) => const ExpenseRequestsScreen(),
      // ),

      // //////////////////////add requestes page////////////////////////
      // GoRoute(
      //   name: AppRouter.addLeaveRequest,
      //   path: AppRouter.addLeaveRequest,
      //   builder: (context, state) => AddLeaveRequestScreen(
      //     addLeaveRequestModel: state.extra as AddLeaveRequestModel?,
      //   ),
      // ),
      // GoRoute(
      //   name: AppRouter.addLeaveProcessRequest,
      //   path: AppRouter.addLeaveProcessRequest,
      //   builder: (context, state) => AddHolidayProcessMainScreen(
      //     holidaysProcessesData: state.extra as HolidaysProcessesData?,
      //   ),
      // ),
      // GoRoute(
      //   name: AppRouter.addLetterRequest,
      //   path: AppRouter.addLetterRequest,
      //   builder: (context, state) => state.extra == null
      //       ? const AddLetterRequestScreen()
      //       : AddLetterRequestScreen(
      //           definitionLetterModel: state.extra as DefinitionLetterModel,
      //         ),
      // ),
      // GoRoute(
      //   name: AppRouter.addOvertimeRequest,
      //   path: AppRouter.addOvertimeRequest,
      //   builder: (context, state) => state.extra == null
      //       ? const AddOvertimeRequestScreen()
      //       : AddOvertimeRequestScreen(
      //           overtimeModel: state.extra as OvertimeModel,
      //           key: UniqueKey(),
      //         ),
      // ),
      // GoRoute(
      //   name: AppRouter.addBusinessTripsRequest,
      //   path: AppRouter.addBusinessTripsRequest,
      //   builder: (context, state) => AddBusinessRequestScreen(
      //     addBusinessRequestModel: state.extra as AddBusinessTripRequestModel?,
      //   ),
      // ),
      // GoRoute(
      //   name: AppRouter.addResignationRequest,
      //   path: AppRouter.addResignationRequest,
      //   builder: (context, state) => AddResignationRequestScreen(
      //     resignationModel: state.extra as AddResignationRequestModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.addTicketRequest,
      //   path: AppRouter.addTicketRequest,
      //   builder: (context, state) => AddTicketRequestScreen(
      //     addTicketRequestModel: state.extra as AddTicketRequestModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.addExitReentryRequest,
      //   path: AppRouter.addExitReentryRequest,
      //   builder: (context, state) => AddExitReentryRequestScreen(
      //     // addBusinessRequestModel:
      //     //     state.extra as AddBusinessTripRequestModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.addExitReentryFamilyRequest,
      //   path: AppRouter.addExitReentryFamilyRequest,
      //   builder: (context, state) => AddExitReentryFamilyRequestScreen(
      //     // addBusinessRequestModel:
      //     //     state.extra as AddBusinessTripRequestModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.addAssignmentRequest,
      //   path: AppRouter.addAssignmentRequest,
      //   builder: (context, state) => AddAssignmentRequestScreen(
      //     addAssignmentRequestModel: state.extra as AddAssignmentRequestModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.addExpensesRequest,
      //   path: AppRouter.addExpensesRequest,
      //   builder: (context, state) => AddExpenseRequestScreen(
      //     addExpenseRequestModel: state.extra as AddExpenseRequestModel?,
      //   ),
      // ),

      // ////////////////////////details requestes page////////////////////////
      // GoRoute(
      //   name: AppRouter.leaveRequestDetails,
      //   path: AppRouter.leaveRequestDetails,
      //   builder: (context, state) =>
      //       LeaveRequestDetailsScreen(leaveModel: state.extra as LeaveModel?),
      // ),
      // GoRoute(
      //   name: AppRouter.leaveProcessRequestDetails,
      //   path: AppRouter.leaveProcessRequestDetails,
      //   builder: (context, state) => HolidayProcessDetailsMainScreen(
      //     model: state.extra as HolidaysProcessesData,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsBusinessTripRequest,
      //   path: AppRouter.detailsBusinessTripRequest,
      //   builder: (context, state) => BusinessTripRequestDetailsScreen(
      //     businessTripModel: state.extra as BusinessTripModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsLetterRequest,
      //   path: AppRouter.detailsLetterRequest,
      //   builder: (context, state) => state.extra == null
      //       ? const DetailsLetterRequestScreen()
      //       : DetailsLetterRequestScreen(
      //           model: state.extra as DefinitionLetterModel,
      //         ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsovertimeRequest,
      //   path: AppRouter.detailsovertimeRequest,
      //   builder: (context, state) => DetailsOverTimeRequestScreen(
      //     overtimeModel: state.extra as OvertimeModel,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsResignationRequest,
      //   path: AppRouter.detailsResignationRequest,
      //   builder: (context, state) => ResignationRequestDetailsScreen(
      //     resignationModel: state.extra as ResignationModel,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsTicketRequest,
      //   path: AppRouter.detailsTicketRequest,
      //   builder: (context, state) => TicketRequestDetailsScreen(
      //     ticketModel: state.extra as TicketModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsExitReentryRequest,
      //   path: AppRouter.detailsExitReentryRequest,
      //   builder: (context, state) => ExitReentryRequestDetailsScreen(
      //     // businessTripModel: state.extra as BusinessTripModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsExitReentryFamilyRequest,
      //   path: AppRouter.detailsExitReentryFamilyRequest,
      //   builder: (context, state) => ExitReentryFamilyRequestDetailsScreen(
      //     // businessTripModel: state.extra as BusinessTripModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsAssignmentRequest,
      //   path: AppRouter.detailsAssignmentRequest,
      //   builder: (context, state) => AssignmentRequestDetailsScreen(
      //     assignmentModel: state.extra as AssignmentModel?,
      //   ),
      // ),

      // GoRoute(
      //   name: AppRouter.detailsExpensesRequest,
      //   path: AppRouter.detailsExpensesRequest,
      //   builder: (context, state) => ExpenseRequestDetailsScreen(
      //     expenseModel: state.extra as ExpenseModel?,
      //   ),
      // ),

      // ////////////////////////////////////////////////////////////////////////
      // GoRoute(
      //   name: AppRouter.workDetails,
      //   path: AppRouter.workDetails,
      //   builder: (context, state) => const WorkDetailsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.personalDetails,
      //   path: AppRouter.personalDetails,
      //   builder: (context, state) => const PerosnalDetailsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.addressDetails,
      //   path: AppRouter.addressDetails,
      //   builder: (context, state) => const AddressDetailsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.relativesDetails,
      //   path: AppRouter.relativesDetails,
      //   builder: (context, state) => const RelativesDetailsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.certificates,
      //   path: AppRouter.certificates,
      //   builder: (context, state) => const CertificatesScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.emergencyContacts,
      //   path: AppRouter.emergencyContacts,
      //   builder: (context, state) => const EmergencyContactsScreen(),
      // ),

      // // Menu modules
      // GoRoute(
      //   name: AppRouter.settings,
      //   path: AppRouter.settings,
      //   builder: (context, state) => const SettingsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.companyDetails,
      //   path: AppRouter.companyDetails,
      //   builder: (context, state) => const CompanyDetailsScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.policy,
      //   path: AppRouter.policy,
      //   builder: (context, state) => const PolicyScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.generalInfo,
      //   path: AppRouter.generalInfo,
      //   builder: (context, state) => const GeneralInfoScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.contactus,
      //   path: AppRouter.contactus,
      //   builder: (context, state) => const ContactUsScreen(),
      // ),

      // GoRoute(
      //   name: AppRouter.contract,
      //   path: AppRouter.contract,
      //   builder: (context, state) => const ContractScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.attendnaceScreen,
      //   path: AppRouter.attendnaceScreen,
      //   builder: (context, state) => const AttendanceScreen(),
      // ),
      // GoRoute(
      //   name: AppRouter.submitExcuseScreen,
      //   path: AppRouter.submitExcuseScreen,
      //   builder: (context, state) => SubmitExcuseRequestScreen(
      //     submitExcuseRequestModel: state.extra as SubmitExcuseRequestModel,
      //   ),
      // ),
      // StatefulShellRoute.indexedStack(
      //   builder: (context, state, navigationShell) {
      //     globalNavigationShell = navigationShell;
      //     return ParentScreen(navigationShell: navigationShell);
      //   },
      //   branches: [
      //     StatefulShellBranch(
      //       routes: [
      //         GoRoute(
      //           name: AppRouter.home,
      //           path: AppRouter.home,
      //           builder: (context, state) => HomeScreen(
      //             key: ValueKey(
      //               '${AppRouter.home}_${context.locale.languageCode}',
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //     StatefulShellBranch(
      //       routes: [
      //         // GoRoute(
      //         //   name: AppRouter.requests,
      //         //   path: AppRouter.requests,
      //         //   builder: (context, state) => RequestsMobileBody(
      //         //     key: ValueKey(
      //         //       '${AppRouter.requests}_${context.locale.languageCode}',
      //         //     ),
      //         //   ),
      //         // ),
      //       ],
      //     ),
      //         StatefulShellBranch(
      //           routes: [
      //             // GoRoute(
      //             //   name: AppRouter.profile,
      //             //   path: AppRouter.profile,
      //             //   builder: (context, state) => ProfileMobileBody(
      //             //     key: ValueKey(
      //             //       '${AppRouter.profile}_${context.locale.languageCode}',
      //             //     ),
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //         StatefulShellBranch(
      //           routes: [
      //             // GoRoute(
      //             //   name: AppRouter.menu,
      //             //   path: AppRouter.menu,
      //             //   builder: (context, state) => MenuMobileBody(
      //             //     key: ValueKey(
      //             //       '${AppRouter.menu}_${context.locale.languageCode}',
      //             //     ),
      //             //   ),
      //             // ),
      //           ],
      //         ),
      //   ],
      // ),
    ],
  );

  GoRouter get router => routerManager;
}

class RouteAwareObserver extends NavigatorObserver {
  final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();

  void _logRouteChange(String action, Route route, Route? previousRoute) {
    final currentName = route.settings.name ?? 'Unknown';
    final previousName = previousRoute?.settings.name ?? 'None';

    debugPrint(
      '[ROUTE] $action → Current: $currentName | Previous: $previousName',
    );
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _logRouteChange('PUSH', route, previousRoute);
    if (route is ModalRoute) {
      routeObserver.didPush(route, previousRoute as ModalRoute?);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _logRouteChange(
      'POP',
      previousRoute ?? const RouteSettings(name: 'None') as Route,
      route,
    );
    if (route is ModalRoute) {
      routeObserver.didPop(route, previousRoute as ModalRoute?);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logRouteChange(
      'REPLACE',
      newRoute ?? const RouteSettings(name: 'Unknown') as Route,
      oldRoute,
    );
    if (newRoute is ModalRoute) {
      routeObserver.didReplace(
        newRoute: newRoute,
        oldRoute: oldRoute as ModalRoute?,
      );
    }
  }
}

PageRouteBuilder createZoomPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        child: child,
      );
    },
  );
}
