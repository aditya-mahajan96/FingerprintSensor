import 'package:backups/Utils/AppColors.dart';
import 'package:backups/Utils/ComonText.dart';
import 'package:backups/Utils/LocalStorage.dart';
import 'package:backups/pincode/SplashPinScreen.dart';
import 'package:backups/pincode/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';





class TouchAuthentication extends StatefulWidget {
  String pinCodeValue="";
  String  hasSensors1="";
  bool isLockEnabled = false;
  TouchAuthentication({Key? key,required this.pinCodeValue,required this.hasSensors1,required this.isLockEnabled}) : super(key: key);

  @override
  _TouchAuthenticationState createState() => _TouchAuthenticationState();
}

class _TouchAuthenticationState extends State<TouchAuthentication> {

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;



  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Wrap(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      customTouchScreen(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 2,
                          color: Color(0xFFB6B6B6).withOpacity(0.2)),

                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        SplashPinScreen(pinCodeValue: widget
                                            .pinCodeValue)));
                          },
                          child: CommonTextWidget(
                            text:  'Enter Password',
                            fontSize: 16,
                            fontColor: AppColor.cancelButtonColor,
                            fontWeight: FontWeight.w500,
                            textAlignment: TextAlign.center,
                            wordSpacing: 1.0,
                            height: 1.5,
                          )),
                      Container(
                          height: 2,
                          color: Color(0xFFB6B6B6).withOpacity(0.2)),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(252, 252, 252, 0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget customTouchScreen()
  {
    return InkWell(
      onTap: ()
      {
        _authenticateWithBiometrics(context);
      },
      child: Column(
        children: [
          fingerPrint(),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextWidget(
              text: "Tap here to authenticate using ",
              fontSize: 15,
              fontColor: Colors.black,
              fontWeight: FontWeight.w400,
              textAlignment: TextAlign.center,
              wordSpacing: 1.0,
              height: 1.5,
            ),
          ),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextWidget(
              text: "Touch id/Face ID",
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.w700,
              textAlignment: TextAlign.center,
              wordSpacing: 1.0,
              height: 1.5,
            ),
          ),
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 20),
            child: CommonTextWidget(
              text: "Unlock to Access",
              fontSize: 13,
              fontColor: Colors.black,
              fontWeight: FontWeight.w500,
              textAlignment: TextAlign.center,
              wordSpacing: 1.0,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget fingerPrint()
  {
    return InkWell(
        onTap:()
        {
          _authenticateWithBiometrics(context);
        },
        child: SvgPicture.asset('assets/images/touch_id.svg'));
  }
  Future<void> _authenticateWithBiometrics(BuildContext context) async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,);
    } on PlatformException catch (e) {
      print(e);
      //Catch error here
      setState(() {
      });
      return;
    }
    if (!mounted) return;

    if(authenticated){
      AppStrings.setPIN = widget.pinCodeValue;
      _openHomePage();
    }else{


    }
  }
  void _openHomePage()
  {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()));
  }

}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
