import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  height: 85,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.red.withOpacity(0.07)
                                : Color(0xff222C44).withOpacity(0.07),
                            blurRadius: 6,
                            offset: Offset(0, 3))
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24, right: 24, top: 28),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Image.asset('images/location-map.png',fit: BoxFit.contain,height: 20,),
                                    Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? head
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    width: double.infinity,
                    height: 589,
                    color:
                        ThemeProvider.of(context).brightness == Brightness.light
                            ? Color(0xffF7F8F8)
                            : Color(0xff222C44),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Comiida built the Comiida app as a Commercial app. This SERVICE is provided by Comiida and is intended for use as is.\n\n"
                            "If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. "
                            "The Personal Information that we collect is used for providing and improving the Service."
                            " We will not use or share your information with anyone except as described in this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Comiida unless otherwise defined in this Privacy Policy.",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                                height: 1.8),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              Text(
                                'Cookies',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: ThemeProvider.of(context).brightness ==
                                          Brightness.light
                                      ? head
                                      : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers.These are sent to your browser from the websites that you visit and are stored on your device's internal memory.",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: ThemeProvider.of(context).brightness ==
                                        Brightness.light
                                    ? head
                                    : Colors.white,
                                fontSize: 12,
                                height: 1.8),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
