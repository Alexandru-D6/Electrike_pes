import 'package:flutter_test/flutter_test.dart';
import 'package:google_directions_api/google_directions_api.dart';
import '../core/google_map.dart';
import '../mobile/google_map.state.dart';

Map<String, Map<String, double>> getFixedDouble(Map<String, Map<String, double>> map, int fix) {

  map.forEach((key, value) {
    value.forEach((key2, value2) {
      map[key]![key2] = double.parse(value2.toStringAsFixed(fix));
    });
  });

  return map;
}

void main() {
  GoogleMap.init('AIzaSyBN9tjrv5YdkS1K-E1xP9UVLEkSnknU0yY');

  test("calculate distance between coordinates", () /*async*/ {
    final googleMaps = GoogleMapState();
    expect(googleMaps.test_unit(), "hola");

    expect(
          googleMaps.getDistance(
                        GeoCoord(53.32055555555556, -1.7297222222222221),
                        GeoCoord(53.31861111111111, -1.6997222222222223)
                                ).toStringAsFixed(6),
          2.004367838271613.toStringAsFixed(6)
    );

    double resDouble = double.parse(2.004367838271613.toStringAsFixed(5));
    final Map<String, Map<String, double>> expected = {
      "a": {
        "a": 0.0,
        "b": resDouble,
      },
      "b": {
        "a": resDouble,
        "b": 0.0,
      },
    };
    final Map<String, GeoCoord> input = {
      "a": GeoCoord(53.32055555555556, -1.7297222222222221),
      "b": GeoCoord(53.31861111111111, -1.6997222222222223),
    };

    expect(
        getFixedDouble(googleMaps.getDistances(input), 5),
        expected
    );
  });
}