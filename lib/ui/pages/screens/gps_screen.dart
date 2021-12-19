import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:f_202110_firebase/data/services/location.dart';
import 'package:f_202110_firebase/domain/model/location.dart';
import 'package:f_202110_firebase/domain/controller/authentication_controller.dart';
import 'package:f_202110_firebase/domain/controller/location.dart';
// import 'package:f_202110_firebase/domain/controller/notification.dart';
import 'package:f_202110_firebase/domain/controller/permissions.dart';
import 'package:f_202110_firebase/domain/managements/location_management.dart';
import 'package:f_202110_firebase/ui/widgets/location_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
// import 'package:workmanager/workmanager.dart';

class GpsScreen extends StatefulWidget {
  const GpsScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<GpsScreen> {

  final authController = Get.find<AuthenticationController>();
  final permissionsController = Get.find<PermissionsController>();
  final locationController = Get.find<LocationController>();
  // final notificationController = Get.find<NotificationController>();
  final service = LocationService();



  @override
   Widget build(BuildContext context) {
    final _uid = authController.userUid();
    final _name = authController.userName();
    _init(_uid, _name);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => locationController.location != null
                ? LocationCard(
                    key: const Key("myLocationCard"),
                    title: 'MI UBICACIÓN',
                    lat: locationController.location!.lat,
                    long: locationController.location!.long,
                    onUpdate: () {
                      if (permissionsController.locationGranted) {
                        _updatePosition(_uid, _name);
                      }
                    },
                  )
                : const CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          // ListView on remaining screen space
          Obx(() {
            if (locationController.location != null) {
              var futureLocations = service.fecthData(
                map: locationController.location!.toJson,
              );
              return FutureBuilder<List<UserLocation>>(
                future: futureLocations,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final items = snapshot.data!;
                    // notificationController.show(
                    //     title: 'Egresados cerca.',
                    //     body:
                    //         'Hay ${items.length} egresados cerca de tu ubicación...');
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        UserLocation location = items[index];
                        return LocationCard(
                          title: location.name,
                          distance: location.distance,
                        );
                      },
                      // Avoid scrollable inside scrollable
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 300.0),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child:  FloatingActionButton(
          //     child: Icon(Icons.share),
          //     backgroundColor: Colors.purple,
          //     foregroundColor: Colors.white,
          //     onPressed: () {
          //       Share.share("Mi ubicación: https://www.google.es/maps?q=${locationController.location!.lat},${locationController.location!.long}");
          //     },
          //   )
          //   )
           
          // ),
        ],
      ),
    );
  }


  _init(String uid, String name) {
    if (!permissionsController.locationGranted) {
      permissionsController.manager.requestGpsPermission().then((granted) {
        if (granted) {
          locationController.locationManager = LocationManager();
          _updatePosition(uid, name);
        }
      });
    } else {
      locationController.locationManager = LocationManager();
      _updatePosition(uid, name);
    }
    // notificationController.createChannel(
    //     id: 'users-location',
    //     name: 'Users Location',
    //     description: 'Other users location...');
  }

  _updatePosition(String uid, String name) async {
    final position = await locationController.manager.getCurrentLocation();
    await locationController.manager.storeUserDetails(uid: uid, name: name);
    locationController.location = MyLocation(
        name: name, id: uid, lat: position.latitude, long: position.longitude);
    // Workmanager().registerPeriodicTask(
    //   "1",
    //   "locationPeriodicTask",
    // );
  }



}

