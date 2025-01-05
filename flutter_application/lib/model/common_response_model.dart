class CommonResponseModel {
  final String status;
  final String errorMessage;

  // Constructor
  CommonResponseModel({required this.status, required this.errorMessage});

  // Convert a JSON map to a CommonResponseModel object (fromJson)
  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      status: json['status'],
      errorMessage: json['errorMessage'],
    );
  }

  // Convert a CommonResponseModel object to a JSON map (toJson)
  Map<String, dynamic> toJson() {
    return {'status': status, 'errorMessage': errorMessage};
  }
}
