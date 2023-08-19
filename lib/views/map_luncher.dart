import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:tandrustito/views/home.dart';

_openMaps(
    String title, double alt, double long, AvailableMap availableMap) async {
  await MapLauncher.showMarker(
    mapType: availableMap.mapType,
    coords: Coords(alt, long),
    title: title,
    description: title,
  );
}

List<AvailableMap> availableMaps = [];
showOpenWithMapBottomSheet(
    {required BuildContext context,
    required title,
    required lat,
    required long}) async {
  if (availableMaps.isEmpty) {
    availableMaps = await MapLauncher.installedMaps;
  }

  // ignore: use_build_context_synchronously
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
    builder: (BuildContext context) {
      return NewWidget(lat: lat, long: long, title: title);
    },
  );
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.title,
    required this.lat,
    required this.long,
  }) : super(key: key);
  final String title;
  final double lat, long;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20))),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: <Widget>[
                    for (int i = 0; i < availableMaps.length; i++)
                      InkWell(
                        onTap: () {
                          _openMaps(title, lat, long, availableMaps[i]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: availableMaps.length - 1 == i
                                  ? null
                                  : const Border(
                                      bottom: BorderSide(color: openColor))),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SvgPicture.asset(availableMaps[i].icon,
                                    height: 35, width: 35),
                              ),
                              const SizedBox(width: 10),
                              Text(availableMaps[i].mapName)
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
