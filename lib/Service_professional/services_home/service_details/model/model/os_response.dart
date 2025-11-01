import 'package:equatable/equatable.dart';

class OSResponse extends Equatable {
  final bool status;
  final List<OSItem> data;

  const OSResponse({
    required this.status,
    required this.data,
  });

  factory OSResponse.fromJson(Map<String, dynamic> json) {
    return OSResponse(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => OSItem.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, data];
}

class OSItem extends Equatable {
  final String id;
  final String name;

  const OSItem({
    required this.id,
    required this.name,
  });

  factory OSItem.fromJson(Map<String, dynamic> json) {
    return OSItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
