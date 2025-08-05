import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../commons/color_codes.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  Future<void> _requestLocationPermission(BuildContext context) async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      Navigator.pop(context); // Go back after permission is granted
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Open settings if permanently denied
    }
    // else: do nothing if denied temporarily
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
                Icon(Icons.location_on, size: 80, color: AppthemeColor().appMainColor,),
              const SizedBox(height: 24),
              const Text(
                'Enable Location Services',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily:  'ProximaNova',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
                Text(
                '''To help customers find and book your services accurately, we require access to your location during registration. By sharing your location, your service will appear in relevant local searches and be visible to nearby users. This improves your visibility and helps us ensure a seamless booking experience for both you and your customers.''',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontFamily:  'ProximaNova',
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _requestLocationPermission(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: AppthemeColor().appMainColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_location, size: 20, color: AppthemeColor().whiteColor,),
                      SizedBox(width: 10,),
                      const Text(
                        'Allow Location Access',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                          fontFamily:  'ProximaNova',),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context), // Just go back
                child: const Text(
                  'Skip for now',
                  style: TextStyle(fontSize: 15, color: Colors.grey,
                    fontFamily:  'ProximaNova',),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
