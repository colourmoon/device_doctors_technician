import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deep_route/deep_material_app.dart';
import 'package:device_doctors_technician/Notification/awesome_notification/notification_channel_service.dart';
import 'package:device_doctors_technician/Notification/notification_implementation.dart';
import 'package:device_doctors_technician/ram_narayan_demo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:device_doctors_technician/Service_professional/notifications/logic/cubit/notifications_data_cubit.dart';
import 'package:device_doctors_technician/Service_professional/notifications/repository/notifications_repository.dart';
import 'package:device_doctors_technician/Service_professional/registration/splash/screen/splash_screen.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/help_and_support/logic/cubit/help_and_support_cubit.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/more_options_repository.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/payout_history/cubit/payout_history_cubit.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/referals/cubit/referral_list_cubit.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/terms_and_conditions/cubit/cms_data_cubit.dart';
import 'package:device_doctors_technician/firebase_options.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import 'Service_professional/internet_handler/logic/internet/internet_cubit.dart';
import 'Service_professional/registration/login/logic/cubit/login_cubit.dart';
import 'Service_professional/registration/registrationflow/bank_details/logic/cubit/bank_details_cubit.dart';
import 'Service_professional/registration/registrationflow/kyc_details/cubit/kyc_cubit.dart';
import 'Service_professional/registration/registrationflow/profile_verification/cubit/profile_verfication_cubit.dart';
import 'Service_professional/registration/registrationflow/registrationScreen/logic/cubit/registration_cubit.dart';
import 'Service_professional/registration/registrationflow/registrationScreen/repository/registration_repo.dart';
import 'Service_professional/registration/registrationflow/service_categories/logic/cubit/service_categories_cubit.dart';
import 'Service_professional/registration/registrationflow/upload_photo/logic/cubit/upload_profile_photo_cubit.dart';
import 'Service_professional/registration/splash/maintainenceMode/logic/bloc/maintainence_mode_bloc.dart';
import 'Service_professional/registration/splash/maintainenceMode/repository/maintainance_repo.dart';
import 'Service_professional/services_bottombar/logic/cubit/services_bottom_bar_cubit.dart';
import 'Service_professional/services_bottombar/logic/orderscountcubit/orders_count_cubit.dart';
import 'Service_professional/services_bottombar/screen/services_bottombar_screen.dart';
import 'Service_professional/services_home/more_options/all_orders/logic/cubit/all_orders_cubit.dart';
import 'Service_professional/services_home/more_options/cod_cash/logic/cubit/cod_cash_cubit.dart';
import 'Service_professional/services_home/more_options/customer_tips/logic/cubit/cusomer_tips_cubit.dart';
import 'Service_professional/services_home/more_options/help_and_support/logic/cubit/image_upload_cubit.dart';
import 'Service_professional/services_home/more_options/help_and_support/update_profile_details/logic/cubit/updat_profile_cubit.dart';
import 'Service_professional/services_home/more_options/payout_history/cubit/cubit/payout_details_cubit.dart';
import 'Service_professional/services_home/more_options/profile/logic/cubit/profile_cubit.dart';
import 'Service_professional/services_home/more_options/ratings/logic/cubit/ratings_cubit.dart';
import 'Service_professional/services_home/more_tab/logic/cubit/logout_cubit.dart';
import 'Service_professional/services_home/new_orders/logic/cubit/new_orders_cubit.dart';
import 'Service_professional/services_home/service_details/logic/cubit/service_details_cubit.dart';
import 'Service_professional/services_home/service_details/logic/quoteCubit/cubit/create_qoute_cubit.dart';
import 'Service_professional/services_home/service_details/logic/saved_devices_cubit.dart';
import 'Service_professional/services_home/service_details/logic/sendqoute/cubit/send_quote_cubit.dart';
import 'Service_professional/services_home/service_details/logic/service_cart_cubit/service_cart_cubit.dart';
import 'Service_professional/services_home/services_tab/logic/cubit/services_cubit.dart';
import 'Service_professional/update_push_token_cubit/cubit/update_push_token_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  // Constants.prefs = await SharedPreferences.getInstance();
 SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));


  // FirebaseMessaging.instance.getToken().then((value) {
  //   print('Push Notification Firebase Token: ${value}');
  //   SharedPref().setString('firebase_device_token', value.toString());
  // });
  runApp(const MyApp());
}

