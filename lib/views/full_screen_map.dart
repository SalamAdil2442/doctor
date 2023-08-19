import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/location.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap(
      {Key? key,
      required this.isEditable,
      required this.latLng,
      required this.title})
      : super(key: key);
  final String title;
  final LatLng? latLng;
  final bool isEditable;
  @override
  FullScreenMapState createState() {
    return FullScreenMapState();
  }
}

class FullScreenMapState extends State<FullScreenMap> {
  LatLng? location;
  @override
  void initState() {
    location = widget.latLng;
    super.initState();
  }

  bool loading = false;
  MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[
      if (location != null)
        Marker(
          point: location!,
          rotate: true,
          width: 45.sp,
          height: 45.sp,
          anchorPos: AnchorPos.align(AnchorAlign.top),
          rotateAlignment: Alignment.bottomCenter,
          // rotateOrigin: const Offset(5, -0),
          builder: (ctx) => Center(
            child: Icon(Icons.push_pin, size: 45.sp, color: Colors.red),
          ),
        ),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: loading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : const Icon(Icons.gps_fixed, color: Colors.white),
          onPressed: () async {
            if (loading) {
              return;
            }
            loading = true;
            setState(() {});
            final res = await LocationHalper.instance.getLocation(false);
            loading = false;
            if (res != null) {
              if (widget.isEditable) {
                location = LatLng(res.latitude, res.longitude);
              }
              mapController.moveAndRotate(res, mapController.zoom, 0);
            }
            setState(() {});
          }),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (widget.isEditable)
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop(location);
                },
                child: const Icon(Icons.save),
              ),
            )
        ],
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            onTap: ((tapPosition, point) {
              if (widget.isEditable) {
                location = point;
                setState(() {});
                logger(point);
              }
            }),
            center: location,
            zoom: 12,
            maxZoom: 18,
            minZoom: 1),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}
