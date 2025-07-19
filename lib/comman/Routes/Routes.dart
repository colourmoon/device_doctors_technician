import 'package:flutter/material.dart';

import '../../Service_professional/registration/onboarding/sceeen/onboarding_screen.dart';
import '../../Service_professional/registration/splash/screen/splash_screen.dart';
import '../../network_connectivity/noInternet_connection.dart';
import '../../widget/Animation/FadeRouteAnimation.dart';
import '../../widget/CustomWidget/OverScroll.dart';
import '../../widget/CustomWidget/bottombar.dart';

class Routes {
  static FadeRoute onNavigate({required Widget page}) {
    print(page);
    return FadeRoute(page: SafeArea(child: OverScrollOff(child: page)));
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      "splash": (context) => const SrvicesSplashScreen(),
      "/OnBoarding": (context) => const ServicesOnboardingScreen(),
      // "/nointernet": (context) => NoInterNetScreen(),
    };
  }
}
