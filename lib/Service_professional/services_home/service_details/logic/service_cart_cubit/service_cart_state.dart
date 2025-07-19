part of 'service_cart_cubit.dart';

class ServiceCartState extends Equatable {
  final ServiceDate? selectedDate;
  final bool isAddressVisible;
  final String selectedType;
  final bool timeLoader;
  final bool dateLoader;
  final TimeListModel? timeList;
  final DateListModel? dateList;
  final String temSelectedTime;
  final String selectedTime;
  final XFile? image1;
  final XFile? image2;
  final String uploadedImage1Path;
  final String uploadedImage2Path;
  final bool rescheduling;

  const ServiceCartState({
    this.selectedDate,
    this.isAddressVisible = false,
    this.selectedType = '',
    this.timeLoader = false,
    this.dateLoader = false,
    this.timeList,
    this.dateList,
    this.temSelectedTime = '',
    this.selectedTime = '',
    this.image1,
    this.image2,
    this.uploadedImage1Path = '',
    this.uploadedImage2Path = '',
    this.rescheduling = false,
  });

  ServiceCartState copyWith({
    ServiceDate? selectedDate,
    bool? isAddressVisible,
    String? selectedType,
    bool? timeLoader,
    bool? dateLoader,
    TimeListModel? timeList,
    DateListModel? dateList,
    String? temSelectedTime,
    String? selectedTime,
    XFile? image1,
    XFile? image2,
    String? uploadedImage1Path,
    String? uploadedImage2Path,
    bool? rescheduling,
  }) {
    return ServiceCartState(
      selectedDate: selectedDate ?? this.selectedDate,
      isAddressVisible: isAddressVisible ?? this.isAddressVisible,
      selectedType: selectedType ?? this.selectedType,
      timeLoader: timeLoader ?? this.timeLoader,
      dateLoader: dateLoader ?? this.dateLoader,
      timeList: timeList ?? this.timeList,
      dateList: dateList ?? this.dateList,
      temSelectedTime: temSelectedTime ?? this.temSelectedTime,
      selectedTime: selectedTime ?? this.selectedTime,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      uploadedImage1Path: uploadedImage1Path ?? this.uploadedImage1Path,
      uploadedImage2Path: uploadedImage2Path ?? this.uploadedImage2Path,
      rescheduling: rescheduling ?? this.rescheduling,
    );
  }

  @override
  List<Object?> get props => [
    selectedDate,
    isAddressVisible,
    selectedType,
    timeLoader,
    dateLoader,
    timeList,
    dateList,
    temSelectedTime,
    selectedTime,
    image1,
    image2,
    uploadedImage1Path,
    uploadedImage2Path,
    rescheduling,
  ];
}
