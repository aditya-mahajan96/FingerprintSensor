import 'package:backups/Utils/AppColors.dart';
import 'package:backups/Utils/ComonText.dart';
import 'package:backups/Utils/LocalStorage.dart';
import 'package:backups/pincode/PinSetup.dart';
import 'package:backups/pincode/PinUpdations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showEditPin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (AppStrings.setPIN != '') {
      showEditPin = true;
    } else {
      showEditPin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO :Add this
    if (AppStrings.setPIN != '') {
      showEditPin = true;
    } else {
      showEditPin = false;
    }
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Code by Aditya Mahajan ",textAlign: TextAlign.center,),
              SizedBox(
                height: 20,
              ),
              showEditPin == true ? showEditPinContainer() : setupPin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showEditPinContainer({text}) {
    return Column(children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      PinUpdations(updationType: "UpdatePin"))).then((value) {
            setState(() {});
          });
        },
        child: CommonTextWidget(
          text: 'Change Pin',
          fontSize: 15,
          fontColor: AppColor.color_black,
          fontWeight: FontWeight.w500,
          textAlignment: TextAlign.start,
          wordSpacing: 1.0,
          height: 1.5,
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      PinUpdations(updationType: "Remove"))).then((value) {
            setState(() {
              print("my pin IS ${AppStrings.setPIN} ");

              if (AppStrings.setPIN != '') {
                showEditPin = true;
              } else {
                showEditPin = false;
              }
            });
          });
        },
        child: CommonTextWidget(
          text: 'Remove Pin',
          fontSize: 15,
          fontColor: AppColor.color_black,
          fontWeight: FontWeight.w500,
          textAlignment: TextAlign.start,
          wordSpacing: 1.0,
          height: 1.5,
        ),
      ),
    ]);
  }

  Widget setupPin() {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => PinSetup(
                        sheetType: 'Normal',
                      ))).then((value) {
            setState(() {});
          });
        },
        child: CommonTextWidget(
          text: 'Set Pin',

          fontSize: 15,
        ),
      ),
    );
  }
}
