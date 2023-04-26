import 'package:flutter/material.dart';
import 'package:mvp/mvp.dart';
import 'package:mvp_architecture_demo/home/model/weather_model.dart';
import 'package:mvp_architecture_demo/home/presenters/home_presenter.dart';
import 'package:mvp_architecture_demo/home/presenters/home_state_functions.dart';
import 'package:mvp_architecture_demo/home/view/widgets/custom_temp_info_text.dart';

class HomeView extends StatefulWidget {
  final presenter = HomePresenter();
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends MvpScreen<HomeView, HomeStateFunctions> {
  WeatherModel? weatherModel;
  @override
  void initializeViewModel() {
    viewModel = HomeStateFunctions();
  }

  @override
  void initState() {
    // Always remember to bind the presenter in initState().
    widget.presenter.bind(applyState, this as HomeView);
    if (mounted) {
      _getWeatherData();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // And remember to release presenter binding in dispose().
    widget.presenter.unbind();
  }

  void _getWeatherData() async {
    final data = await viewModel.getWeatherData();

    setState(() {
      weatherModel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/background_image.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: weatherModel == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          weatherModel!.name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 170),
                              child: Text(
                                "o",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              weatherModel!.main!.temp.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            "It's ${weatherModel!.weather![0].description}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 300,
                    ),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTempInfoText(
                              title: "Pressure",
                              data: weatherModel!.main!.pressure.toString(),
                            ),
                            CustomTempInfoText(
                              title: "Humidity",
                              data: weatherModel!.main!.humidity.toString(),
                            ),
                            CustomTempInfoText(
                              title: "Speed",
                              data: weatherModel!.wind!.speed.toString(),
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
}
