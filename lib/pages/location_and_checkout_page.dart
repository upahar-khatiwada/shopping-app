import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/components/de_bouncer.dart';
import 'package:shopping_app/components/un_focus_on_tap.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/pages/checkout_page.dart';
import 'package:shopping_app/services/stripe_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late List<Placemark> placeMarks;
  late String? city;
  late TextEditingController locationSearchController;
  List<String> possibleAutoComplete = <String>[]; // for galli maps
  List<String> possibleAutoCompleteWorld = <String>[]; // for world
  late DeBouncerClass _deBouncer;

  // variables to store latitude, longitude for API call for Galli Maps
  String? lat, lon;

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

    lat = position.latitude.toString();
    lon = position.longitude.toString();

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
      Provider.of<CartModel>(context, listen: false).deliveryLocation = temp;
    });
  }

  void autoCompleteWorld(String query) async {
    print('test');
    final String? accessToken = dotenv.env['LOCATION_IQ_API_KEY'];
    print(accessToken);

    http.Response response = await http.get(
      Uri.parse(
        'https://api.locationiq.com/v1/autocomplete?key=$accessToken&q=$query',
      ),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final List<dynamic> autoCompleteLocation = json.decode(response.body);

      setState(() {
        possibleAutoCompleteWorld.clear();
        for (int i = 0; i < autoCompleteLocation.length; i++) {
          possibleAutoCompleteWorld.add(
            autoCompleteLocation[i]['display_name'],
          );
        }
      });

      print(possibleAutoCompleteWorld);
    }
  }

  void autoCompleteGalliMaps(String query) async {
    // print('API call with query: $query');
    final String? accessToken = dotenv.env['ACCESS_TOKEN'];
    // const String lat = '28.3949';
    // const String lon = '84.1240';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationSearchController = TextEditingController();
    _deBouncer = DeBouncerClass(milliseconds: 400);
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
            'Location and Checkout',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.length <= 3) {
                        return const Iterable<String>.empty();
                      }
                      // uncomment this for galli maps
                      // _deBouncer.run(
                      //   () => autoCompleteGalliMaps(textEditingValue.text),
                      // );
                      // return possibleAutoComplete.where((String option) {
                      //   return option.toLowerCase().contains(
                      //     textEditingValue.text.toLowerCase(),
                      //   );
                      // });
                      _deBouncer.run(
                        () => autoCompleteWorld(textEditingValue.text),
                      );
                      return possibleAutoCompleteWorld.where((String option) {
                        return option.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                      });
                    },
                    onSelected: (String selectedLocation) {
                      Provider.of<CartModel>(
                        context,
                        listen: false,
                      ).deliveryLocation = selectedLocation;
                      // locationSearchController.text = selectedLocation;
                      possibleAutoCompleteWorld.clear();

                      // uncomment this for galli maps
                      // possibleAutoComplete.clear();
                    },
                    fieldViewBuilder:
                        (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                        ) {
                          return StatefulBuilder(
                            builder:
                                (
                                  BuildContext context,
                                  StateSetter setInnerState,
                                ) {
                                  textEditingController.addListener(() {
                                    setInnerState(() {});
                                  });
                                  return TextField(
                                    cursorColor: Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary,
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    decoration: InputDecoration(
                                      hintText: 'Search your location..',
                                      hintStyle: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                      suffixIcon: Visibility(
                                        visible: textEditingController
                                            .text
                                            .isNotEmpty,
                                        child: IconButton(
                                          onPressed: () {
                                            textEditingController.clear();
                                          },
                                          icon: const Icon(
                                            Icons.clear,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.inversePrimary,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.tertiary,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                          );
                        },
                    optionsViewBuilder:
                        (
                          BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options,
                        ) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              color: Colors.transparent,
                              elevation: 4,
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                height:
                                    // list tile's height is 50 pixels
                                    // displays scrollable suggestions if there are over 4 suggestions
                                    (options.length < 4 ? options.length : 4) *
                                    50,
                                child: ListView.separated(
                                  clipBehavior: Clip.hardEdge,
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // final String option = options.elementAt(index);
                                    return ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(12),
                                      ),
                                      tileColor: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      title: Text(options.elementAt(index)),
                                      onTap: () {
                                        onSelected(options.elementAt(index));
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                        return Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          indent: 8,
                                          endIndent: 8,
                                        );
                                      },
                                ),
                              ),
                            ),
                          );
                        },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Consumer<CartModel>(
                      builder:
                          (
                            BuildContext context,
                            CartModel cart,
                            Widget? child,
                          ) {
                            return Text(
                              'Current Delivery Location: ${cart.getDeliveryLocation}',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.visible,
                            );
                          },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<CartModel>(
                  builder:
                      (BuildContext context, CartModel cart, Widget? child) {
                        return Visibility(
                          visible: cart.getDeliveryLocation.isEmpty,
                          child: ElevatedButton.icon(
                            onPressed: callGetLocation,
                            label: Text(
                              'Get My Location',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.inversePrimary,
                              ),
                            ),
                            icon: Icon(
                              Icons.edit_location,
                              color: Theme.of(
                                context,
                              ).colorScheme.inversePrimary,
                            ),
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                Colors.orange,
                              ),
                            ),
                          ),
                        );
                      },
                ),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     autoCompleteWorld('dhumba');
                //   },
                //   label: const Text('Temp Button'),
                //   icon: const Icon(Icons.temple_buddhist),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Theme.of(context).colorScheme.secondary,
                //     foregroundColor: Colors.white,
                //   ),
                // ),
                Consumer<CartModel>(
                  builder:
                      (BuildContext context, CartModel cart, Widget? child) {
                        return Visibility(
                          visible: cart.getDeliveryLocation.isNotEmpty,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<Widget>(
                                      builder: (BuildContext context) =>
                                          const CheckoutPage(),
                                    ),
                                  );
                                },
                                label: const Text(
                                  'Proceed',
                                  style: TextStyle(
                                    // color: Theme.of(
                                    //   context,
                                    // ).colorScheme.inversePrimary,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.check,
                                  // color: Theme.of(
                                  //   context,
                                  // ).colorScheme.inversePrimary,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
