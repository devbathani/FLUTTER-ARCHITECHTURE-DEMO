import 'package:mvp/mvp.dart';

import 'package:mvp_architecture_demo/home/presenters/home_state_functions.dart';
import 'package:mvp_architecture_demo/home/view/home_view.dart';

class HomePresenter extends MvpPresenter<HomeStateFunctions, HomeView> {
  @override
  void initializeViewModel() {
    viewModel = HomeStateFunctions();
  }

  void getWeatherData() {
    viewModel.getWeatherData();
    callback(viewModel);
  }
}
