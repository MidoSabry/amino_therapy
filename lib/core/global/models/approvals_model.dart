
import '../enums/request_status.dart';

class Approvals {
  String? nextAction;
  String? needActionFrom;
  int? iD;
  RequestStatus? status;

  String? actionDate;
  String? redirectDate;
  String? actionBy;

  Approvals({
    this.nextAction,
    this.needActionFrom,
    this.iD,
    this.status,

    this.actionDate,
    this.redirectDate,
    this.actionBy,
  });

  factory Approvals.fromMap(Map<String, dynamic> json) {
    return Approvals(
      actionBy: json['ActionBy'],
      actionDate: json['ActionDate'],
      iD: json['ID'],
      status: RequestStatus.values.firstWhere(
        (e) =>
            e.name ==
            json['Status'].toString().replaceAll(' ', '').toLowerCase(),
        orElse: () => RequestStatus.cancel,
      ),
      needActionFrom: json['NeedActionFrom'],
      nextAction: json['NextAction'],
      redirectDate: json['RedirectDate'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NextAction'] = nextAction;
    data['NeedActionFrom'] = needActionFrom;
    data['ID'] = iD;
    data['Status'] = status;
    data['ActionDate'] = actionDate;
    data['RedirectDate'] = redirectDate;
    data['ActionBy'] = actionBy;
    return data;
  }
}
