import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:geolocator/geolocator.dart' as geo;

class GoogleMapProvider extends ChangeNotifier {
  BitmapDescriptor? caricon, currenteventlocation;
  geo.Position? position;
  final Set<Marker> markers = new Set();
  void getcureentuser(BuildContext context) async {
    geo.LocationPermission permission;
    permission = await geo.Geolocator.requestPermission();
    position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String s, int i) async {
    final Uint8List imageData = await getBytesFromAsset(s, i);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future initmarkers() async {
    caricon = await getBitmapDescriptorFromAssetBytes('assets/t.png', 80);
    currenteventlocation =
        await getBitmapDescriptorFromAssetBytes('assets/d.png', 80);
  }

  void getmarkserfrommap(String prod) async {
    markers.clear();
    initmarkers();
    markers.add(Marker(
        //add first marker
        markerId: MarkerId(LatLng(double.parse(position!.latitude.toString()),
                double.parse(position!.longitude.toString()))
            .toString()),
        position: LatLng(double.parse(position!.latitude.toString()),
            double.parse(position!.longitude.toString())), //position of marker
        icon: caricon!));
    markers.add(Marker(
        //add first marker
        markerId: MarkerId(
            const LatLng(25.197340856093597, 55.27441242012923).toString()),
        position: const LatLng(
            25.197340856093597, 55.27441242012923), //position of marker

        icon: currenteventlocation!));
    notifyListeners();
  }
}
