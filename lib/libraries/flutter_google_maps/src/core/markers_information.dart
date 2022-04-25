import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/map_items.dart' as items_t;

class MarkersInformation {
  late Map<String, Map<String, Marker>> markers;
  late Map<String, Marker> shown_markers;
  late Set<String> current_displaying;
  late bool init_markers;
  late List<items_t.Marker> items;

  MarkersInformation({
    required this.markers,
    required this.shown_markers,
    required this.current_displaying,
    required this.init_markers,
    required this.items,
  });
}