'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "306e524cb080eb5457ef0b44ba522c0c",
"version.json": "eb25b2f87ab0f7f2cb7e2a7dda5fab84",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"assets/logo.png": "bad664bbd9428b624fabb1d7203e3f07",
"assets/images/rolls_royce.png": "b5ae2d8229ba443199ea4917d1a65d2d",
"assets/images/cadillac.png": "e3d2778d910d7476dd8a95dca6088a55",
"assets/images/LogoElectrike.png": "4a81a0e87881b8305f026cba210a177f",
"assets/images/maserati.png": "538ef59e52b614f6047f814b8c417e7f",
"assets/images/bentley.png": "31fd001de22aa7160fa52e6cc79419e6",
"assets/images/map.png": "ee5774f43cd81efe0518e14ed3a21fd7",
"assets/images/charge_point.png": "f0d3b9d90807e19533377c5bda7f41c8",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/logo.png": "bad664bbd9428b624fabb1d7203e3f07",
"assets/assets/images/rolls_royce.png": "b5ae2d8229ba443199ea4917d1a65d2d",
"assets/assets/images/ComboCCS2.png": "01c8747a55b65743cfbf198993bfeddf",
"assets/assets/images/me.png": "c15165e2c4640ef05a97e5eeaba552eb",
"assets/assets/images/Schuko.png": "86b3bb6ba89cdc49b838200deb2ba266",
"assets/assets/images/type2.png": "4cd8a0bb94a1c7b46e67805cb7498352",
"assets/assets/images/CHAdeMO.png": "90b51891c04c14ee797958b94ee20eff",
"assets/assets/images/bike.png": "d3c10a63cb8e5cf072a6fdd46b128e1b",
"assets/assets/images/meWeb.png": "13a393f3ab87cfa200effc34a21ee549",
"assets/assets/images/Mennekes.png": "7afec024ba47d52535671c4395a5fa51",
"assets/assets/images/bikeWeb.png": "2ef69567ac572b2436a2c7bf1e3e121c",
"assets/assets/brandCars/seres.png": "c5ad24081b4ad236ca1b31b9d3f3474d",
"assets/assets/brandCars/lucid.png": "34326b2fb19fcff81de960fc6c5d8dad",
"assets/assets/brandCars/defaultBMW.png": "b59a114ffc2be174d1669dbaf483df52",
"assets/assets/brandCars/sono.png": "cee418fd061fd0724f0df6a6ff3a9035",
"assets/assets/brandCars/volvo.png": "40b81fc4664efca56f9cd04b49f93520",
"assets/assets/brandCars/skoda.png": "6a4d40c2f7623c54cfca513bc7ec8c44",
"assets/assets/brandCars/rayo.png": "ead096b300efce6fc35ed9e06315f2bf",
"assets/assets/brandCars/porsche.png": "9918fdbcf48d89caa8c137dd597d5829",
"assets/assets/brandCars/hyundai.png": "3ec042a47951ea8556c43895ae372558",
"assets/assets/brandCars/ds.png": "4de54c3956ed84d54a51d45fb89a9fe6",
"assets/assets/brandCars/cupra.png": "8887e790bf4c5caa5e8ac02aa6f461a9",
"assets/assets/brandCars/lightyear.png": "c62be7d2a2def0c0a65bc81e1cda946e",
"assets/assets/brandCars/maserati.png": "daa0ae1a8e4ed1ac8266f8d8e0294113",
"assets/assets/brandCars/aiways.png": "51bc7e21286f1358a85c2d3963670642",
"assets/assets/brandCars/jaguar.png": "325dc3897e4895800ab9b0155785dad7",
"assets/assets/brandCars/jac.png": "67dfe1d9a07a7a65f2f6b3301e23d72c",
"assets/assets/brandCars/ford.png": "93d4a0d536d0689660488cc5b6284346",
"assets/assets/brandCars/honda.png": "b1516e48385021514fbd9ec6f7d60f46",
"assets/assets/brandCars/dacia.png": "2eef8b293d054e8a4376b4bc75c3d5ca",
"assets/assets/brandCars/polestar.png": "540c499c776b7f0aa467ad07b9db6d8b",
"assets/assets/brandCars/mazda.png": "9ca63606b1bb01658a3ceda0c869c1c1",
"assets/assets/brandCars/fiat.png": "01ca58ddf866c639d90396ea2c400492",
"assets/assets/brandCars/smart.png": "243cbadbf3e2c6827cc9d4311714f52a",
"assets/assets/brandCars/mg.png": "fd7c98d854e8e4d0aedc1f4453d867d4",
"assets/assets/brandCars/peugeot.png": "f533f74d2896aad18926b59fa89884ff",
"assets/assets/brandCars/nissan.png": "8d9f7b42746245b4b375d86c85e5ab04",
"assets/assets/brandCars/opel.png": "41a85dd4daf465a2eeed5052b2ce16a4",
"assets/assets/brandCars/renault.png": "f51f1a9ff68a1cdf3c8177e20a85d761",
"assets/assets/brandCars/lexus.png": "1036a236ffa6964f76fdefed2e2a01b8",
"assets/assets/brandCars/kia.png": "41de30e74361973f601d6a0204a53bf3",
"assets/assets/brandCars/audi.png": "7b096aadf1a0fc5844c2357045699ec6",
"assets/assets/trophies/trophy2.png": "593b0bc05bb30b1077dd106411f36c05",
"assets/assets/trophies/trophy0.png": "593b0bc05bb30b1077dd106411f36c05",
"assets/assets/trophies/trophy1.png": "593b0bc05bb30b1077dd106411f36c05",
"assets/assets/trophies/trophy.png": "f7f618c8d419e506745894022cfb0d34",
"assets/NOTICES": "3019df0dc03c6007c1c5380a7d1ff853",
"assets/FontManifest.json": "1b1e7812d9eb9f666db8444d7dde1b20",
"assets/AssetManifest.json": "a711142dbfa3596002d417d516e0f906",
"assets/packages/google_maps_cluster_manager/assets/images/carsCluster.png": "7af84eea060ed038f81f7fbf0112fe05",
"assets/packages/google_maps_cluster_manager/assets/images/defaultMarker.png": "d043b6f7b926630d552606a0ff7bec64",
"assets/packages/google_maps_cluster_manager/assets/images/bicingCluster.png": "d7a911ee172d0598322be1afa0638dd4",
"assets/packages/google_maps_cluster_manager/assets/images/marker_a.png": "9b687e681fcc41298dfab9c1304b66d0",
"assets/packages/google_maps_cluster_manager/assets/images/marker_b.png": "bb8df73622307b582f89602743f4f02f",
"assets/packages/flutter_google_maps/assets/images/marker_a.png": "9b687e681fcc41298dfab9c1304b66d0",
"assets/packages/flutter_google_maps/assets/images/marker_b.png": "bb8df73622307b582f89602743f4f02f",
"assets/packages/sign_button/images/twitter.png": "08ed456da7c064a42ed528098c78dfc0",
"assets/packages/sign_button/images/tumblr.png": "695506da08f97651af960af9f268dcc4",
"assets/packages/sign_button/images/microsoft.png": "dfb60902957a3204c63d4d3de2ae76ff",
"assets/packages/sign_button/images/youtube.png": "615f39ecf21272fec7eceb7984ed8959",
"assets/packages/sign_button/images/githubDark.png": "561b115749533c422a8c02e4843c73d2",
"assets/packages/sign_button/images/appleDark.png": "11238aa9e757b14b5e3460b467e6a2b4",
"assets/packages/sign_button/images/facebook.png": "f4dfe9871ac8cce8278c2aba8c897e1d",
"assets/packages/sign_button/images/quora.png": "b10aaad4707aad91cbab341ef33ea56c",
"assets/packages/sign_button/images/linkedin.png": "e4ae6d8c444c75a24d02cd9995072297",
"assets/packages/sign_button/images/mail.png": "c9172bdda51109489593c86da58f10e8",
"assets/packages/sign_button/images/pinterest.png": "4e9b78531f5968aad62a1ec26eb75b18",
"assets/packages/sign_button/images/yahoo.png": "8d028327c009ae90e08ebfd965176f8b",
"assets/packages/sign_button/images/amazon.png": "af00fbd77763d45afd0131b85e5f78a5",
"assets/packages/sign_button/images/reddit.png": "1b200a970d87b9ab578ac556b24cf16b",
"assets/packages/sign_button/images/googleDark.png": "3a7df7781108618c2b3d05a5121abdfc",
"assets/packages/sign_button/images/facebookDark.png": "deface349f4fd6bece4039901e8c6c44",
"assets/packages/sign_button/images/instagram.png": "6c356b0bd4b0f7f80046fc2557e85757",
"assets/packages/sign_button/images/google.png": "46039fa62c3167028c4fdb86816c3363",
"assets/packages/sign_button/images/github.png": "c67686f615f334806a07d41d594c34c1",
"assets/packages/sign_button/images/apple.png": "c82fbe8cbcecaa462da7bd30015b3565",
"assets/packages/awesome_dialog/assets/flare/question.flr": "1c31ec57688a19de5899338f898290f0",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/packages/awesome_dialog/assets/flare/info2.flr": "21af33cb65751b76639d98e106835cfb",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/error.flr": "e3b124665e57682dab45f4ee8a16b3c9",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "b62641afc9ab487008e996a5c5865e56",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/icon/estation.png": "e7002967fb68361e90d2d6ebb9cdf74c",
"assets/icon/bike.svg": "db7c1f03e4e74954f004fe64f0ff9222",
"assets/icon/bicicleta-electrica.svg": "2b6f791c740dd9f8fd6742bb264ba95d",
"assets/icon/bike.png": "ac6548d1590c9a7c351ffb2ced6e244e",
"assets/icon/bicingPoint.png": "3d628b6648378e63f1530aae8b13da91",
"assets/icon/estacions.svg": "4bb83d6661c44825b2911b3b20bbcd7c",
"flutter.js": "0816e65a103ba8ba51b174eeeeb2cb67",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "c6f50facff875f6dd104e1dbca452b21",
"index.html": "020d93570a34888dc9e51e8957caf749",
"/": "020d93570a34888dc9e51e8957caf749"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