// Future<void> retriveNotificationBackgroundState() async {
//   final lastNotification = await FirebaseMessaging.instance.getInitialMessage();
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});
// The navigator key is necessary to navigate using static methods

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    String sound = 'resource://raw/warning';

    final notification = NotificationImplementation(
      awesomeChannelService: AwesomeChannelService(sound: sound
        // sound: _sound,
      ),
    );
    notification.initialize();
    notification.fcmInitialize(context);
    super.initState();
  }

  MaterialColor createMaterialColor(Color color) {
    List<int> strengths = <int>[
      50,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900
    ];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int strength in strengths) {
      swatch[strength] = Color.fromRGBO(r, g, b, strength / 900);
    }

    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    print("navigator key");
    // print(MyApp.navigatorKey.currentContext);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => MoreOptionsRepository()),
        RepositoryProvider.value(value: MaintainanceModeRepository()),
        // service repositories
        RepositoryProvider<NotificationsRepository>(
          create: (context) => NotificationsRepository(),
        ),
        RepositoryProvider<RegistrationRepository>(
          create: (context) => RegistrationRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // services bloc providers
          BlocProvider(
            create: (context) => ServicesBottomBarCubit(),
          ),
          BlocProvider(
            create: (context) => ServicesCubit(),
          ),
          BlocProvider(
            create: (context) => RegistrationCubit(),
          ),
          BlocProvider(
            create: (context) => ServiceCartCubit(),
          ),
          BlocProvider(
            create: (context) => SavedDevicesCubit(),
          ),
          BlocProvider(
            create: (context) => CusomerTipsCubit(),
          ),
          BlocProvider(
            create: (context) => CodCashCubit(),
          ),
          BlocProvider(
            create: (context) => BankDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => UpdatePushTokenCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(),
          ),
          BlocProvider(
            create: (context) => NewOrdersCubit(),
          ),
          BlocProvider(
            create: (context) => SendQuoteCubit(),
          ),
          BlocProvider(
            create: (context) => ReferralListCubit(),
          ),
          BlocProvider(
            create: (context) => CmsDataCubit(),
          ),

          BlocProvider(
            create: (context) => HelpAndSupportCubit(),
          ),
          BlocProvider(
            create: (context) => PayoutHistoryCubit(),
          ),
          BlocProvider(
            create: (context) => OrdersCountCubit(),
          ),

          BlocProvider(
            create: (context) => RatingsCubit(),
          ),
          BlocProvider(
            create: (context) => UpdatProfileCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileVerficationCubit(),
          ),
          BlocProvider(
            create: (context) => UploadProfilePhotoCubit(),
          ),
          BlocProvider(
            create: (context) => AllOrdersCubit(),
          ),
          BlocProvider(
            create: (context) => ServiceDetailsCubit(),
          ),

          BlocProvider(
            create: (context) => LogoutCubit(),
          ),
          BlocProvider(
            create: (context) =>
                NotificationsDataCubit(context.read<NotificationsRepository>()),
          ),
          BlocProvider(
            create: (context) => InternetCubit(connectivity: Connectivity()),
          ),
          BlocProvider(
            create: (context) => MaintainenceModeBloc(
                maintinanceRepo: MaintainanceModeRepository()),
          ),
          BlocProvider(
            create: (context) => ServiceCategoriesCubit(),
          ),

          BlocProvider(
            create: (context) => PayoutDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => KycCubit(),
          ),
        ],
        child: Center(
          child: DeepMaterialApp(
            // key: MyApp.navigatorKey,
            debugShowCheckedModeBanner: false,
            // initialBinding: NetworkBinding(),
            navigatorKey: navigatorKey,
            title: 'Tech House Professional',
            theme: ThemeData(
              useMaterial3: false,
              primarySwatch: createMaterialColor(Colors.black),
            ),
            home: const SrvicesSplashScreen(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            // initialRoute: "splash",
            // routes: Routes.getRoutes(),
          ),
        ),
      ),
    );
    //   MultiBlocProvider(
    //   providers: [
    //     // BlocProvider(create: (context) => ConnectivityCubit(Connectivity()),),
    //     // BlocProvider(create: (context) => CheckCubit(),),
    //     // BlocProvider(create: (context) => ImageSliderCubit(),),
    //     // BlocProvider(create: (context) => SigInCubit(),),
    //     // BlocProvider(create: (context) => ForgotPasswordCubit(),),
    //     // BlocProvider(create: (context) => SigUpCubit(),),
    //     // BlocProvider(create: (context) => ResetPasswordCubit(),),
    //     // BlocProvider(create: (context) => ImageChangeCubit(),),
    //     // BlocProvider(create: (context) => TimerCubit(),),
    //     // BlocProvider(create: (context) => LocationBloc(),),
    //   ],
    //   child:
    // );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
