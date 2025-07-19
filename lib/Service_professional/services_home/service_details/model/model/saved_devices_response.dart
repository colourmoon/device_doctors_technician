
class SavedDevice {
  final String? id;
  final String? userId;
  final String? deviceType;
  final String? brand;
  final String? modelName;
  final String? serialNumber;
  final String? createdAt;

  SavedDevice({
    this.id,
    this.userId,
    this.deviceType,
    this.brand,
    this.modelName,
    this.serialNumber,
    this.createdAt,
  });

  factory SavedDevice.fromJson(Map<String, dynamic> json) {
    return SavedDevice(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      deviceType: json['device_type'] as String?,
      brand: json['brand'] as String?,
      modelName: json['model_name'] as String?,
      serialNumber: json['serial_number'] as String?,
      createdAt: json['created_at'] as String?,
    );
  }
}

class SavedDevicesResponse {
  final String? errCode;
  final String? message;
  final List<SavedDevice> data;

  SavedDevicesResponse({
    this.errCode,
    this.message,
    required this.data,
  });

  factory SavedDevicesResponse.fromJson(Map<String, dynamic> json) {
    return SavedDevicesResponse(
      errCode: json['err_code'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => SavedDevice.fromJson(item))
          .toList() ??
          [],
    );
  }
}

