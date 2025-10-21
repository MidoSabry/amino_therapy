import '../global/enums/request_status.dart';

class StepData {
  final RequestStatus status;
  final String role;
  final String name;
  final String initials;

  StepData({
    required this.status,
    required this.role,
    required this.name,
    required this.initials,
  });
}