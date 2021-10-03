import 'package:backups/Utils/AppColors.dart';
import 'package:backups/Utils/ComonText.dart';
import 'package:backups/Utils/LocalStorage.dart';
import 'package:backups/Utils/common_action_botton.dart';
import 'package:backups/pincode/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

class SplashPinScreen extends StatefulWidget {
  String pinCodeValue="";
  SplashPinScreen({Key? key,required this.pinCodeValue}) : super(key: key);

  @override
  _SplashPinScreenState createState() => _SplashPinScreenState();
}

class _SplashPinScreenState extends State<SplashPinScreen> {
  TextEditingController pintextController = TextEditingController(text: "");

  int pinLength = 4;
  bool hasError = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(left :30,right:30,top: 30 ),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(context),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.35,
              ),
             //headingText(),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.10,
              ),
              pinArea1(),
              bottomButton(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget pinArea1() {
    return Container(
      height: 100.0,
      child: GestureDetector(
        onLongPress: () {
          print("LONG");
        },
        child: PinCodeTextField(
          autofocus: true,
          controller: pintextController,
          hideCharacter: true,
          highlight: true,
          pinBoxColor: Colors.transparent,
          highlightColor: Colors.grey,
          defaultBorderColor: Colors.white,
          maxLength: pinLength,
          hasError: hasError,
          maskCharacter: "*",
          onTextChanged: (text) {
            setState(() {
              hasError = false;
            });
          },
          onDone: (text) {
          },
          pinBoxWidth: 50,
          pinBoxHeight: 64,
          hasUnderline: true,
          wrapAlignment: WrapAlignment.spaceAround,
          pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
          pinTextStyle: TextStyle(fontSize: 22.0,color: Colors.white),
          pinTextAnimatedSwitcherTransition:
          ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
          pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
//                    highlightAnimation: true,
          highlightAnimationEndColor: Colors.white12,
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Widget bottomButton() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: CommonActionBottonWidget(
        text: 'Continue',
        gradientEndColor: AppColor.gradientEndColor,
        gradientStartColor: AppColor.gradientStartColor,
        borderColor:  Colors.black,
        radius: 7.0,
        padding: 16.0,
        margin: 0.0,
        textColor:  Colors.white,
        fontSize: 16.0,
        isIcon: false,
        fontWeight: FontWeight.w600,
        onPressed: () {
          hitMethod();
        },
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: SizedBox(),
      title: CommonTextWidget(
        text: 'Enter Pin',
        fontSize: 22,
        fontColor:  Colors.white,
        fontWeight: FontWeight.w500,
        textAlignment: TextAlign.center,
        wordSpacing: 1.0,
        height: 1.5,
      ),
    );
  }
  void _openHomePage()
  {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen()));
  }
  void hitMethod() {

    if (pintextController.text.length == 4) {
      if (widget.pinCodeValue == pintextController.text) {
        AppStrings.setPIN=pintextController.text;
        _openHomePage();
      }  else {
        showSnackBar(snackbarText: 'Pin Mismatched');
      }
    } else {
      showSnackBar(snackbarText: 'Please fill the pin code');
    }
  }

  void showSnackBar({required snackbarText}) {
    final snackBar = SnackBar(content: Text(snackbarText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
