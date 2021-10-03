import 'package:backups/Utils/AppColors.dart';
import 'package:backups/Utils/ComonText.dart';
import 'package:backups/Utils/LocalStorage.dart';
import 'package:backups/Utils/common_action_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

class PinSetup extends StatefulWidget {
  String sheetType ="";
  PinSetup({Key? key,required this.sheetType}) : super(key: key);

  @override
  _PinSetupState createState() => _PinSetupState();
}

class _PinSetupState extends State<PinSetup> {
  TextEditingController newPincontroller = TextEditingController(text: "");
  TextEditingController confirmPincontroller = TextEditingController(text: "");

  int pinLength = 4;
  bool hasError = false;
  FocusNode _focus_PinArea2 = FocusNode();
  int _screenType = 1;
  String _newPin = "";




  @override
  void initState() {
    setState(() {
      _focus_PinArea2 = FocusNode();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.35,
            ),
            widget.sheetType == 'Change'?changePinHeading() :headingText(),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.10,
            ),
            displayPinArea(screenType :_screenType),
            buttonType(
              buttonText: _screenType == 1
                  ? 'Continue'
                  : 'Done',
            )
          ],
        ),
      ),
    );
  }
  Widget displayPinArea({screenType})
  {
    return screenType == 1 ?pinArea1() : pinArea2();
  }

  Widget headingText() {
    return CommonTextWidget(
      text: _screenType == 1 ? 'Confirm New Pin' : 'Confirm Pin',
      fontSize:15,
      fontColor: AppColor.color_black,
      fontWeight: FontWeight.w500,
      textAlignment: TextAlign.start,
      wordSpacing: 1.0,
      height: 1.5,
    );
  }
  Widget changePinHeading() {
    return CommonTextWidget(
      text: _screenType == 1 ?'Enter New Pin': 'Enter Pin',
      fontSize: 15,
      fontColor: AppColor.color_black,
      fontWeight: FontWeight.w500,
      textAlignment: TextAlign.start,
      wordSpacing: 1.0,
      height: 1.5,
    );
  }

  Widget pinArea1() {
    return Container(
      height: 100.0,
      child: GestureDetector(
        onLongPress: () {
        },
        child: PinCodeTextField(
          autofocus: true,
          controller: newPincontroller,
          // hideCharacter: true,
          highlight: true,
          highlightColor: AppColor.gradientStartColor,
          defaultBorderColor: Colors.black,
          maxLength: pinLength,
          hasError: hasError,
          // maskCharacter: "*",
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
          pinTextStyle: TextStyle(fontSize: 22.0),
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
  Widget pinArea2() {

    return GestureDetector(
      onLongPress: () {
      },
      child: PinCodeTextField(
        autofocus: true,
        focusNode: _focus_PinArea2,
        controller: confirmPincontroller,
        // hideCharacter: true,
        highlight: true,
        highlightColor: AppColor.gradientStartColor,
        defaultBorderColor: Colors.black,
        maxLength: pinLength,
        hasError: hasError,
        // maskCharacter: "*",
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
        pinTextStyle: TextStyle(fontSize: 22.0),
        pinTextAnimatedSwitcherTransition:
        ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
        pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
//                    highlightAnimation: true,
        highlightAnimationEndColor: Colors.white12,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buttonType({buttonText}) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: CommonActionBottonWidget(
        text: buttonText,
        gradientEndColor: AppColor.gradientEndColor,
        gradientStartColor: AppColor.gradientStartColor,
        borderColor: AppColor.color_black,
        radius: 7.0,
        padding: 16.0,
        margin: 0.0,
        textColor: AppColor.colorWhite,
        fontSize: 16.0,
        isIcon: false,
        onPressed: () {
          hitMethod(
              controllerType:
              _screenType == 1 ? newPincontroller : confirmPincontroller);
        },
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        padding: EdgeInsets.symmetric(horizontal:20),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          if(_screenType ==1) {
            Navigator.pop(context);
          }
          else
          {

            confirmPincontroller.clear();
            _screenType =1;
            setState(() {

            });
          }

        },
      ),
      title: CommonTextWidget(
        text: 'Set Pin',
        fontSize: 22,
        fontColor: AppColor.color_black,
        fontWeight: FontWeight.w500,
        textAlignment: TextAlign.center,
        wordSpacing: 1.0,
        height: 1.5,
      ),
    );
  }

  void hitMethod({controllerType}) {
    if (controllerType.text.length == 4) {
      if (_screenType == 1) {
        _newPin = newPincontroller.text;
        _screenType = 2;
        _focus_PinArea2.requestFocus();
        confirmPincontroller.clear();
        setState(() {

        });
      } else if (_screenType == 2 && _newPin == controllerType.text) {
        LocalStorage.setPinValue(_newPin);
        AppStrings.setPIN = _newPin;
        Navigator.pop(context);
        showSnackBar(snackbarText: 'Pin Saved');
      } else {
        showSnackBar(snackbarText: 'Pin Mismatched');
      }
    } else {
      showSnackBar(snackbarText: 'Please fill Pin');
    }
  }





void showSnackBar({required snackbarText}) {
    final snackBar = SnackBar(content: Text(snackbarText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);


  }


}
