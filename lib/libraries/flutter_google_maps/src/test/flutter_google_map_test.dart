import 'package:flutter_test/flutter_test.dart';
import 'package:google_directions_api/google_directions_api.dart';
import '../mobile/google_map.state.dart';

void main() {
  String apiKey = "Your-Key";

  test("calculate distance between coordinates", () /*async*/ {
    final googleMaps = GoogleMapState();
    expect(googleMaps.test_unit(), "hola");

    expect(
          googleMaps.getDistance(
                        GeoCoord(53.32055555555556, -1.7297222222222221),
                        GeoCoord(53.31861111111111, -1.6997222222222223)
                                ).toStringAsFixed(5),
          2.004367838271613.toStringAsFixed(5)
          );
  });
}