class CommonResponseModel {
  final String status;

  // Constructor
  CommonResponseModel({required this.status});

  // Convert a JSON map to a CommonResponseModel object (fromJson)
  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      status: json['status'],
    );
  }

  // Convert a CommonResponseModel object to a JSON map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
