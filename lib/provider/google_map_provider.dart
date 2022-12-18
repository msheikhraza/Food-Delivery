import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:geolocator/geolocator.dart' as geo;

class GoogleMapProvider extends ChangeNotifier {
  BitmapDescriptor? caricon, currenteventlocation;
  geo.Position? position;
  final Set<Polyline> polyline = {};
  String point = "";
  String distance = "";

  final Set<Marker> markers = new Set();
  Completer<GoogleMapController> completer = Completer();

  Future<void> animateTo(double lat, double lng) async {
    final c = await completer.future;
    final p = CameraPosition(target: LatLng(lat, lng), zoom: 14.4746);
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }
  void getcureentuser(BuildContext context) async {
    geo.LocationPermission permission;
    permission = await geo.Geolocator.requestPermission();
    position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
    getmarkserfrommap();
    animateTo(position!.latitude,position!.longitude);
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

  void getmarkserfrommap() async {
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
    notifyListeners();

    markers.add(Marker(
        //add first marker
        markerId: MarkerId(
            const LatLng(25.197340856093597, 55.27441242012923).toString()),
        position: const LatLng(
            25.197340856093597, 55.27441242012923), //position of marker

        icon: currenteventlocation!));
    notifyListeners();
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${position!.latitude},${position!.longitude}&destination=${25.197340856093597},${55.27441242012923}&key=AIzaSyB-awCtmrXnj5Dt7az-mL1ILuUHeef0adQ";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    point = values["routes"][0]["overview_polyline"]["points"];
    distance = values["routes"][0]["legs"][0]["distance"]["text"];
    List<LatLng> convertToLatLng(List points) {
      List<LatLng> result = <LatLng>[];
      for (int i = 0; i < points.length; i++) {
        if (i % 2 != 0) {
          result.add(LatLng(points[i - 1], points[i]));
        }
      }
      return result;
    }
    List decodePoly(String poly) {
      var list = poly.codeUnits;
      var lList = [];
      int index = 0;
      int len = poly.length;
      int c = 0;
      // repeating until all attributes are decoded
      do {
        var shift = 0;
        int result = 0;

        // for decoding value of one attribute
        do {
          c = list[index] - 63;
          result |= (c & 0x1F) << (shift * 5);
          index++;
          shift++;
        } while (c >= 32);
        /* if value is negative then bitwise not the value */
        if (result & 1 == 1) {
          result = ~result;
        }
        var result1 = (result >> 1) * 0.00001;
        lList.add(result1);
      } while (index < len);

      /*adding to previous value as done in encoding */
      for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

      print(lList.toString());

      return lList;
    }

    // create a Polyline instance
    // with an id, an RGB color and the list of LatLng pairs

    polyline.add(Polyline(
        polylineId: const  PolylineId('route1'),
        visible: true,
        points: convertToLatLng(decodePoly(point)),
        width: 2,
        color: Colors.green,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap));
    notifyListeners();

    return values["routes"][0]["overview_polyline"]["points"];
  }


  }

