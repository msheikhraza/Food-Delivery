part of 'tracking_imports.dart';

class TrackingView extends StatefulWidget {
  TrackingView({super.key});
  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  GoogleMapController? mapController;

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (result) {
      Provider.of<GoogleMapProvider>(context, listen: false)
          .getcureentuser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<GoogleMapProvider>(
      builder: (context, value, child) {
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) async {
            value.completer.complete(controller);
          },
          polylines: value.polyline,
          initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(value.position!.latitude.toString()),
                double.parse(value.position!.latitude.toString()),
              ),
              zoom: 5),
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          markers: value.markers,
          myLocationEnabled: true,
        );
      },
    ));
  }
}
