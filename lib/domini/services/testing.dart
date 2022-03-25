// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:flutter_project/domini/services/google_maps_adpt.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'service_locator.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  
  Future<String> testing = serviceLocator<GoogleMapsAdpt>().reverseCoding(41.378833, 2.120229);

  testing.then((address) {
    print(address);
  });

  Future<Location> result = serviceLocator<GoogleMapsAdpt>().adressCoding("C. d'Arístides Maillol, 18, 08028 Barcelona, España");

  result.then((geometry) {
    print(geometry.lat.toString() + " "  + geometry.lng.toString());
  });
}