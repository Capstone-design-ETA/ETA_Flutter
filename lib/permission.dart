import 'package:permission_handler/permission_handler.dart';

void requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.activityRecognition,
    Permission.sensors,
    Permission.phone,
  ].request();

  if (statuses[Permission.activityRecognition]?.isGranted == true &&
      statuses[Permission.sensors]?.isGranted == true &&
      statuses[Permission.phone]?.isGranted == true) {
    print('All permissions granted.');
  } else {
    // 하나 이상의 권한이 거부된 경우
    print('Permissions not granted. Check individual permissions.');
  }
}