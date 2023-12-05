import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';

class ETA_map extends StatefulWidget {
  const ETA_map({super.key});

  @override
  State<ETA_map> createState() => _ETA_mapState();
}

class _ETA_mapState extends State<ETA_map> {
  late NaverMapController mapController;

  double myLat = 37.242961;
  double myLng = 127.080052;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  // 현재 위치 받기
  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    myLat = position.latitude;
    myLng = position.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
            target: NLatLng(37.242961, 127.080052),
            zoom: 15,
            bearing: 0,
            tilt: 0
        ),
      ), // 지도 옵션을 설정할 수 있습니다.
      forceGesture: false, // 지도에 전달되는 제스처 이벤트의 우선순위를 가장 높게 설정할지 여부를 지정합니다.
      onMapReady: (NaverMapController controller) async{
        mapController = controller;
        // Provider.of<MapModel>(context, listen: false).setController(controller);

        // 현재 위치 마커 생성
        final myMarker = NMarker(id: 'current',position: NLatLng(myLat, myLng));
        mapController.addOverlay(myMarker);

        //마커 생성
        final marker1 = NMarker(
          id: '1',
          position: NLatLng(37.2418, 127.0767),
          size: const Size(50, 50),
          icon: const NOverlayImage.fromAssetImage('images/selfie2.png'),
        );
        mapController.addOverlay(marker1);
        marker1.setOnTapListener((NMarker marker) {
          print("마커가 터치되었습니다. id: ${marker.info.id}");
          Navigator.pushNamed(context, '/feeds');
          });

      },
      onMapTapped: (point, latLng) {},
      onSymbolTapped: (symbol) {},
      onCameraChange: (position, reason) {},
      onCameraIdle: () {},
      onSelectedIndoorChanged: (indoor) {},
    );
  }
}
