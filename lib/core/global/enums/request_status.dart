// enum RequestStatus { all, pending, accepted, refused }
enum RequestStatus {
  all,
  draft,
  inprogress,
  done,
  cancel,
  refuse,
  skip,
  waiting;

  String? get mapStatusToApi {
    switch (this) {
      case RequestStatus.all:
        return null;
      case RequestStatus.draft:
        return "draft";
      case RequestStatus.done:
        return "done";
      case RequestStatus.cancel:
        return "cancel";
      case RequestStatus.inprogress:
        return "inprogress";
      case RequestStatus.refuse:
        return "refuse";
      case RequestStatus.skip:
        return "skip";
      case RequestStatus.waiting:
        return "waiting";
    }
  }
}


enum ContractInfo{salary,other}
