import 'package:backups/Utils/AppColors.dart';
import 'package:backups/Utils/ComonText.dart';
import 'package:backups/Utils/LocalStorage.dart';
import 'package:backups/Utils/common_action_botton.dart';
import 'package:backups/pincode/PinSetup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class PinUpdations extends StatefulWidget {

  String updationType="";
  PinUpdations({Key? key,required this.updationType}) : super(key: key);

  @override
  _PinUpdationsState createState() => _PinUpdationsState();
}

class _PinUpdationsState extends State<PinUpdations> {
  TextEditingController removePincontroller = TextEditingController(text: "");
  TextEditingController changePincontroller = TextEditingController(text: "");

  int pinLength = 4;
  bool hasError = false;
  late String errorMessage;


  @override
  void initState() {
    setState(() {
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
            headingText(),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.10,
            ),
            pinArea(controllerValue: widget.updationType == "Remove"?removePincontroller :changePincontroller),
            buttonType(
                buttonText: widget.updationType == "Remove"?'Done':'Continue'),
          ],
        ),
      ),
    );
  }

  ///HEADING
  Widget headingText() {
    return CommonTextWidget(
      text: widget.updationType == "Remove"?'Confirm Pin' :'Enter Current Pin',
      fontSize: 15,
      fontColor: AppColor.color_black,
      fontWeight: FontWeight.w500,
      textAlignment: TextAlign.start,
      wordSpacing: 1.0,
      height: 1.5,
    );
  }
  ///PIN AREA
  Widget pinArea({controllerValue}) {
    return Container(
      height: 100.0,
      child: GestureDetector(
        onLongPress: () {
        },
        child: PinCodeTextField(
          autofocus: true,
          controller: controllerValue,
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
        fontSize:16.0,
        isIcon: false,
        fontWeight: FontWeight.w600,
        onPressed: () {
          hitMethod(
              controllerType:
              widget.updationType == "Remove"? removePincontroller : changePincontroller);
        },
      ),
    );
  }
  ///APP HEADING
  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        padding: EdgeInsets.symmetric(horizontal: 20),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);

        },
      ),
      title: CommonTextWidget(
        text: widget.updationType == "Remove"?'Remove Pin' :'Change Pin',
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
      if (controllerType.text == AppStrings.setPIN) {
        if(controllerType == removePincontroller) {
          LocalStorage.setPinValue("");
          AppStrings.setPIN = '';
          showSnackBar(snackbarText: 'Pin Removed');
          Navigator.pop(context);
          setState(() {

          });
        }
        else
        {
          Navigator.pop(context);
          Navigator.push(context, CupertinoPageRoute(builder: (context) => PinSetup(sheetType: 'Change',)));
          setState(() {

          });

        }
      }
      else {
        showSnackBar(snackbarText: 'Pin Mismatched');
      }
    }
    else {
      showSnackBar(snackbarText: 'Please Fill Pin');
    }
  }
  void showSnackBar({required snackbarText}) {
    final snackBar = SnackBar(content: Text(snackbarText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
