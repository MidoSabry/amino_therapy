import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpointsConstants {
  static String get baseUrl => dotenv.env['BASE_URL_DEV']!;

  // Authentication
  static String get login => dotenv.env['LOGIN_ENDPOINT']!;
  static String get verifyOtp => dotenv.env['VERIFY_OTP_ENDPOINT']!;
  static String get getRefreshToken => dotenv.env['REFRESH_LOGIN_ENDPOINT']!;
  static String get logout => dotenv.env['LOGOUT_ENDPOINT']!;

  static String get getEmployeeInfo => dotenv.env['GET_EMPLOYEE_INFO']!;

  static String get getPayslip => dotenv.env['GET_PAYSLIP_ENDPOINT']!;

  // Letters Apis
  static String get getEmployeeLetterDefinition =>
      dotenv.env['GET_EMPLOYEE_CERTIFICATE_LETTER_LIST']!;
  static String get addEmployeeLetterDefinition =>
      dotenv.env['ADD_EMPLOYEE_CERTIFICATE_LETTER']!;
  static String get submitEmployeeLetterDefinition =>
      dotenv.env['SUBMIT_EMPLOYEE_CERTIFICATE_LETTER']!;
  static String get cancelEmployeeLetterDefinition =>
      dotenv.env['CANCEL_EMPLOYEE_CERTIFICATE_LETTER']!;
  static String get certificateFileDownload =>
      dotenv.env['DOWNLOAD_CERTIFICATE_LETTER']!;
  static String get getEmployeeContractInformation =>
      dotenv.env['GET_EMPLOYEE_CONTRACT_INFORMATION']!;

  //overtime
  static String get getOvertimeList =>
      dotenv.env['GET_OVERTIME_LIST_ENDPOINT']!;
  static String get addOvertimeRequest =>
      dotenv.env['ADD_OVERTIME_REQUEST_ENDPOINT']!;
  static String get submitOvertimeRequest =>
      dotenv.env['SUBMIT_OVERTIME_REQUEST_ENDPOINT']!;
  static String get overTimeRequestAction =>
      dotenv.env['OVERTIME_REQUEST_ACTION_ENDPOINT']!;
  static String get overTimeFileDownload => dotenv.env['DOWNLOAD_OVER_TIME']!;

  // Business trips Apis
  static String get getBusinessTripsList =>
      dotenv.env['GET_BUSINESS_TRIP_REQUEST_LIST_ENDPOINT']!;
  static String get addBusinessTripRequest =>
      dotenv.env['ADD_BUSINESS_TRIP_REQUEST_ENDPOINT']!;
  static String get submitBusinessTripRequest =>
      dotenv.env['SUBMIT_BUSINESS_TRIP_REQUEST_ENDPOINT']!;
  static String get businessTripRequestAction =>
      dotenv.env['BUSINESS_TRIP_REQUEST_ACTION_ENDPOINT']!;
  static String get businessTripFileDownload =>
      dotenv.env['BUSINESS_TRIP_FILE_DOWNLOAD_ENDPOINT']!;

  // Leaves Apis
  static String get getLeaveRequestsList =>
      dotenv.env['GET_LEAVE_REQUESTS_LIST_ENDPOINT']!;
  static String get addLeaveRequest =>
      dotenv.env['ADD_LEAVE_REQUEST_ENDPOINT']!;
  static String get submitLeaveRequest =>
      dotenv.env['SUBMIT_LEAVE_REQUEST_ENDPOINT']!;
  static String get leaveRequestAction =>
      dotenv.env['LEAVE_REQUEST_ACTION_ENDPOINT']!;
  static String get leaveFileDownload =>
      dotenv.env['LEAVE_FILE_DOWNLOAD_ENDPOINT']!;

  // Resignation Apis
  static String get getResignationList =>
      dotenv.env['GET_RESINGATION_REQUEST_LIST_ENDPOINT']!;
  static String get addEmployeeResignation =>
      dotenv.env['ADD_RESINGATION_REQUEST_ENDPOINT']!;
  static String get submitResignationRequest =>
      dotenv.env['SUBMIT_RESINGATION_REQUEST_ENDPOINT']!;
  static String get resignationRequestAction =>
      dotenv.env['RESINGATION_REQUEST_ACTION_ENDPOINT']!;
  static String get resignationFileDownload =>
      dotenv.env['RESINGATION_FILE_DOWNLOAD_ENDPOINT']!;

  // Leaves process Apis
  static String get getLeaveProcessRequestsList =>
      dotenv.env['GET_LEAVE_PROCESS_REQUESTS_LIST_ENDPOINT']!;
  static String get getAllLeaveRequestsThatAreDoneToViewInDropDown =>
      dotenv.env['GET_LEAVE_PROCESS_ALL_REQUESTS_LIST_ENDPOINT']!;
  static String get addLeaveProcessRequest =>
      dotenv.env['ADD_LEAVE_PROCESS_REQUEST_ENDPOINT']!;
  static String get submitLeaveProcessRequest =>
      dotenv.env['SUBMIT_LEAVE_PROCESS_REQUEST_ENDPOINT']!;
  static String get leaveProcessRequestAction =>
      dotenv.env['LEAVE_PROCESS_REQUEST_ACTION_ENDPOINT']!;
  static String get leaveProcessFileDownload =>
      dotenv.env['LEAVE_PROCESS_FILE_DOWNLOAD_ENDPOINT']!;

  //Expenses Apis
  static String get getExpensesRequestsList =>
      dotenv.env['GET_EXPENSIES_LIST_ENDPOINT']!;
  static String get addExpense => dotenv.env['ADD_EXPENSIES_REQUEST_END']!;
  static String get submitExpenseRequest =>
      dotenv.env['SUBMIT_EXPENSIES_REQUEST_ENDPOINT']!;
  static String get expenseRequestAction =>
      dotenv.env['EXPENSIES_REQUEST_ACTION_ENDPOINT']!;
  static String get expenseFileDownload =>
      dotenv.env['EXPENSIES_FILE_DOWNLOAD_ENDPOINT']!;

  // Assignment Apis
  static String get getAssignmentRequestsList =>
      dotenv.env['GET_ASSIGNMENT_REQUESTS_LIST_ENDPOINT']!;
  static String get addAssignmentRequest =>
      dotenv.env['ADD_ASSIGNMENT_REQUEST_ENDPOINT']!;
  static String get submitAssignmentRequest =>
      dotenv.env['SUBMIT_ASSIGNMENT_REQUEST_ENDPOINT']!;
  static String get assignmentRequestAction =>
      dotenv.env['ASSIGNMENT_REQUEST_ACTION_ENDPOINT']!;
  static String get assignmentFileDownload =>
      dotenv.env['ASSIGNMENT_FILE_DOWNLOAD_ENDPOINT']!;

  // Tickets Apis
  static String get getTicketRequestsList =>
      dotenv.env['GET_TICKET_REQUESTS_LIST_ENDPOINT']!;
  static String get addTicketRequest =>
      dotenv.env['ADD_TICKET_REQUEST_ENDPOINT']!;
  static String get submitTicketRequest =>
      dotenv.env['SUBMIT_TICKET_REQUEST_ENDPOINT']!;
  static String get ticketRequestAction =>
      dotenv.env['TICKET_REQUEST_ACTION_ENDPOINT']!;
  static String get ticketFileDownload =>
      dotenv.env['TICKET_FILE_DOWNLOAD_ENDPOINT']!;
  static String get ticketFamilyFileDownload =>
      dotenv.env['TICKET_FAMILY_FILE_DOWNLOAD_ENDPOINT']!;




   // Exit Rentry Apis
  static String get getExitRentryRequestsList =>
      dotenv.env['GET_EXITRENTRY_LIST_ENDPOINT']!;
  static String get addExitRentryRequest =>
      dotenv.env['ADD_EXITRENTRY_REQUEST_END']!;
  static String get submitExitRentryRequest =>
      dotenv.env['SUBMIT_EXITRENTRY_REQUEST_ENDPOINT']!;
  static String get exitRentryRequestAction =>
      dotenv.env['EXITRENTRY_REQUEST_ACTION_ENDPOINT']!;
  static String get exitRentryFileDownload =>
      dotenv.env['EXITRENTRY_FILE_DOWNLOAD_ENDPOINT']!;
  

  //  Excuse Apis
  static String get getExcuseListEndpoint =>
      dotenv.env['GET_EXCUSE_REQUESTS_LIST_ENDPOINT']!;
  static String get submitExcuseListEndpoint =>
      dotenv.env['SUBMIT_EXCUSE_REQUEST_ENDPOINT']!;

  // Lookups Apis
  static String get getAllCountries =>
      dotenv.env['GET_ALL_COUNTRIES_ENDPOINT']!;
  static String get getAllKsaStates =>
      dotenv.env['GET_ALL_KSA_STATES_ENDPOINT']!;
  static String get getAllHolidaysTypes =>
      dotenv.env['GET_ALL_HOLIDAYS_TYPES_ENDPOINT']!;
  static String get getEmployeeCertificateLetterTypes =>
      dotenv.env['GET_EMPLOYEE_CERTIFICATE_LETTER_TYPES_ENDPOINT']!;
  static String get getResignationTypes =>
      dotenv.env['GET_RESIGNATIN_TYPES_ENDPOINT']!;
  static String get getAllDepartments =>
      dotenv.env['GET_ALL_DEPARTMENTS_ENDPOINT']!;
  static String get getAllBusinessTripCostTypes =>
      dotenv.env['GET_ALL_BUSINESS_TRIP_COST_TYPES_ENDPOINT']!;
  static String get getAllProjectsPositions =>
      dotenv.env['GET_ALL_PROJECTS_POSITIONS_TYPES_ENDPOINT']!;
  static String get getAllExistTypes =>
      dotenv.env['GET_ALL_EXIST_TYPES_ENDPOINT']!;
  static String get getAllAttendanceStatus =>
      dotenv.env['GET_ALL_ATTENDANCE_STATUS_ENDPOINT']!;

  static String get fingerPrint => dotenv.env['SHA_FINGER_PRINT']!;

  //  Attendance list Api
  static String get getAttendanceListEndpoint =>
      dotenv.env['GET_ATTENDANCE_LIST_ENDPOINT']!;

  // Check in and out attendnace
  static String get markEmployeeAttendance =>
      dotenv.env['MARK_EMPLOYEE_ATTENDANCE_ENDPOINT']!;
}
