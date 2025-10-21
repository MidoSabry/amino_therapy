class AddRequestResponseModel {
  const AddRequestResponseModel({this.data});

  final AddModel? data;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'data': data?.toMap()};
  }

  AddRequestResponseModel fromMap(Map<String, dynamic> map) {
    return AddRequestResponseModel(data: (AddModel.fromMap(map['data'])));
  }

  @override
  String toString() => 'BusinessTripsListResponseModel(data: $data)';
}

class AddModel {
  final int? id;

  const AddModel({this.id});

  factory AddModel.fromMap(Map<String, dynamic> map) {
    return AddModel(id: map['ID'] as int?);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'ID': id};
  }

  @override
  String toString() => 'AddBusinessTripModel(id: $id)';
}
