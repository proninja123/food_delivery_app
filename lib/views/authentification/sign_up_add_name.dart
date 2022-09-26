import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/views/authentification/signup_add_email.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/utils/user_current_location.dart';
import 'package:food_delivery/views/home_ui/automatic_location/automatic_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';

import '../../utils/app_colors.dart';
import 'add_your_lcoation.dart';
import 'select_location_page.dart';

class Addname extends StatefulWidget {
  final bool isGoogle;

  final bool isFb;

  final bool isPhone;

  final GoogleSignInAccount user;
  final String userNumber;
  final Map<String, dynamic> facebookUserData;

  Addname({
    this.isGoogle = false,
    this.isFb = false,
    this.isPhone = true,
    this.user,
    this.userNumber,
    this.facebookUserData,
  });

  @override
  _AddnameState createState() => _AddnameState();
}

class _AddnameState extends State<Addname> with BaseClass {
  FocusNode name = new FocusNode();
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // do stuff after frame is build

      FocusScope.of(context).requestFocus(name);
    });
    super.initState();
    if (widget.isGoogle && widget.user != null) {
      _editingController.text = widget.user.displayName;
    } else if (widget.isFb && widget.facebookUserData != null) {
      _editingController.text = widget.facebookUserData['name'];
    }

    setUpUserLocation();
  }

  setUpUserLocation() async {
    LocationData locationData = await UserCurrentLocation().getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 36.0, top: 61, bottom: 65),
                    child: Icon(
                      Icons.arrow_back,
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? head
                          : Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 37.0, right: 37, top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Awesome!\nPhone verified.",
                        style: TextStyle(
                            fontSize: 29,
                            fontFamily: 'Montserrat',
                            color: button_red,
                            height: 1.2,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        "We need to know your name to set-up\nyour account.",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head
                                : Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 36.0, right: 36, top: 24, bottom: 68),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your name',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: button_red,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      TextField(
                        focusNode: name,
                        controller: _editingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Name",
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? head.withOpacity(0.45)
                                : Colors.white.withOpacity(0.45),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: ThemeProvider.of(context).brightness ==
                                  Brightness.light
                              ? head
                              : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Divider(
                          thickness: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28, top: 0),
                  child: InkWell(
                    onTap: () {
                      if (_editingController.text.trim().isEmpty) {
                        showError('Name', 'Name cannot be empty');
                        return;
                      }
                      pushToNextScreenWithAnimation(
                        context: context,
                        destination: /*AddYourLocationPage*/AutomaticLocationPage(
                          userName: _editingController.text.trim(),
                          isGoogle: widget.isGoogle,
                          isFb: widget.isFb,
                          isPhone: widget.isPhone,
                          user: widget.user,
                          userNumber: widget.userNumber,
                          facebookUserData: widget.facebookUserData,
                          userEmail: widget.isFb || widget.isGoogle
                              ? widget.isFb
                                  ? widget.facebookUserData['email']
                                  : widget.isGoogle
                                      ? widget.user.email
                                      : ''
                              : '',
                        ),
                      );
                      /*  pushToNextScreenWithAnimation(
                        context: context,
                        destination: SignUpAddEmailPage(
                          userName: _editingController.text.trim(),
                          isGoogle: widget.isGoogle,
                          isFb: widget.isFb,
                          isPhone: widget.isPhone,
                          user: widget.user,
                          userNumber: widget.userNumber,
                          facebookUserData: widget.facebookUserData,
                        ),
                      );*/
                      /* Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SelectLocation(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));*/
                    },
                    child: FilledButton(
                      btnHeight: 56,
                      btnRadius: 8,
                      btnColor: button_red,
                      btnText: "Start Ordering",
                      btnTextColor: Colors.white,
                      btnFontWeight: FontWeight.w400,
                    ) /*Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: button_red,
                      ),
                      height: 56,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Start Ordering',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )*/
                    ,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -122,
              right: -201,
              child: SvgPicture.asset(
                'images/svg/_Compound Path_.svg',
                matchTextDirection: true,
                color: button_red.withOpacity(0.05),
                height: 262,
                width: 365,
                fit: BoxFit.contain, //Color(0xff515970),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
