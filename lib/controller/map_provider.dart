import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';


class MapModel extends ChangeNotifier {

  // NaverMapController 변수
  NaverMapController? _controller;
  NaverMapController? get controller => _controller;


  // NaverMapController 초기화 메서드
  void setController(NaverMapController controller) {
    _controller = controller;
  }

  Future<void> moveCamera(double lat, double lng) async {
    if (_controller != null) {
      NLatLng LatLng = NLatLng(lat, lng);
      final cameraUpdate = NCameraUpdate.scrollAndZoomTo(
        target: LatLng,
      );

      await _controller!.updateCamera(cameraUpdate);
      notifyListeners();
    }
  }

  void notify(){
    notifyListeners();
  }

}