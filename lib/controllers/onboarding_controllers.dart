import 'package:food_delivery/models/on_boarding_model.dart';
import 'package:food_delivery/repository/authentification_repository.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  var onBoardPageList = <OnBoardingPageModel>[].obs;
   

  OnBoardingPageModel _onBoardingPageModel;

  AuthRepository _authRepository;

  @override
  void onInit() {
    getOnBoardingData();
    super.onInit();

  }

  OnBoardingController() {
    _authRepository = AuthRepository();
  }

  /*List<OnBoardingPageModel> get onBoardList => _onBoardPageList;*/

  void getOnBoardingData() async {
    var onBoardingList = await _authRepository.getLandingPage();
    if(onBoardingList!=null){
      onBoardPageList.value = onBoardingList ;
      print(onBoardPageList.length);
    }
  }
}
