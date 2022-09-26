import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/custom_widgets/edittext_with_hint.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/custom_widgets/form_input.dart';
import 'package:food_delivery/custom_widgets/form_input_with_hint_on_top.dart';
import 'package:food_delivery/models/create_user_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/utils/user_current_location.dart';
import 'package:food_delivery/view_models/shared_pref_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddYourLocationPage extends StatefulWidget {
  final String userName;
  final String userNumber;
  final String userEmail;
  final bool isGoogle;

  final bool isFb;

  final bool isPhone;

  final GoogleSignInAccount user;
  final Map<String, dynamic> facebookUserData;

  AddYourLocationPage({
    this.userNumber,
    this.userEmail,
    this.isGoogle = false,
    this.isFb = false,
    this.isPhone = true,
    this.user,
    this.userName,
    this.facebookUserData,
  });

  @override
  _AddYourLocationPageState createState() => _AddYourLocationPageState();
}

class _AddYourLocationPageState extends State<AddYourLocationPage>
    with BaseClass {
  FocusNode _addressNode = FocusNode();
  AuthRepository _authRepository = AuthRepository();
  FocusNode _nameNode = FocusNode();
  FocusNode _extraInfoNode = FocusNode();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _extraInfoController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  String city = '', state = '', country = '';
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyCJTzg3gjHZrlrTDDecgRJUMwipOuxpFqU');
  double userLat = 0.0, userLong = 0.0;
  final Set<Marker> _markers = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.7333, 76.7794),
    zoom: 12,
  );
  var bitmapIcon;

  _getCustomMarker() async {
    bitmapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(500, 500)), 'images/map_circle.png');
  }

  Future<void> _gotToCurrentLocation(double lat, double lng) async {
    CameraPosition _kLake = CameraPosition(
       // bearing: 192.8334901395799,
        target: LatLng(lat, lng),
        //tilt: 59.440717697143555,
        zoom: 14);
    _markers.add(
      Marker(
          markerId: MarkerId('myMarker'),
          draggable: false,
          onTap: () {
            print('marker tapped');
          },
          position: LatLng(lat, lng),
        /*  icon: bitmapIcon*/),
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    getGeoAddressFromLatLong(LatLng(lat, lng));
    setState(() {
      userLat = lat;
      userLong = lng;
    });
  }

  Future<void> _moveCamera(double lat, double lng) async {
    CameraPosition _kLake = CameraPosition(
       // bearing: 192.8334901395799,
        target: LatLng(lat, lng),
       // tilt: 59.440717697143555,
        zoom: 14);
    _markers.add(
      Marker(
          markerId: MarkerId('myMarker'),
          draggable: false,
          onTap: () {
            print('marker tapped');
          },
          position: LatLng(lat, lng),
          /*icon: bitmapIcon*/),
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserCurrentLatLong();
  }

  void _getUserCurrentLatLong() async {
    _getCustomMarker();
    LocationData locationData = await UserCurrentLocation().getUserLocation();
    print(locationData);
    _gotToCurrentLocation(locationData.latitude, locationData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    var sharePrefProvider = Provider.of<SharedPrefProvider>(context);
    return Container(
      color: ThemeProvider.of(context).brightness == Brightness.light
          ? Colors.white
          : Color(0xff222C44),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: ThemeProvider.of(context).brightness ==
                                    Brightness.light
                                ? Colors.red.withOpacity(0.07)
                                : Color(0xff222C44).withOpacity(0.07),
                            spreadRadius: 20,
                            blurRadius: 20,
                            offset: Offset(0, 5))
                      ],
                      color: ThemeProvider.of(context).brightness ==
                              Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: ThemeProvider.of(context).brightness ==
                                      Brightness.light
                                  ? head
                                  : Colors.white,
                              size: 28,
                            )),
                        SizedBox(
                          width: 43,
                        ),
                        Text(
                          'Select your location',
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
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Container(
                  height: Get.height * 0.4,
                  color: Colors.red,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.terrain,
                    markers: _markers,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.4),
                decoration: BoxDecoration(
                  color:
                      ThemeProvider.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Color(0xff222C44),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: ThemeProvider.of(context).brightness ==
                                Brightness.light
                            ? Colors.red.withOpacity(0.07)
                            : Color(0xff222C44).withOpacity(0.07),
                        blurRadius: 6,
                        offset: Offset(0, 3))
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 36.0, right: 36, top: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_red,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: _addressNode,
                                    controller: _addressController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabled: false,
                                      hintText: "Address",
                                      hintStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: ThemeProvider.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? head.withOpacity(0.45)
                                            : Colors.white.withOpacity(0.45),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: ThemeProvider.of(context)
                                                  .brightness ==
                                              Brightness.light
                                          ? head
                                          : Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      try {
                                        Prediction p =
                                            await PlacesAutocomplete.show(
                                          context: context,

                                          apiKey:
                                              'AIzaSyCJTzg3gjHZrlrTDDecgRJUMwipOuxpFqU',
                                          language: 'en',
                                          types: ["geocode"],
                                          strictbounds: false,
                                          radius: 500,
                                          components: [
                                            Component(Component.country, 'us'),
                                            Component(Component.country, 'in'),
                                            Component(Component.country, 'fr'),
                                            Component(Component.country, 'cl'),
                                          //  Component(Component.country, 'af'),
                                           // Component(Component.country, 'al'),
                                            Component(Component.country, 'dz'),


                                          ],
                                          mode: Mode.overlay,
                                        );
                                        if (p != null) {
                                          PlacesDetailsResponse detail =
                                              await _places.getDetailsByPlaceId(
                                                  p.placeId);
                                          setState(() {
                                            userLat = detail
                                                .result.geometry.location.lat;
                                            userLong = detail
                                                .result.geometry.location.lng;
                                          });
                                          final coordinates = new Coordinates(
                                              detail
                                                  .result.geometry.location.lat,
                                              detail.result.geometry.location
                                                  .lng);
                                          final address = await Geocoder.local
                                              .findAddressesFromCoordinates(
                                                  coordinates);
                                          _moveCamera(userLat, userLong);
                                          setState(() {
                                            /* controlCity.text = address.first.locality;
                                        controlCountry.text=address.first.countryName;*/
                                            country = address.first.countryName;
                                            state = address.first.locality;
                                            _addressController.text =
                                                address.first.addressLine;
                                          });
                                        }
                                      } catch (onError) {
                                        print(onError.toString());
                                      }
                                      /* if (p != null) {

                                    PlacesDetailsResponse detail =
                                    await _places.getDetailsByPlaceId(p.placeId);
                                    setState(() {
                                      userLat = detail.result.geometry.location.lat;
                                      userLang = detail.result.geometry.location.lng;
                                    });
                                    final coordinates = new Coordinates(detail.result.geometry.location.lat, detail.result.geometry.location.lng);
                                    final address =
                                    await Geocoder.local.findAddressesFromCoordinates(coordinates);
                                    setState(() {
                                      controlCity.text = address.first.locality;
                                      controlCountry.text=address.first.countryName;
                                      userLocation = address.first.addressLine;
                                    });
                                  }*/
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.red,
                                    )),
                              ],
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
                        padding: const EdgeInsets.only(
                          left: 36.0,
                          right: 36,
                          top: 24,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'City',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_red,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            TextField(
                              focusNode: _nameNode,
                              controller: _cityController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "City",
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
                        padding: const EdgeInsets.only(
                          left: 36.0,
                          right: 36,
                          top: 24,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Extra information',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: button_red,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            TextField(
                              focusNode: _extraInfoNode,
                              controller: _extraInfoController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Landmarks, apartment floor etc.",
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
                        padding:
                            EdgeInsets.only(left: 28.0, right: 28, top: 25),
                        child: InkWell(
                          onTap: () async {
                            if (_addressController.text.trim().isEmpty) {
                              showError('Address', 'Address cannot be empty');
                            } else if (_cityController.text.trim().isEmpty) {
                              showError('City', 'City cannot be empty');
                            } /*else if (_extraInfoController.text
                                .trim()
                                .isEmpty) {
                              showError('Extra information',
                                  'Extra information cannot be empty');
                            }*/ else {
                              try {
                                showCircularDialog(context);
                                print(widget.userName.split(' ').length);
                                CreateUserModel createUserModel =
                                    await _authRepository
                                        .createUserWithSocialMedia({
                                  'name': widget.userName,
                                  'ssmauth': getIdParam(),
                                  /*widget.isGoogle != null
                                      ? widget.isGoogle
                                          ? 'gg-' + widget.user.id
                                          : ''
                                      : '',*/
                                  /*'ssmauth': widget.isFb != null
                                      ? widget.isFb
                                          ? 'fb-' +
                                              widget.facebookUserData['id']
                                          : ''
                                      : '',*/
                                  'email': widget.userEmail,
                                  'password': 'testing',
                                  'fname': widget.userName.split(' ')[0].trim(),
                                  'lname': widget.userName.split(' ').length > 1
                                      ? widget.userName.split(' ')[1].trim()
                                      : '',
                                  'phone': widget.userNumber,
                                  'whatsapp': widget.userNumber,
                                  'lat': userLat.toString(),
                                  'lng': userLong.toString(),
                                  'username': widget.userEmail,
                                  'city': _cityController.text.trim(),
                                  'state': state,
                                  'address': _addressController.text.trim(),
                                  'country': country,
                                });
                                if (createUserModel != null) {
                                  UserDataModel userModel = new UserDataModel();
                                  userModel.setUserId(createUserModel.iD);
                                  userModel.setUserEmail(widget.userEmail);
                                  userModel.setUserName(widget.userName);
                                  userModel.setPhoneNumber(widget.userNumber);
                                  userModel.setLogin(true);
                                  sharePrefProvider
                                      .saveSharedPreference(userModel);
                                  popToPreviousScreen(context: context);
                                  pushReplaceAndClearStack(
                                      context: context,
                                      destination: BottomBar());
                                } else {
                                  popToPreviousScreen(context: context);
                                }
                              } catch (onError) {
                                print(onError.toString());
                                popToPreviousScreen(context: context);
                              }
                            }
                          },
                          child: FilledButton(
                            btnHeight: 56,
                            btnRadius: 8,
                            btnColor: button_red,
                            btnText: "Confirm",
                            btnTextColor: Colors.white,
                            btnFontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getGeoAddressFromLatLong(LatLng centerLatLng) async {
    final coordinates =
        Coordinates(centerLatLng.latitude, centerLatLng.longitude);
    print(coordinates);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(first);
    print("ADMIN Area -> " + first.adminArea);
    print("Address line -> " + first.addressLine);
    print("Address country code -> " + first.countryCode);
    print("Country name -> " + first.countryName);
    print("Feature name -> " + first.featureName);
    print("Locality -> " + first.locality);
    print("Postal code -> " + first.postalCode);
    print("Sub admin Area -> " + first.subAdminArea);
    print("Sub locality -> " + first.subLocality);
    print("Sub thorough fare -> " + first.subThoroughfare.toString());
    print("thorough fare -> " + first.thoroughfare.toString());

    // addressLine = first.addressLine;
    _addressController.text = first.addressLine;
    country = first.countryName;
    state = first.locality;
    print(first.addressLine);
    print('ADDDDRFESSS');

    /* countryCode = first.countryCode;
    countryName = first.countryName;
    postalCode = first.postalCode;
    adminArea = first.adminArea;
    featureName = first.featureName;
    locality = first.locality;
    subLocality = first.subLocality;*/
    /*formattedAddress = "address line:- $addressLine  country code:- $countryCode countryName:- $countryName postalCode:- $postalCode adminArea:- $adminArea"
        " locality:- $locality featureName:- $featureName subLocality:- $subLocality";*/

    setState(() {});
  }

  String getIdParam() {
    if (widget.isGoogle != null) {
      if (widget.isGoogle) {
        return 'gg-' + widget.user.id;
      } else if (widget.isFb != null) {
        if (widget.isFb) {
          return 'fb-' + widget.facebookUserData['id'];
        } else {
          return '';
        }
      } else {
        return '';
      }
    } else if (widget.isFb != null) {
      if (widget.isFb) {
        return 'fb-' + widget.facebookUserData['id'];
      } else {
        return '';
      }
    } else {
      return '';
    }
  }
}


/*

Component(Component.country, 'AS'),
Component(Component.country, 'AD'),
Component(Component.country, 'AO'),
Component(Component.country, 'AI'),
Component(Component.country, 'cl'),
Component(Component.country, 'AQ'),
Component(Component.country, 'CN'),
Component(Component.country, 'VE'),
Component(Component.country, 'VN'),
Component(Component.country, 'VG'),
Component(Component.country, 'VI'),
Component(Component.country, 'WF'),
Component(Component.country, 'AX'),
Component(Component.country, 'EH'),
Component(Component.country, 'YE'),
Component(Component.country, 'ZM'),
Component(Component.country, 'ZW'),
Component(Component.country, 'VU'),
Component(Component.country, 'UZ'),
Component(Component.country, 'UY'),
Component(Component.country, 'US'),
Component(Component.country, 'UM'),
Component(Component.country, 'GB'),
Component(Component.country, 'AE'),
Component(Component.country, 'UA'),
Component(Component.country, 'UG'),
Component(Component.country, 'TV'),
Component(Component.country, 'TC'),
Component(Component.country, 'TM'),
Component(Component.country, 'TR'),
Component(Component.country, 'TN'),
Component(Component.country, 'TT'),
Component(Component.country, 'TO'),
Component(Component.country, 'TK'),
Component(Component.country, 'TG'),
Component(Component.country, 'TL'),
Component(Component.country, 'TH'),
Component(Component.country, 'TZ'),
Component(Component.country, 'TJ'),
Component(Component.country, 'TW'),
Component(Component.country, 'SY'),
Component(Component.country, 'CH'),
Component(Component.country, 'SE'),
Component(Component.country, 'SJ'),
Component(Component.country, 'SR'),
Component(Component.country, 'SD'),
Component(Component.country, 'LK'),
Component(Component.country, 'ES'),
Component(Component.country, 'SS'),
Component(Component.country, 'GS'),
Component(Component.country, 'ZA'),
Component(Component.country, 'SO'),
Component(Component.country, 'SB'),
Component(Component.country, 'SI'),
Component(Component.country, 'SK'),
Component(Component.country, 'SX'),
Component(Component.country, 'SG'),
Component(Component.country, 'SL'),
Component(Component.country, 'SC'),
Component(Component.country, 'RS'),
Component(Component.country, 'SN'),
Component(Component.country, 'SA'),
Component(Component.country, 'ST'),
Component(Component.country, 'SM'),
Component(Component.country, 'WS'),
Component(Component.country, 'VC'),
Component(Component.country, 'PM'),
Component(Component.country, 'MF'),
Component(Component.country, 'LC'),
Component(Component.country, 'KN'),
Component(Component.country, 'KN'),
Component(Component.country, 'BL'),
Component(Component.country, 'RE'),
Component(Component.country, 'RW'),
Component(Component.country, 'RU'),
Component(Component.country, 'RO'),
Component(Component.country, 'MK'),
Component(Component.country, 'QA'),
Component(Component.country, 'PR'),
Component(Component.country, 'PT'),
Component(Component.country, 'PL'),
Component(Component.country, 'PN'),
Component(Component.country, 'PH'),
Component(Component.country, 'PE'),
Component(Component.country, 'PY'),
Component(Component.country, 'PG'),
Component(Component.country, 'PA'),
Component(Component.country, 'PS'),
Component(Component.country, 'PW'),
Component(Component.country, 'PK'),
Component(Component.country, 'OM'),
Component(Component.country, 'NO'),
Component(Component.country, 'MP'),
Component(Component.country, 'NF'),
Component(Component.country, 'NU'),
Component(Component.country, 'NG'),
Component(Component.country, 'NE'),
Component(Component.country, 'NI'),
Component(Component.country, 'NZ'),
Component(Component.country, 'NC'),
Component(Component.country, 'NL'),
Component(Component.country, 'NP'),
Component(Component.country, 'NR'),
Component(Component.country, 'NA'),
Component(Component.country, 'MM'),
Component(Component.country, 'MZ'),
Component(Component.country, 'MA'),
Component(Component.country, 'MS'),
Component(Component.country, 'ME'),
Component(Component.country, 'MN'),
Component(Component.country, 'MC'),
Component(Component.country, 'MD'),
Component(Component.country, 'FM'),
Component(Component.country, 'MX'),
Component(Component.country, 'YT'),
Component(Component.country, 'MU'),
Component(Component.country, 'MR'),
Component(Component.country, 'MQ'),
Component(Component.country, 'MH'),
Component(Component.country, 'MT'),
Component(Component.country, 'ML'),
Component(Component.country, 'MV'),
Component(Component.country, 'MY'),
Component(Component.country, 'MW'),
Component(Component.country, 'MG'),
Component(Component.country, 'MO'),
Component(Component.country, 'LU'),
Component(Component.country, 'LT'),
Component(Component.country, 'LI'),
Component(Component.country, 'LY'),
Component(Component.country, 'LR'),
Component(Component.country, 'LS'),
Component(Component.country, 'LB'),
Component(Component.country, 'LV'),
Component(Component.country, 'LA'),
Component(Component.country, 'KG'),
Component(Component.country, 'KW'),
Component(Component.country, 'KR'),
Component(Component.country, 'KP'),
Component(Component.country, 'KI'),
Component(Component.country, 'KE'),
Component(Component.country, 'KZ'),
Component(Component.country, 'JO'),
Component(Component.country, 'JE'),
Component(Component.country, 'JP'),
Component(Component.country, 'JM'),
Component(Component.country, 'IT'),
Component(Component.country, 'IL'),
Component(Component.country, 'IM'),
Component(Component.country, 'IE'),
Component(Component.country, 'IQ'),
Component(Component.country, 'IR'),
Component(Component.country, 'ID'),
Component(Component.country, 'IN'),
Component(Component.country, 'IS'),
Component(Component.country, 'HU'),
Component(Component.country, 'HK'),
Component(Component.country, 'HN'),
Component(Component.country, 'VA'),
Component(Component.country, 'HM'),
Component(Component.country, 'HT'),
Component(Component.country, 'GY'),
Component(Component.country, 'GW'),
Component(Component.country, 'GN'),
Component(Component.country, 'GG'),
Component(Component.country, 'GT'),
Component(Component.country, 'GU'),
Component(Component.country, 'GP'),
Component(Component.country, 'GD'),
Component(Component.country, 'GL'),
Component(Component.country, 'GR'),
Component(Component.country, 'GI'),
Component(Component.country, 'GH'),
Component(Component.country, 'DE'),
Component(Component.country, 'GE'),
Component(Component.country, 'Gm'),
Component(Component.country, 'GA'),
Component(Component.country, 'TF'),
Component(Component.country, 'PF'),
Component(Component.country, 'FR'),
Component(Component.country, 'FI'),
Component(Component.country, 'FJ'),
Component(Component.country, 'FO'),
Component(Component.country, 'FK'),
Component(Component.country, 'ET'),
Component(Component.country, 'SZ'),
Component(Component.country, 'EE'),
Component(Component.country, 'ER'),
Component(Component.country, 'GQ'),
Component(Component.country, 'SV'),
Component(Component.country, 'EG'),
Component(Component.country, 'EC'),
Component(Component.country, 'DO'),
Component(Component.country, 'DM'),
Component(Component.country, 'DJ'),
Component(Component.country, 'DK'),
Component(Component.country, 'CI'),
Component(Component.country, 'CZ'),
Component(Component.country, 'CY'),
Component(Component.country, 'CW'),
Component(Component.country, 'CU'),
Component(Component.country, 'HR'),
Component(Component.country, 'CR'),
Component(Component.country, 'CK'),
Component(Component.country, 'CD'),
Component(Component.country, 'CG'),
Component(Component.country, 'KM'),
Component(Component.country, 'CO'),
Component(Component.country, 'CC'),
Component(Component.country, 'CX'),
Component(Component.country, 'CN'),
Component(Component.country, 'CL'),
Component(Component.country, 'TD'),
Component(Component.country, 'CF'),
Component(Component.country, 'KY'),
Component(Component.country, 'CA'),
Component(Component.country, 'CM'),
Component(Component.country, 'KH'),
Component(Component.country, 'CV'),
Component(Component.country, 'BI'),
Component(Component.country, 'BF'),
Component(Component.country, 'BG'),
Component(Component.country, 'BN'),
Component(Component.country, 'IO'),
Component(Component.country, 'BR'),
Component(Component.country, 'BV'),
Component(Component.country, 'BW'),
Component(Component.country, 'BA'),
Component(Component.country, 'BQ'),
Component(Component.country, 'BO'),
Component(Component.country, 'BT'),
Component(Component.country, 'BM'),
Component(Component.country, 'BJ'),
Component(Component.country, 'BZ'),
Component(Component.country, 'BE'),
Component(Component.country, 'BY'),
Component(Component.country, 'BB'),
Component(Component.country, 'BD'),
Component(Component.country, 'BH'),
Component(Component.country, 'BS'),

Component(Component.country, 'AG'),
Component(Component.country, 'AR'),
Component(Component.country, 'AM'),
Component(Component.country, 'AW'),
Component(Component.country, 'AU'),
Component(Component.country, 'AT'),
Component(Component.country, 'AZ'),*/
