'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "db7541a8763c0e7c4affa5c3e644e55c",
"assets/assets/Bgm/bgm_field.mp3": "9d2a7e0acb3c53868c84e0d2b05bd23c",
"assets/assets/Bgm/bgm_fight.mp3": "5ddebf366f4d7ec50c105ab69fdc57c3",
"assets/assets/Images/aeae.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/Images/aji.png": "2509f346a816e0a4a6ae2355174e3ccd",
"assets/assets/Images/aohata.png": "861ba2f745f4b645eacc716ac208ebe3",
"assets/assets/Images/arrow_left.png": "97454757e6b76718d951b11bf14ea1bb",
"assets/assets/Images/arrow_right.png": "da0cbb5cf372a6d5e713f8b7cd07f8de",
"assets/assets/Images/bc4-3.jpg": "6a7fece23647c6d3c5c0f79d724502d5",
"assets/assets/Images/fish.png": "2690dcdef769464d5a04f57529ab8737",
"assets/assets/Images/fishback.jpg": "cccd1f3d68e9ff004efb15bfbde56ed4",
"assets/assets/Images/hari.png": "4c6f2b13241cd99063741beda3b2e2e3",
"assets/assets/Images/jig.png": "89c822c67ef2f22de295089524b6c9a5",
"assets/assets/Images/kijihata.png": "18cd723649cc1362a043c2405862d3e0",
"assets/assets/Images/koi.jpg": "f1aca98e1ebf00168e4d098338ec5672",
"assets/assets/Images/madai.jpg": "b913d99cf40756d8d6e9b7df7785e045",
"assets/assets/Images/mube.jpg": "a24c408a4af32fc528e5af87c9297ecb",
"assets/assets/Images/player.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/Images/point.gif": "36dd1c489c2e45c0aa424577efc3975f",
"assets/assets/Images/reel.png": "2685cff1e79f0da617a4d6559a041776",
"assets/assets/Images/rod.png": "29db2db993c511222f2403652db1d633",
"assets/assets/Images/sagoshi.png": "f7194a4bd64f09a80be3ec60e111acf8",
"assets/assets/Images/sakana.jpg": "197270149d9a9320dff38ed13fa30b18",
"assets/assets/Images/sencho.png": "31f93307c5a076363d3acdcbcf4d187c",
"assets/assets/Images/ship.png": "2a1bcc57792fd26c57dc9f2c5c438cd4",
"assets/assets/Images/slowjig.png": "d7f4aaf84455407eb4558adc6de78309",
"assets/assets/Images/sonar.png": "bd1e718d8d43076d2b19fc29907ad215",
"assets/assets/Images/SPEED.png": "09df87b2c38a04f298c26da7d01cc750",
"assets/assets/Images/tachiuo.jpg": "b9ea3c93162502641c65b4c9d821d9ca",
"assets/assets/Images/tairaba.png": "03544e4d91db131025e9981892fa8365",
"assets/assets/Images/TENSIONDRAG.png": "dea693a59acb1a40525ff3efcebe7a90",
"assets/assets/Images/unknownfish.png": "215db669697114a97c663c498cb4f64e",
"assets/assets/Images/white.png": "a6420dd4a339ca12cf90768ae5934ea1",
"assets/assets/Se/book.mp3": "5c2c0860009083f5b9aab1b1c2ff5dca",
"assets/assets/Se/clutch.mp3": "769e9ec46451a442f4a94e72bb7ed026",
"assets/assets/Se/drag.mp3": "74081bce13cb61f0e65e6a01ce37c68e",
"assets/assets/Se/highjerk.mp3": "4a029842965c678817e470853de6acb8",
"assets/assets/Se/hit.mp3": "95d2d17d040e77681bea9b6152b7ba5c",
"assets/assets/Se/jingle01.mp3": "2ad70cbcbd1d76a1afefc4c72e1b947d",
"assets/assets/Se/kk_sonar_low.mp3": "851fdb9ba3a25d9fefbf92d753ffae82",
"assets/assets/Se/linebreak.mp3": "b3063399a764ff4506d8fc1f576a4c69",
"assets/assets/Se/lowjerk.mp3": "fa7b4d4c640ffd5223cd309ce36468c7",
"assets/assets/Se/middlejerk.mp3": "41970ba8014d6ef0f931ab7e4e2f6762",
"assets/assets/Se/system27.mp3": "ba7b13d8c9276179c577a0171316b41e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "189fb66782647ef1c393cff5ad4d1c19",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "45f228454eb450bc66554ca50b462aa3",
"/": "45f228454eb450bc66554ca50b462aa3",
"main.dart.js": "93c41b1c41dcab17e3991aa8b29bf6bf",
"manifest.json": "c634c13abd31b54604e8fb848d0a85ec",
"version.json": "2625bcf7276b52a536463391f68a7f73"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
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
