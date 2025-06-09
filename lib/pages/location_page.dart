import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_app/components/de_bouncer.dart';
import 'package:shopping_app/components/unFocusOnTap.dart';
import 'package:shopping_app/pages/checkout_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String currentLocation = '';
  late List<Placemark> placeMarks;
  late String? city;
  late TextEditingController locationSearchController;
  List<String> possibleAutoComplete = <String>[];
  final DeBouncerClass _deBouncer = DeBouncerClass(milliseconds: 500);

  Future<String> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future<String>.error('Location permissions are disabled!');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future<String>.error(
        'Locations permissions are permanently denied!',
      );
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // print(placeMarks);

    city =
        '${placeMarks[0].locality ?? ''}, ${placeMarks[0].subLocality ?? ''}';

    return city ?? 'Not Found';
  }

  void callGetLocation() async {
    String temp = await getLocation();
    setState(() {
      currentLocation = temp;
    });
  }

  void autoCompleteTest(String query) async {
    // print('API call with query: $query');
    final String? accessToken = dotenv.env['ACCESS_TOKEN'];
    const String lat = '28.3949';
    const String lon = '84.1240';

    http.Response response = await http.get(
      Uri.parse(
        'https://route-init.gallimap.com/api/v1/search/autocomplete?accessToken=$accessToken&word=$query&lat=$lat&lng=$lon',
      ),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> autoCompleteData = json.decode(response.body);

      setState(() {
        possibleAutoComplete.clear();
        for (int i = 0; i < autoCompleteData['data'].length; i++) {
          possibleAutoComplete.add(autoCompleteData['data'][i]['name']);
          // possibleAutoComplete.add(
          //   autoCompleteData['data'][i]['name'].split(',')[0].trim(),
          // );
        }
      });
      // print(possibleAutoComplete);
    }
  }

  Widget listTileBuilder() {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height:
              // list tile's height is 50 pixels
              // displays scrollable suggestions if there are over 4 suggestions
              (possibleAutoComplete.length < 4
                  ? possibleAutoComplete.length
                  : 4) *
              50,
          child: ListView.builder(
            itemCount: possibleAutoComplete.length,
            itemBuilder: (BuildContext context, int index) {
              // final String option = possibleAutoComplete.elementAt(index);
              return ListTile(
                tileColor: Theme.of(context).colorScheme.tertiary,
                title: Text(possibleAutoComplete.elementAt(index)),
                onTap: () {
                  setState(() {
                    currentLocation = possibleAutoComplete[index];
                    possibleAutoComplete.clear();
                  });
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationSearchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    locationSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusOnTap(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            'Location',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                controller: locationSearchController,
                decoration: InputDecoration(
                  suffixIcon: Visibility(
                    visible: locationSearchController.text.isNotEmpty,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          locationSearchController.clear();
                          possibleAutoComplete.clear();
                        });
                      },
                      icon: const Icon(Icons.clear, color: Colors.red),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.edit_location),
                  prefixIconColor: Theme.of(context).colorScheme.inversePrimary,
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  hintText: 'Search your location..',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiaryFixed,
                    ),
                  ),
                  focusColor: Theme.of(context).colorScheme.inversePrimary,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (String s) {
                  if (s.length > 3) {
                    setState(() {
                      _deBouncer.run(() {
                        print(s);
                        autoCompleteTest(s);
                      });
                    });
                  }
                },
              ),
            ),
            if (locationSearchController.text.isNotEmpty &&
                locationSearchController.text.length > 3)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: listTileBuilder(),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Current Delivery Location: $currentLocation',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: callGetLocation,
              label: Text(
                'Get My Location',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              icon: Icon(
                Icons.edit_location,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.orange),
              ),
            ),
            const SizedBox(height: 10),
            // TextButton.icon(
            //   onPressed: () {
            //     autoCompleteTest(locationSearchController.text.trim());
            //   },
            //   label: const Text('TEMP', style: TextStyle(color: Colors.white)),
            //   style: const ButtonStyle(
            //     backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
            //   ),
            // ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext context) => const CheckoutPage(),
                      ),
                    );
                  },
                  label: Text(
                    'Proceed',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  icon: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
