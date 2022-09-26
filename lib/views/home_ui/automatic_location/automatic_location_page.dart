import 'dart:async';
import 'dart:ui';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:food_delivery/controllers/autocomplete_lcoation_controller.dart';
import 'package:food_delivery/custom_widgets/filled_button.dart';
import 'package:food_delivery/custom_widgets/form_input.dart';
import 'package:food_delivery/models/autocomplete_location/auto_compelte_location_model.dart';
import 'package:food_delivery/models/create_user_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/baseClass.dart';
import 'package:food_delivery/utils/user_current_location.dart';
import 'package:food_delivery/view_models/shared_pref_view_model.dart';
import 'package:food_delivery/views/home_ui/bottom_bar_ui/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_webservice/places.dart';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class AutomaticLocationPage extends StatefulWidget {
  final String userName;
  final String userNumber;
  final String userEmail;
  final bool isGoogle;

  final bool isFb;

  final bool isPhone;

  final GoogleSignInAccount user;
  final Map<String, dynamic> facebookUserData;

  AutomaticLocationPage({
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
  _AutomaticLocationPageState createState() => _AutomaticLocationPageState();
}

class _AutomaticLocationPageState extends State<AutomaticLocationPage>
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
  Set<Marker> _markers = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.7333, 76.7794),
   // tilt: 59.440717697143555,
    zoom: 16,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserCurrentLatLong();
  }

  void _getUserCurrentLatLong() async {
    _getCustomMarker();
    try {
      LocationData locationData = await UserCurrentLocation().getUserLocation();
      _gotToCurrentLocation(locationData.latitude, locationData.longitude);
    } catch (error) {
      showDialogError('_getUserCurrentLatLong method', error.toString());
    }
  }

  var bitmapIcon;

  _getCustomMarker() async {
    bitmapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(500, 500)), 'images/map_circle.png');
  }

  Future<void> _gotToCurrentLocation(double lat, double lng) async {
    try {
      CameraPosition _kLake = CameraPosition(
          // bearing: 192.8334901395799,
          target: LatLng(lat, lng),
        //  tilt: 59.440717697143555,
          zoom: 16);
     /* _markers.add(
        Marker(
          markerId: MarkerId('myMarker'),
          draggable: true,
          onDragEnd: ((newPosition) {
            userLat = newPosition.latitude;
            userLong = newPosition.longitude;
            getGeoAddressFromLatLong(
                LatLng(newPosition.latitude, newPosition.longitude));
            setState(() {});
            print(newPosition.latitude);
            print(newPosition.longitude);
          }),
          onTap: () {
            print('marker tapped');
          },
          position: LatLng(lat, lng),
          *//*  icon: bitmapIcon*//*
        ),
      );
*/
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
      getGeoAddressFromLatLong(LatLng(lat, lng));
      setState(() {
        userLat = lat;
        userLong = lng;
      });
    } catch (onError) {
      showDialogError('_gotToCurrentLocation Method', onError.toString());
    }
  }

  Future<void> _moveCamera(double lat, double lng) async {
    CameraPosition _kLake = CameraPosition(
        // bearing: 192.8334901395799,
        target: LatLng(lat, lng),
       // tilt: 59.440717697143555,
        zoom: 16);
    /*_markers.add(
      Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onDragEnd: ((newPosition) {
          userLong = newPosition.longitude;
          userLat = newPosition.latitude;
          getGeoAddressFromLatLong(
              LatLng(newPosition.latitude, newPosition.longitude));
          setState(() {});
        }),
        onTap: () {
          print('marker tapped');
        },
        position: LatLng(lat, lng),
        *//*icon: bitmapIcon*//*
      ),
    );*/

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  final FocusNode searchNode = FocusNode();
  AutoCompleteLocationController _autoCompleteLocationController =
      Get.put(AutoCompleteLocationController());
  AutocompleteLocationResponse _autocompleteLocationResponse =
      AutocompleteLocationResponse();
  TextEditingController _textEditingController = TextEditingController();
  bool showMessage = false;

  @override
  Widget build(BuildContext context) {
    var sharePrefProvider = Provider.of<SharedPrefProvider>(context);
    if (showMessage) {
      Get.snackbar('', 'Drag marker on map to get your location');
    }
    return Container(
      color: ThemeProvider.of(context).brightness == Brightness.light
          ? Colors.white
          : Color(0xff222C44),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
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
                top: 60,
                left: 0,
                right: 0,
                child: Container(
                  height: Get.height * 0.6,
                  color: Colors.red,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.terrain,
                        markers: _markers,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMove: (position) {
                          userLat = position.target.latitude;
                          userLong = position.target.longitude;
                        },
                        onCameraIdle: () {
                          print('Camera Idle');
                          if (userLong != 0.0 && userLong != 0.0)
                            getGeoAddressFromLatLong(LatLng(userLat, userLong));
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.push_pin_sharp,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
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
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 36.0, right: 36, top: 16),
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
                                      _locationBottomSheet(context);
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
                          top: 10,
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
                          top: 10,
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
                        padding: EdgeInsets.only(
                            left: 28.0, right: 28, top: 10, bottom: 10),
                        child: InkWell(
                          onTap: () async {
                            if (_addressController.text.trim().isEmpty) {
                              showError('Address', 'Address cannot be empty');
                            } else if (_cityController.text.trim().isEmpty) {
                              showError('City', 'City cannot be empty');
                            }
                            /*else if (_extraInfoController.text
                                  .trim()
                                  .isEmpty) {
                                showError('Extra information',
                                    'Extra information cannot be empty');
                              }*/
                            else {
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _locationBottomSheet(BuildContext context) {
    _textEditingController.text = '';
    _autoCompleteLocationController.getAutoCompleteResponse.predictions = null;
    showModalBottomSheet(
        barrierColor: Color(0xFF9B9B9B).withOpacity(0.3),
        backgroundColor: Colors.transparent,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        elevation: 15,
        builder: (BuildContext bc) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0)),
                color: ThemeProvider.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Color(0xff222C44),
              ),
              padding: EdgeInsets.only(top: 20.0),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  height: Get.size.height * 0.75,
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select location',
                        style: TextStyle(color: button_red, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormInput(
                        label: '',
                        onChanged: (value) async {
                          String currentValue =
                              value.toString().replaceAll('#', ' ');
                          _autoCompleteLocationController
                              .getGoogleAPiResponse(currentValue);
                        },
                        textEditingController: _textEditingController,
                        focusNode: searchNode,
                        hintText: 'Search Location',
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: button_red,
                          ),
                          TextButton(
                            onPressed: () {
                              _getUserCurrentLatLong();
                              popToPreviousScreen(context: context);
                            },
                            child: Text(
                              'Use current location',
                              style: TextStyle(
                                color: button_red,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Obx(() {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: /*_autocompleteLocationResponse.predictions.length*/ _autoCompleteLocationController
                                        .getAutoCompleteResponse.predictions ==
                                    null
                                ? 0
                                : _autoCompleteLocationController
                                    .getAutoCompleteResponse.predictions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _autoCompleteLocationController
                                          .getAutoCompleteResponse ==
                                      null
                                  ? 0
                                  : _autoCompleteLocationController
                                              .getAutoCompleteResponse
                                              .predictions
                                              .length ==
                                          0
                                      ? Container(
                                          height: 500,
                                        )
                                      : ListTile(
                                          onTap: () {
                                            _addressController.text =
                                                _autoCompleteLocationController
                                                    .getAutoCompleteResponse
                                                    .predictions
                                                    .elementAt(index)
                                                    .description;

                                            setState(() {
                                              displayPrediction(
                                                  _autoCompleteLocationController
                                                      .getAutoCompleteResponse
                                                      .predictions
                                                      .elementAt(index)
                                                      .placeId);
                                            });
                                            popToPreviousScreen(
                                                context: context);
                                          },
                                          title: Text(
                                            _autoCompleteLocationController
                                                    .getAutoCompleteResponse
                                                    .predictions
                                                    .elementAt(index)
                                                    .structuredFormatting
                                                    .mainText ??
                                                '',
                                            style: TextStyle(
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Color(0xff222C44)
                                                  : Colors.white,
                                            ),
                                          ),
                                          subtitle: Text(
                                            _autoCompleteLocationController
                                                    .getAutoCompleteResponse
                                                    .predictions
                                                    .elementAt(index)
                                                    .structuredFormatting
                                                    .secondaryText ??
                                                '',
                                            style: TextStyle(
                                              color: ThemeProvider.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Color(0xff222C44)
                                                  : Colors.white,
                                            ),
                                          ),
                                          leading: Icon(
                                            Icons.location_on,
                                          ),
                                        );
                            });
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void getGeoAddressFromLatLong(LatLng centerLatLng) async {
    try {
      final coordinates =
          Coordinates(centerLatLng.latitude, centerLatLng.longitude);
      print(coordinates);

      var addresses =
          await Geocoder.google('AIzaSyCJTzg3gjHZrlrTDDecgRJUMwipOuxpFqU')
              .findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      // addressLine = first.addressLine;
      _addressController.text = first.addressLine;
      country = first.countryName;
      state = first.locality;
      _cityController.text = first.locality ?? '';

      setState(() {});
    } catch (error) {
      showDialogError('getGeoAddressFromLatLong Error', error.toString());
    }
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

  Future<Null> displayPrediction(String placeId) async {
    if (placeId != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);

      userLat = detail.result.geometry.location.lat;
      userLong = detail.result.geometry.location.lng;

      var address = detail.result.formattedAddress;

      print(userLat);
      print(userLong);
      print(address);
      _moveCamera(userLat, userLong);
      setState(() {});
    }
  }

  void showDialogError(String title, String errorMessage) {
    Get.dialog(
      AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        content: Text(
          errorMessage.toString(),
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text(
              "Yes",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Get.back();
              //  uploadDraftORDuplicateProduct(context, true);
            },
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}
