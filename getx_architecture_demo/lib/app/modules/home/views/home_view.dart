import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_architecture_demo/app/modules/home/views/widgets/custom_temp_info_text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
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
            child: controller.weatherModel == null
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
                              controller.weatherModel!.name,
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
                                  controller.weatherModel!.main.temp.toString(),
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
                                "It's ${controller.weatherModel!.weather[0].description}",
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
                                  data: controller.weatherModel!.main.pressure
                                      .toString(),
                                ),
                                CustomTempInfoText(
                                  title: "Humidity",
                                  data: controller.weatherModel!.main.humidity
                                      .toString(),
                                ),
                                CustomTempInfoText(
                                  title: "Speed",
                                  data: controller.weatherModel!.wind.speed
                                      .toString(),
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
      },
    );
  }
}
