'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a0d56cf38ccc22147d4611382145feba",
"assets/assets/bgm/bgm_book.mp3": "aeb1c7d372bece72793057403ea32e51",
"assets/assets/bgm/bgm_field.mp3": "24af8bdee28fe421db22248a9243d1e9",
"assets/assets/bgm/bgm_fight.mp3": "841ec535c2af527edc286cda935584b4",
"assets/assets/images/aeae.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/images/arrow_left.png": "97454757e6b76718d951b11bf14ea1bb",
"assets/assets/images/arrow_right.png": "da0cbb5cf372a6d5e713f8b7cd07f8de",
"assets/assets/images/bc4-3.jpg": "6a7fece23647c6d3c5c0f79d724502d5",
"assets/assets/images/fish/aji.png": "2509f346a816e0a4a6ae2355174e3ccd",
"assets/assets/images/fish/akayagara.png": "a8511c25bd0e9231b386f6d358f6551a",
"assets/assets/images/fish/aohata.png": "743bc6ff4edf7f8e5d9dfa9eabe7c223",
"assets/assets/images/fish/ayamekasago.png": "fe9e8b9c812d9fde957f29d4bb5a11da",
"assets/assets/images/fish/hiramasa.jpg": "aeec880d5e9c9eb6f47330ecf364c80c",
"assets/assets/images/fish/hiramasa.png": "382da50ef1156ddf32ce9e5980e847d8",
"assets/assets/images/fish/kijihata.png": "082ade40761a74dfcc98cb50e6b64e6d",
"assets/assets/images/fish/koi.jpg": "f1aca98e1ebf00168e4d098338ec5672",
"assets/assets/images/fish/madai.jpg": "b913d99cf40756d8d6e9b7df7785e045",
"assets/assets/images/fish/madai.png": "610516739efe1e28db16a82b59d28dcf",
"assets/assets/images/fish/saba.png": "7a88b7718bb261e3fbaceb7f9b3f7376",
"assets/assets/images/fish/sabahugu.png": "2c5406ab7d660c46e2f0916e80542e0f",
"assets/assets/images/fish/sagoshi.png": "f7194a4bd64f09a80be3ec60e111acf8",
"assets/assets/images/fish/sakana.jpg": "197270149d9a9320dff38ed13fa30b18",
"assets/assets/images/fish/sawara.png": "6d48a88cebc19a0274c56fb83645da13",
"assets/assets/images/fish/tachiuo.jpg": "9f377da927535b09c2ce8ef4b19d8ab5",
"assets/assets/images/fish.png": "2690dcdef769464d5a04f57529ab8737",
"assets/assets/images/fishback.jpg": "cccd1f3d68e9ff004efb15bfbde56ed4",
"assets/assets/images/hari.png": "4c6f2b13241cd99063741beda3b2e2e3",
"assets/assets/images/jig.png": "89c822c67ef2f22de295089524b6c9a5",
"assets/assets/images/mube.jpg": "a24c408a4af32fc528e5af87c9297ecb",
"assets/assets/images/player.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/images/point.gif": "36dd1c489c2e45c0aa424577efc3975f",
"assets/assets/images/reel.png": "2685cff1e79f0da617a4d6559a041776",
"assets/assets/images/reel1.png": "695d809fef06078a95d372b70861bc5b",
"assets/assets/images/reel2.png": "3c229f3a40f72793b1effd39c07c33e7",
"assets/assets/images/reel3.png": "413664225bda145013795cb411dfb880",
"assets/assets/images/rod1.png": "343bdcb6ca5a6d1e5c1e765c46bf5961",
"assets/assets/images/rod2.png": "0314f1c2f087c7893f4c9dc7ee0fafb6",
"assets/assets/images/rodicon.png": "1ff6e04d95ab394311396234bcf7d49c",
"assets/assets/images/saba.png": "6254cbf1fb2220edecf22cdd862b9abd",
"assets/assets/images/sencho.png": "31f93307c5a076363d3acdcbcf4d187c",
"assets/assets/images/ship.png": "2a1bcc57792fd26c57dc9f2c5c438cd4",
"assets/assets/images/slowjig.png": "d7f4aaf84455407eb4558adc6de78309",
"assets/assets/images/sonar.png": "bd1e718d8d43076d2b19fc29907ad215",
"assets/assets/images/SPEED.png": "09df87b2c38a04f298c26da7d01cc750",
"assets/assets/images/tairaba.png": "680be271651384a72abaa9e0aee73cfd",
"assets/assets/images/teibou.png": "f7964c49bda2ab446abca2697fc2377e",
"assets/assets/images/TENSIONDRAG.png": "dea693a59acb1a40525ff3efcebe7a90",
"assets/assets/images/unknownfish.png": "215db669697114a97c663c498cb4f64e",
"assets/assets/images/white.png": "a6420dd4a339ca12cf90768ae5934ea1",
"assets/assets/se/bait.mp3": "42c5148478b778379524ac908639d75a",
"assets/assets/se/book.mp3": "5c2c0860009083f5b9aab1b1c2ff5dca",
"assets/assets/se/bookclose.mp3": "5ef1af8ee954494826516ec64c269b66",
"assets/assets/se/boxclose.mp3": "d22cef9a42db3ff62db0bae10755d370",
"assets/assets/se/boxopen.mp3": "22b3d09adb6dc590c390366cc2cafcec",
"assets/assets/se/clutch.mp3": "769e9ec46451a442f4a94e72bb7ed026",
"assets/assets/se/drag.mp3": "74081bce13cb61f0e65e6a01ce37c68e",
"assets/assets/se/drag2.mp3": "69f9a77168cd898ef793f5b836b23538",
"assets/assets/se/drag2_high.mp3": "af529b0aa6e87edfc0d33e776a27179b",
"assets/assets/se/engineon.mp3": "a7c9028087225d1753d40e6dc9f22603",
"assets/assets/se/highjerk.mp3": "4a029842965c678817e470853de6acb8",
"assets/assets/se/hit.mp3": "95d2d17d040e77681bea9b6152b7ba5c",
"assets/assets/se/jingle01.mp3": "2ad70cbcbd1d76a1afefc4c72e1b947d",
"assets/assets/se/kk_sonar_low.mp3": "851fdb9ba3a25d9fefbf92d753ffae82",
"assets/assets/se/linebreak.mp3": "b3063399a764ff4506d8fc1f576a4c69",
"assets/assets/se/lowjerk.mp3": "fa7b4d4c640ffd5223cd309ce36468c7",
"assets/assets/se/lurebroken.mp3": "5dfc80d61e0600e473986fa9c6cfed1d",
"assets/assets/se/middlejerk.mp3": "41970ba8014d6ef0f931ab7e4e2f6762",
"assets/assets/se/muon01.mp3": "6504584bc25759575a77c078d097dc7b",
"assets/assets/se/shipmove.mp3": "77f3a6960d9c94b1cf2109c0efdeb300",
"assets/assets/se/shop.mp3": "c73f086a2d5a387c8621202eb5c5464b",
"assets/assets/se/system27.mp3": "ba7b13d8c9276179c577a0171316b41e",
"assets/assets/se/waterlanding.mp3": "341aa71a9cd39a0b586bea7d8479cc60",
"assets/assets/se/waterup.mp3": "c7d306956353e421fb58e5f3d569d802",
"assets/assets/se/waterupfish.mp3": "693952101367a3e46d859cf39670c26b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "5d7c89a97504c95aa5316ccad5077f8a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "cdc2086a5b404dfa6d8a94fbbec6f920",
"/": "cdc2086a5b404dfa6d8a94fbbec6f920",
"main.dart.js": "4da78df08660cb3c0222ded33f564f79",
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
