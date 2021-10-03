import 'dart:async';

import 'package:backups/Utils/LocalStorage.dart';
import 'package:backups/fingerprint/TouchAuthentication.dart';
import 'package:backups/pincode/PinSetup.dart';
import 'package:backups/pincode/SplashPinScreen.dart';
import 'package:backups/pincode/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';




//TODO :
// Step 1 : Change android kotlin file like this project "Main Activity.kt"
//Step 2 : :Add permission of internet in andorid mainfest

/// Step 3 : For ios Add permission in ios Runner- Info.plist
// like this project ios - runner- NSFaceIDUsageDescription Line number 25 and 26


//Step 4 :Then add this code



class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  bool hasFingerprint = false;
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;

  String hasSensors = "";
  @override
  void initState() {
    fetchValue();
    Timer(Duration(seconds: 3), _navigatorScreens);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.green));
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child:  Text("Code by Aditya Mahajan",textAlign: TextAlign.center,),
          )),
    );
  }

///Biometric verification Code
  Future<void> _authenticateWithBiometrics({context, pinCodeValue}) async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
      _openPinCodeScreen(localPinCodeValue:pinCodeValue);
      //Catch error here
      setState(() {
      });
      return;
    }
    if (!mounted) return;
    if (authenticated) {
      AppStrings.setPIN = pinCodeValue;
      //_dummyFingerprint();
      _openHomeScreen();
    } else {
      _openPinAuthenticationScreen(isLockEnabled :true,localPinCodeValue:pinCodeValue,hasSensors :hasSensors );
    }
  }

  ///Checking sensors
  void fetchValue() {
    auth.isDeviceSupported().then(
          (isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
    if (_supportState == _SupportState.unknown) {
      hasSensors = "1";
    } else if (_supportState == _SupportState.supported) {
      hasSensors = "1";
    } else {
      hasSensors = "2";
    }
  }

  void _navigatorScreens() {
    String pinCodeValue = "";
    LocalStorage.getPinValue().then((value) {
      pinCodeValue = value;
      print("Splash screen pin value is $pinCodeValue");
      if (pinCodeValue == "") {
        ///////********** IF pin value is empty**************
        _openHomeScreen();
      } else {
        ////////**********  pin value not empty**************
        if (hasSensors == "1") {
          _authenticateWithBiometrics(
              context: context, pinCodeValue: pinCodeValue);
        } else {
          fetchValue();
          _openPinAuthenticationScreen(isLockEnabled :true,localPinCodeValue:pinCodeValue,hasSensors :hasSensors );
        }
      }
    });
  }


  //Means pin code is not activated in this app
  void _openHomeScreen()
  {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()));
  }


  void _openPinAuthenticationScreen({isLockEnabled,localPinCodeValue,hasSensors})
  {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TouchAuthentication(
              isLockEnabled:isLockEnabled,
              pinCodeValue: localPinCodeValue,
              hasSensors1: hasSensors,
            )));
  }


  ///Means phone has not allowed fingerprint in it
  ///
  void _openPinCodeScreen({localPinCodeValue})
  {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                SplashPinScreen(pinCodeValue:localPinCodeValue)));
  }
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}

