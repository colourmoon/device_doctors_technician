import 'package:device_doctors_technician/widget/CustomWidget/Demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../comman/common_text.dart';
import '../../../commons/shimmer_widgets/common_loading_widgets.dart';
import '../logic/saved_devices_cubit.dart';
import '../model/model/saved_devices_response.dart';

class AddNewDeviceScreen extends StatefulWidget {
  final String id;
  final String deviceModelName;
  final String selectBrand;
  final String modelName;
  final String serviceTag;
  const AddNewDeviceScreen(
      {super.key,
      required this.id,
      required this.deviceModelName,
      required this.selectBrand,
      required this.modelName,
      required this.serviceTag});

  @override
  State<AddNewDeviceScreen> createState() => _AddNewDeviceScreenState();
}

class _AddNewDeviceScreenState extends State<AddNewDeviceScreen> {
  TextEditingController deviceModelName = TextEditingController();
  TextEditingController selectBrand = TextEditingController();
  TextEditingController modelName = TextEditingController();
  TextEditingController serviceTag = TextEditingController();
  @override
  void initState() {
    deviceModelName.text = widget.deviceModelName;
    selectBrand.text = widget.selectBrand;
    modelName.text = widget.modelName;
    serviceTag.text = widget.serviceTag;
    super.initState();
  }

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final RegExp invalidCharacters = RegExp(r"[^\w\s\-]");
    return Scaffold(
      backgroundColor: ApplicationColours.whiteColor,
      appBar: AppBar(
          backgroundColor: ApplicationColours.whiteColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffECECEC),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.chevron_left,
                  color: ApplicationColours.blackColor,
                ),
              ),
            ),
          ),
          titleSpacing: 0,
          title: const CommonProximaNovaTextWidget(
            text: 'Add Device Details',
            color: ApplicationColours.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          )),
      body: Form(
        key: globalKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              DeviceTypeDropdown(
                selectedValue: deviceModelName.text.isNotEmpty
                    ? '${deviceModelName.text[0].toUpperCase()}${deviceModelName.text.substring(1)}'
                    : null,
                onChanged: (String? value) {
                  if (value != null) {
                    deviceModelName.text = value;
                  }
                },
              ),
              16.ph,
              CommonTextFieldAuthentication(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                keyboardPopType: TextInputType.name,
                controller: selectBrand,
                hintText: 'Enter Brand',
                isPassword: false,
                isObscureText: false,
                typeOfRed: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(invalidCharacters),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your brand name";
                  } else if (value.trim().length < 3) {
                    return "Brand name must be at least 3 characters long";
                  } else if (invalidCharacters.hasMatch(value)) {
                    return "Brand name contains invalid characters";
                  }
                  return null;
                },
              ),
              16.ph,
              CommonTextFieldAuthentication(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                keyboardPopType: TextInputType.name,
                controller: modelName,
                hintText: 'Model Name',
                isPassword: false,
                isObscureText: false,
                typeOfRed: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(invalidCharacters),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your device's model name";
                  } else if (value.trim().length < 3) {
                    return "Model name must be at least 3 characters long";
                  } else if (invalidCharacters.hasMatch(value)) {
                    return "Model name contains invalid characters";
                  }
                  return null;
                },
              ),
              16.ph,
              CommonTextFieldAuthentication(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                keyboardPopType: TextInputType.name,
                controller: serviceTag,
                hintText: 'Service Tag / Serial No.',
                isPassword: false,
                isObscureText: false,
                typeOfRed: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(invalidCharacters),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your device's service tag or serial number";
                  } else if (value.trim().length < 3) {
                    return "Service tag must be at least 3 characters long";
                  } else if (invalidCharacters.hasMatch(value)) {
                    return "Service tag contains invalid characters";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<SavedDevicesCubit, SavedDevicesState>(
          builder: (context, state) {
            return ThemeElevatedButton(
              width: double.infinity,
              key: const Key("update_device_button"),
              buttonName:
                  "${widget.id.isNotEmpty ? 'Update' : 'Saved'} Details",
              backgroundColor: ApplicationColours.appMainColor,
              textFontSize: 16,
              borderRadius: 12,
              showLoadingSpinner: state.addStatus == ApiStatusState.loading,
              onPressed: state.addStatus == ApiStatusState.loading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      if (globalKey.currentState?.validate() == true) {
                        final deviceInfo = {
                          'device_type': deviceModelName.text,
                          'order_id': widget.id,
                          'brand': selectBrand.text,
                          'model_name': modelName.text,
                          'serial_number': serviceTag.text,
                        };

                        context.read<SavedDevicesCubit>().addNewDevice(
                              context: context,
                              deviceInfo: deviceInfo,
                              savedDevice: SavedDevice(
                                brand: selectBrand.text,
                                deviceType: deviceModelName.text,
                                modelName: modelName.text,
                                id: widget.id,
                                serialNumber:  serviceTag.text,

                              ),
                            );
                      }
                    },
            );
          },
        ),
      ),
    );
  }
}

class DeviceTypeDropdown extends StatefulWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const DeviceTypeDropdown({
    super.key,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  State<DeviceTypeDropdown> createState() => _DeviceTypeDropdownState();
}

class _DeviceTypeDropdownState extends State<DeviceTypeDropdown> {
  final List<String> _deviceTypes = ['Mac', 'Windows'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedValue,
      hint: const Text(
        'Select Device',
        style: TextStyle(
          color: Color(0xFF222534),
          fontSize: 14,
          fontFamily: 'ProximaNova',
          fontWeight: FontWeight.w400,
        ),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: ApplicationColours.textFiledColor, width: 1),
            borderRadius: BorderRadius.circular(12)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),
        labelText: 'Select Device Type',
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      items: _deviceTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(
            type,
            style: const TextStyle(
              color: Color(0xFF222534),
              fontSize: 14,
              fontFamily: 'ProximaNova',
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a device type';
        }
        return null;
      },
    );
  }
}

