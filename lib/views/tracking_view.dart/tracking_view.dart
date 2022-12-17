part of 'tracking_imports.dart';

class TrackingView extends StatefulWidget {
  TrackingView({super.key});
  static final LatLng _kMapCenter =
      LatLng(25.197340856093597, 55.27441242012923);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 12.0, tilt: 0, bearing: 0);

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  GoogleMapController? mapController;

  final Set<Marker> markers = Set();

  @override
  void dispose() {
    super.dispose();
    mapController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<GoogleMapProvider>(
      builder: (context, value, child) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(value.position!.latitude.toString()),
                double.parse(value.position!.latitude.toString()),
              ),
              zoom: 15),
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          markers: value.markers,
          myLocationEnabled: false,
        );
      },
    ));
  }
}
