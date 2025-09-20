import 'package:flutter/material.dart';
import 'package:foodieree/controller/food_loction_controller.dart';
import 'package:foodieree/controller/food_videos.controller.dart';
import 'package:foodieree/screens/home_screen_widget/food_videos.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _initializeApp() async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final getVideoProvider =
        Provider.of<GetVideoProvider>(context, listen: false);

    await locationProvider.getCurrentLocation();
    await getVideoProvider.getVideoData();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return locationProvider.error.isNotEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_off,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'Location Access Required',
                ),
                const SizedBox(height: 8),
                Text(
                  locationProvider.error,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    locationProvider.getCurrentLocation();
                    await Geolocator.requestPermission();
                    setState(() {});
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          )
        : Consumer<GetVideoProvider>(
            builder: (context, getVideoProvider, _) {
              return PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: getVideoProvider.videosList.length,
                itemBuilder: (context, index) {
                  return VideolItem(
                    reel:
                        getVideoProvider.videosList[index].videoUrl.toString(),
                    thumb: getVideoProvider.videosList[index].thumbnailUrl
                        .toString(),
                    title: getVideoProvider.videosList[index].title.toString(),
                    author:
                        getVideoProvider.videosList[index].author.toString(),
                    isLiked: getVideoProvider.videosList[index].isLive!,
                    km: getVideoProvider.videosList[index].duration.toString(),
                  );
                },
              );
            },
          );
  }
}