class CommonTextFieldAuthentication extends StatelessWidget {
  final TextInputType keyboardPopType;
  final TextEditingController controller;
  final String hintText;
  final EdgeInsetsGeometry contentPadding;
  final bool isPassword;
  final bool isObscureText;
  final VoidCallback? isSuffixPressed;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? typeOfRed;
  final ValueChanged? onChangeVal;
  final bool? isErrorText;
  final String? isErrorTextString;
  final int? maxLines;
  final bool? enabled;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;

  const CommonTextFieldAuthentication({
    super.key,
    required this.controller,
    required this.hintText,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 18.0,
    ),
    required this.isPassword,
    this.isSuffixPressed,
    this.suffixIcon,
    required this.isObscureText,
    required this.typeOfRed,
    this.onChangeVal,
    this.isErrorText,
    this.isErrorTextString,
    this.maxLines,
    required this.keyboardPopType,
    this.validator,
    this.enabled,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.words,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: readOnly,
      keyboardType: keyboardPopType,
      controller: controller,
      obscureText: isObscureText ? true : false,
      cursorColor: ApplicationColours.blackColor,
      inputFormatters: typeOfRed,
      textCapitalization: textCapitalization,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
      cursorWidth: 1,
      validator: validator,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.2,
          overflow: TextOverflow.ellipsis,
        ),
        hintStyle:
            const TextStyle(color: ApplicationColours.blackColor, fontSize: 12),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),

        //     // contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 5),

        fillColor: Colors.white,
        suffixIcon: suffixIcon ??
            IconTheme(
              data: const IconThemeData(),
              child: isPassword
                  ? IconButton(
                      onPressed: isSuffixPressed,
                      icon: Icon(
                        isObscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: ApplicationColours.textFiledColor,
                        size: 20,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
        errorText: isErrorText == null
            ? null
            : isErrorText!
                ? isErrorTextString
                : null,
        filled: true,
        contentPadding: contentPadding,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: ApplicationColours.textFiledColor, width: 1),
            borderRadius: BorderRadius.circular(12)),

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 1, color: ApplicationColours.textFiledColor)),
      ),
      onChanged: onChangeVal,
    );
  }
}

class ApplicationColours {
  static const Color appMainColor = Color(0xff213dfd);
  static const Color appAnotherColor = Color(0xffFF3D3D);
  static const Color mainColor = Color(0xff000000);
  static const Color blackColor = Color(0xff000000);
  static const Color borderGray = Color(0xffE8E8E8);
  static const Color redTextColor = Color(0xffFF3D3D);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color darkColor = Color(0xff000000);
  static const Color trackButtonColor = Color(0xff4570C2);
  static const Color editChangeButtonColor = Color(0xff4763FF);
  static Color backgroundColor = const Color(0xffffffff);
  static Color lightGreenColor = const Color(0xff5BB306);
  static Color greenColor = const Color(0xff2b9b2b);
  static const Color orangeColor = Color(0xfffc9909);
  static Color lightGrey = const Color(0xff7e7e7e);
  static const Color backColor = Color(0xffe7e7ed);
  static const Color darkGreenColour = Color(0xff098b09);
  static const Color shadowColor = Color.fromARGB(60, 116, 116, 116);
  static const Color textFiledColor = Color(0xFFD3DBE8);

  static Color subTitleBlackColor = const Color(0xff1C1C1C);
  static Color unSelectedItemColor = const Color(0xff717171);

  static Color themeorangeColor = const Color(0xffFF6600);
  static Color bgCard = const Color(0xffE7EAEC);
  static Color walletGreen = const Color(0xff038600);
  static Color walletTranstionsCard = const Color(0xffEBEBEB);
  static Color walletTranstionsred = const Color(0xffFF0E0E);
  static Color servicesTheme = const Color(0xff3574E0);
  static Color scheduledColor = const Color(0xffBD00FF);
  static Color cancelRedColor = const Color(0xffFF0000);
  static Color completedGreen = const Color(0xff80C807);
  static Color onGoingBlue = const Color(0xff4763FF);
}

class ApplicationFont {
  static const String manropeFontFamily = 'Poppins';
  static const String poppinsFontFamily = 'Poppins';
}

class ThemeElevatedButton extends StatelessWidget {
  final String buttonName;
  final Widget? suffix;
  final bool showLoadingSpinner;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final double textFontSize;
  final double loadingSpinnerSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool disableButton;
  const ThemeElevatedButton({
    super.key,
    this.showLoadingSpinner = false,
    this.disableButton = false,
    required this.buttonName,
    this.suffix,
    this.onPressed,
    this.textFontSize = 15,
    this.loadingSpinnerSize = 30,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height ?? 50,
        width: width ?? double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(0),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 5),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            foregroundColor: WidgetStateProperty.all(foregroundColor),
          ),
          onPressed: disableButton
              ? null
              : () {
                  if (onPressed != null && !showLoadingSpinner) {
                    onPressed!.call();
                  }
                },
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
            child: showLoadingSpinner
                ? ThemeSpinner(
                    size: loadingSpinnerSize,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        buttonName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: foregroundColor ?? Colors.white,
                          fontSize: textFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (suffix != null) suffix!,
                    ],
                  ),
          ),
        ),
      );
}
