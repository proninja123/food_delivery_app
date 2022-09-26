import 'package:food_delivery/models/autocomplete_location/auto_compelte_location_model.dart';
import 'package:food_delivery/services/location_autocomplete/location_autocompelte_servic.dart';
import 'package:get/get.dart';

class AutoCompleteLocationController extends GetxController {
  var autoCompleteResponse = AutocompleteLocationResponse().obs;
  var _locationAutoCompleteService = LocationAutoCompleteService();

  void getGoogleAPiResponse(String inputString) async {
    autoCompleteResponse.value =
        await _locationAutoCompleteService.getAutoCompleteResponse(inputString);
  }

  AutocompleteLocationResponse get getAutoCompleteResponse =>
      autoCompleteResponse.value;
}
