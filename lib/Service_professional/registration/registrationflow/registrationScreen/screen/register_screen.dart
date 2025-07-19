import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_text_widget.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';
import 'package:device_doctors_technician/Service_professional/commons/shimmer_widgets/common_loading_widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../../../../../comman/env.dart';
import '../../../../../multi_choice.dart';
import '../../../../commons/color_codes.dart';
import '../../../../commons/common_button_widget.dart';
import '../../../../commons/common_textformfield.dart';
import 'package:location/location.dart' as geo;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../verification/screen/otp_verification_screen.dart';
import '../../service_categories/screen/service_categories_screen.dart';
import '../logic/cubit/registration_cubit.dart';
import '../logic/cubit/registration_state.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as map;

class ServicesRegistrationScreen extends StatefulWidget {
  const ServicesRegistrationScreen({super.key});

  @override
  State<ServicesRegistrationScreen> createState() =>
      _ServicesRegistrationScreenState();
}

class _ServicesRegistrationScreenState
    extends State<ServicesRegistrationScreen> {
  late LocationPermission permission;
  final List languagesList = const [
    'Telugu',
    'Hindi',
    'English',
  ];
  late final LocatitonGeocoder geocoder;
  List selectedLanguagesList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController servicesidController = TextEditingController();

  dynamic selectedOption;
  bool isLocationFetchingLoading = false;
  String? _sessionToken;
  dynamic location;
  final _searchFocusNode = FocusNode();
  List<dynamic> _startList = [];
  Position? currentLocation;
  String lat = "";
  String long = "";
  bool registered = false;
  bool bottomSheet = true;
  String placeId = "";
  var uuid = new Uuid();
  final places = map.FlutterGooglePlacesSdk(
      Platform.isAndroid ? googleMapsKey : iosMapsKey);
  // bool bottomSheet = true;

  void getStartSuggestion(String input) async {
    try {
      // Call the findAutocompletePredictions method from flutter_google_places_sdk
      final response = await places.findAutocompletePredictions(
        input,
        countries: ['in'], // Restrict to India
        newSessionToken: true, // Generate a new session token
        // You can add locationBias or other parameters if needed
      );

      if (response.predictions.isNotEmpty) {
        setState(() {
          // Map the predictions to the _startList (similar to the original)
          _startList = response.predictions.map((prediction) {
            return {
              'description': prediction.fullText,
              'place_id': prediction.placeId,
            };
          }).toList();
        });
      } else {
        throw Exception('No predictions found');
      }
    } catch (e) {
      print('Failed to load predictions: $e');
      throw Exception('Failed to load predictions');
    }
  }

  _onChanged() async {
    print("asha here...");
    print(_sessionToken);
    if (_sessionToken == null) {
      print("asdfghj");
      setState(() {
        _sessionToken = uuid.v4();
      });
    } else {
      getStartSuggestion(addressController.text);
    }
  }

  late bool locationservice;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      geocoder =
          LocatitonGeocoder(Platform.isAndroid ? googleMapsKey : iosMapsKey);
      permission = await Geolocator.checkPermission();
      locationservice = await Geolocator.isLocationServiceEnabled();
    });
    addressController.addListener(() {
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      print(addressController.text);
      _onChanged();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: formkey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 144,
                      height: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/device_doctor.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    CommonProximaNovaTextWidget(
                      textAlign: TextAlign.center,
                      text: "Register Now!",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppthemeColor().themecolor,
                    ),
                    5.ph,
                    CommonProximaNovaTextWidget(
                      textAlign: TextAlign.center,
                      text: "Hi, Welcome to the TechHouse Professional",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppthemeColor().themecolor,
                    ),
                    15.ph,
                    CommonTextformfieldWidget(
                      fieldOntap: () {},
                      hintText: 'Name',
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      textcap: TextCapitalization.sentences,
                      formatters: [
                        LengthLimitingTextInputFormatter(20),
                        // FilteringTextInputFormatter.allow(
                        //   RegExp(r'[0-9][A-Z][a-z]'),
                        // ),
                        // FilteringTextInputFormatter.deny(
                        //   RegExp(r'^0+'), //users can't type 0 at 1st position
                        // ),
                      ],
                      validator: (value) {
                        print(value);
                        if (value?.isEmpty ?? true) {
                          return 'Name is Empty';
                        }
                        return null;
                      },
                    ),
                    15.ph,
                    TextFormField(
                      focusNode: _searchFocusNode,
                      controller: addressController,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 12,
                        fontFamily: 'ProximaNova',
                        fontWeight: FontWeight.w500,
                      ),
                      readOnly: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(
                            '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                      ],
                      cursorColor: AppthemeColor().themecolor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFC1C1C1)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFC1C1C1)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFFC1C1C1)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Complete Address",
                        hintStyle: const TextStyle(
                          color: Color(0xFF222534),
                          fontSize: 12,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.w500,
                        ),
                        suffixIcon: isLocationFetchingLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppthemeColor().themecolor,
                                  ),
                                ))
                            : InkWell(
                                onTap: () async {
                                  try {
                                    print(
                                        'Checking location service and permission...');
                                    geo.Location getLocation = geo.Location();
                                    bool locationService = await Geolocator
                                        .isLocationServiceEnabled();

                                    if (!locationService) {
                                      bool allowed =
                                          await getLocation.requestService();
                                      if (allowed) {
                                        print("Service enabled by user.");
                                        permission = await Geolocator
                                            .requestPermission();
                                      } else {
                                        print("Redirecting to settings...");
                                        await Geolocator.openLocationSettings();
                                        return;
                                      }
                                    }

                                    permission =
                                        await Geolocator.checkPermission();

                                    if (permission ==
                                            LocationPermission.always ||
                                        permission ==
                                            LocationPermission.whileInUse) {
                                      print("Fetching current position...");
                                      setState(() {
                                        isLocationFetchingLoading = true;
                                      });

                                      currentLocation =
                                          await Geolocator.getCurrentPosition();

                                      print(
                                          "Latitude: ${currentLocation?.latitude}, Longitude: ${currentLocation?.longitude}");

                                      final coordinates = Coordinates(
                                        currentLocation!.latitude,
                                        currentLocation!.longitude,
                                      );

                                      lat =
                                          currentLocation!.latitude.toString();
                                      long =
                                          currentLocation!.longitude.toString();

                                      var addresses = await geocoder
                                          .findAddressesFromCoordinates(
                                              coordinates);
                                      if (addresses.isNotEmpty) {
                                        var first = addresses.first;
                                        setState(() {
                                          isLocationFetchingLoading = false;
                                          location = null;
                                          addressController.text =
                                              first.addressLine ?? '';
                                        });
                                        print(
                                            "Resolved Address: ${first.featureName} : ${first.addressLine}");
                                      } else {
                                        setState(() {
                                          isLocationFetchingLoading = false;
                                        });
                                        print(
                                            "No address found for the given coordinates.");
                                        // Optional: show a toast/snackbar here
                                      }
                                    } else if (permission ==
                                        LocationPermission.deniedForever) {
                                      print(
                                          "Permission denied forever. Opening app settings...");
                                      await Geolocator.openAppSettings();
                                    } else {
                                      print("Requesting permission...");
                                      permission =
                                          await Geolocator.requestPermission();
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLocationFetchingLoading = false;
                                    });
                                    print("Error fetching location: $e");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: SvgPicture.asset(
                                    'assets/services_new/currentLocation.svg',
                                    height: 20,
                                    // color: AppthemeColor(),
                                  ),
                                ),
                              ),
                      ),
                      onChanged: (val) {
                        bottomSheet = true;
                        print("bottomsheet value: $bottomSheet");
                        _onChanged();
                      },
                      onTap: () {
                        setState(() {
                          bottomSheet = true;
                        });
                      },
                      onSaved: (value) {
                        String _onlyDigits =
                            value!.replaceAll(RegExp('[^0-9]'), "");
                        double _doubleValue = double.parse(_onlyDigits) / 100;
                        // return _contactNumber.text = _doubleValue.toString();
                      },
                      validator: (v) {
                        if (v?.length == 0) {
                          return 'Please Enter Address You Want to Search';
                        } else {
                          return null;
                        }
                      },
                    ),
                    if (bottomSheet == true)
                      for (var i = 0; i < _startList.length; i++)
                        Card(
                          //  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 0.5),
                          elevation: 1,
                          color: Colors.white,
                          child: ListTile(
                            selectedTileColor: Colors.blue,
                            // focusColor: Colors.blue,
                            tileColor: Colors.white,
                            title: Text(
                              _startList[i]["description"],
                              style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            onTap: () async {
                              setState(() {
                                bottomSheet = false;
                                _searchFocusNode.unfocus();
                                addressController.clear();
                                addressController.text =
                                    _startList[i]['description'];
                                placeId = _startList[i]["place_id"];
                              });

                              List<dynamic> placeMark =
                                  await locationFromAddress(
                                      addressController.text.trim());
                              // print(
                              //     "Printing Addres of Selected: ${_placeMark[0].latitude}");

                              setState(() {
                                lat = placeMark[0].latitude.toString();
                                long = placeMark[0].longitude.toString();
                              });
                              setState(() {
                                _searchFocusNode.unfocus();
                                _startList.clear();
                              });
                            },
                          ),
                        ),
                    15.ph,
                    CommonTextformfieldWidget(
                      fieldOntap: () {},
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                      formatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]'),
                        ),
                        FilteringTextInputFormatter.deny(
                          RegExp(r'^0+'), //users can't type 0 at 1st position
                        ),
                      ],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Phone Number is Empty';
                        } else if (value!.length < 10) {
                          return 'Please Enter 10 Digit Mobile Number';
                        }
                        return null;
                      },
                    ),
                    15.ph,
                    CommonTextformfieldWidget(
                        fieldOntap: () {},
                        hintText: 'Email ID',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        formatters: [
                          FilteringTextInputFormatter.deny(RegExp(
                              '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return newValue.copyWith(
                              text: newValue.text.toLowerCase(),
                              selection: newValue.selection,
                            );
                          }),
                        ],
                        validator: (value) {
                          String pattern =
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
                          RegExp regex = RegExp(pattern);

                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter email';
                          } else if (!regex.hasMatch(value.trim())) {
                            return 'Please enter a valid email';
                          } else if (!value.trim().endsWith('.com')) {
                            return 'Email must end with .com';
                          }
                          return null;
                        }),
                    15.ph,
                    DropdownButtonFormField<String>(
                        // value: selectedOption,
                        validator: (value) =>
                            value == null ? "Please Select Gender" : null,
                        isExpanded: true,
                        menuMaxHeight: 400,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppthemeColor().themeFont,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          // suffixIcon: suffixiconWidget,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          // hintText: hintText,
                          hintStyle: const TextStyle(
                            color: Color(0xFF222534),
                            fontSize: 12,
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.w500,
                          ),
                          // prefixIcon: const Padding(
                          //   padding: EdgeInsets.all(16),
                          //   child: ImageIcon(
                          //     AssetImage('assets/FoodRestaurant/user2342.png'),
                          //     size: 10,
                          //   ),
                          // ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xFFC1C1C1),
                              )),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.red,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xFFC1C1C1),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xFFC1C1C1),
                              )),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hint: Text(
                          "Gender",
                          style: TextStyle(
                            color: const Color(0xFF222534),
                            fontSize: 12,
                            fontFamily: AppthemeColor().themeFont,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 22,
                          color: selectedOption == ""
                              ? Colors.grey
                              : AppthemeColor().themecolor,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        items: ["Male", "Female"].map((type) {
                          return DropdownMenuItem<String>(
                            // key: Key(type.id.toString()),
                            value: type ?? "",
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: ((String? value) {
                          setState(() {
                            selectedOption = value;
                          });
                          print("selectedOption $selectedOption");
                        })),
                    // languages
                    15.ph,
                    ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(12),
                      child: MultiSelectDropdownSelect.simpleList(
                        splashColor: const Color(0xffD3DBE8),
                        checkboxFillColor: const Color(0xffD3DBE8),
                        listTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: AppthemeColor().themeFont,
                          fontWeight: FontWeight.w500,
                        ),

                        textStyle: TextStyle(
                          color: const Color(0xFF222534),
                          fontSize: 12,
                          fontFamily: AppthemeColor().themeFont,
                          fontWeight: FontWeight.w500,
                        ),
                        whenEmpty: "Languages Known",
                        list: languagesList,
                        initiallySelected: const [],
                        suffixIconWidget: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 25,
                          color: Colors.black,
                        ),
                        onChange: updateSelectedLanguages,
                        boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xFFC1C1C1),
                            )),
                        // includeSelectAll: true,
                      ),
                    ),
                    // const SizedBox(height: 50),
                    // MultiSelectDropdown.simpleList(
                    //   list: myList2,
                    //   initiallySelected: const [],
                    //   onChange: (newList) {
                    //     // your logic
                    //   },
                    //   includeSearch: true,
                    //   includeSelectAll: true,
                    // ),

                    15.ph,
                    CommonTextformfieldWidget(
                      fieldOntap: () {
                        Navigator.of(context)
                            .push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 300),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const ServiceCategoriesScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final tween = Tween(
                                  begin: const Offset(0, 1), end: Offset.zero);
                              final curvedAnimation = CurvedAnimation(
                                  parent: animation, curve: Curves.easeInOut);

                              return SlideTransition(
                                position: tween.animate(curvedAnimation),
                                child: child,
                              );
                            },
                          ),
                        )
                            .then((dynamic value) {
                          // servicesController.text = value ?? "
                          if (value != null && value.length >= 2) {
                            print("value ${value[1]}");
                            servicesController.text = value[1].join(',');
                            servicesidController.text = value[0].join(',');
                          } else {
                            print(
                                "value is null or does not contain enough elements");
                            servicesController.text = '';
                            servicesidController.text = '';
                          }
                        });
                      },
                      readonly: true,
                      hintText: 'What work you do',
                      keyboardType: TextInputType.name,
                      controller: servicesController,
                      suffixiconWidget: const Icon(
                        Icons.chevron_right,
                        size: 25,
                        color: Colors.black,
                      ),
                      formatters: const [
                        // LengthLimitingTextInputFormatter(20),
                        // FilteringTextInputFormatter.allow(
                        //   RegExp(r'[0-9][A-Z][a-z]'),
                        // ),
                        // FilteringTextInputFormatter.deny(
                        //   RegExp(r'^0+'), //users can't type 0 at 1st position
                        // ),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Select What Works You Do';
                        }
                        return null;
                      },
                    ),
                    15.ph,
                    BlocConsumer<RegistrationCubit, RegistrationState>(
                      listener: (context, state) {
                        // print(
                        //     'registration loading state : ${state.registrationLoading}');
                        if (state.registrationSuccess == "valid" &&
                            registered == false) {
                          registered = true;
                          print("registration successfull>>>>>>>>>>>>");
                          CommonSuccessToastwidget(
                              toastmessage: "Please Enter OTP");
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => OtpVerificationScreen(
                                    type: "register",
                                    phnNumber: phoneNumberController.text),
                              )).then((value) {
                            registered = false;
                          });
                        } else if (state.registrationfailed != null) {
                          CommonToastwidget(
                              toastmessage: state.registrationfailed);
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state.registrationLoading == true) {
                          return const Center(
                            child: ThemeSpinner(),
                          );
                        }
                        return CommonButtonWidget(
                          buttontitle: "CONTINUE",
                          titlecolor: AppthemeColor().whiteColor,
                          buttonColor: AppthemeColor().appMainColor,
                          boardercolor: AppthemeColor().appMainColor,
                          buttonOnTap: () {
                            if (formkey.currentState!.validate()) {
                              if (lat != "" && long != "") {
                                Map<String, dynamic> bodyData = {
                                  "name": nameController.text,
                                  "address": addressController.text,
                                  "latitude": lat,
                                  "longitude": long,
                                  "mobile": phoneNumberController.text,
                                  "email": emailController.text,
                                  "gender": selectedOption,
                                  "language_known":
                                      selectedLanguagesList.join(","),
                                  "category_id": servicesidController.text,
                                };
                                context
                                    .read<RegistrationCubit>()
                                    .registerUser(registrationData: bodyData);
                              } else {
                                CommonToastwidget(
                                    toastmessage: "Please add address");
                              }
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void updateSelectedLanguages(List<dynamic> newList) {
    setState(() {
      selectedLanguagesList = newList;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppthemeColor().themecolor),
      ),
      onPressed: () async {
        Navigator.pop(context);
        await Geolocator.openAppSettings();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      content: const Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
            "Please ALLOW PERMISSION for location to continue \nPermissions=>Location=>Allow all the time"),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
