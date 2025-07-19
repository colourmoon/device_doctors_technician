import 'package:equatable/equatable.dart';

class AllOrderType extends Equatable {
  final String title;
  final String type;

  const AllOrderType({required this.title, required this.type});

  // Predefined static instances (like enum values)
  static const all = AllOrderType(title: 'All', type: 'all');
  static const rejected = AllOrderType(title: 'Pending', type: 'Pending');
  static const accepted = AllOrderType(title: 'Accepted', type: 'Accepted');
  static const reached = AllOrderType(
      title: 'Reached to your location', type: 'Reached to your location');
  static const serviceStarted =
      AllOrderType(title: 'Service Started', type: 'Service Started');
  static const completed =
      AllOrderType(title: 'Service Completed', type: 'Completed');
  static const cancelled =
      AllOrderType(title: 'Cancelled', type: 'Cancelled Rejected');

  // All values list
  static const List<AllOrderType> values = [
    all,
    rejected,
    accepted,
    reached,
    serviceStarted,
    completed,
    cancelled,
  ];

  // Utility method to get instance from type string
  static AllOrderType fromType(String type) {
    return values.firstWhere(
      (element) => element.type.toLowerCase() == type.toLowerCase(),
      orElse: () => accepted, // default fallback
    );
  }

  // Useful for debugging
  @override
  String toString() => 'AllOrderType(title: $title, type: $type)';

  @override
  List<Object?> get props => [title, type];
}
