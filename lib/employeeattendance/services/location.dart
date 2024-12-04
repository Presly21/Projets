// ignore: depend_on_referenced_packages
import 'package:location/location.dart';
class LocationService {
  Location location = Location();
  late LocationData _locData;

  Future<void> initialize() async {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _serviceEnabled;
    // ignore: no_leading_underscores_for_local_identifiers
    PermissionStatus _permission;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled) {
        return;
      }
    }

    _permission = await location.hasPermission();
    if(_permission == PermissionStatus.denied) {
      _permission = await location.requestPermission();
      if(_permission != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<double?> getLatitude() async {
    _locData = await location.getLocation();
    return _locData.latitude;
  }

  Future<double?> getLongitude() async {
    _locData = await location.getLocation();
    return _locData.longitude;
  }
}