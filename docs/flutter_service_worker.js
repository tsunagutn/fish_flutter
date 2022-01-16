'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "3ffada7054a1de61c06237a781e53734",
"assets/assets/Bgm/bgm_book%25E3%2583%2588%25E3%2583%25AA%25E3%2583%25A0%25E5%2589%258D.mp3": "5a2e9396b428d9c2d73515dd0e411401",
"assets/assets/Bgm/bgm_book.mp3": "aeb1c7d372bece72793057403ea32e51",
"assets/assets/Bgm/bgm_field%25E3%2583%2588%25E3%2583%25AA%25E3%2583%25A0%25E5%2589%258D.mp3": "9d2a7e0acb3c53868c84e0d2b05bd23c",
"assets/assets/Bgm/bgm_field.mp3": "24af8bdee28fe421db22248a9243d1e9",
"assets/assets/Bgm/bgm_fight.mp3": "841ec535c2af527edc286cda935584b4",
"assets/assets/Images/aeae.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/Images/arrow_left.png": "97454757e6b76718d951b11bf14ea1bb",
"assets/assets/Images/arrow_right.png": "da0cbb5cf372a6d5e713f8b7cd07f8de",
"assets/assets/Images/bc4-3.jpg": "6a7fece23647c6d3c5c0f79d724502d5",
"assets/assets/Images/fish/aji.png": "2509f346a816e0a4a6ae2355174e3ccd",
"assets/assets/Images/fish/akayagara.png": "a8511c25bd0e9231b386f6d358f6551a",
"assets/assets/Images/fish/aohata.png": "743bc6ff4edf7f8e5d9dfa9eabe7c223",
"assets/assets/Images/fish/ayamekasago.png": "fe9e8b9c812d9fde957f29d4bb5a11da",
"assets/assets/Images/fish/hiramasa.jpg": "aeec880d5e9c9eb6f47330ecf364c80c",
"assets/assets/Images/fish/hiramasa.png": "382da50ef1156ddf32ce9e5980e847d8",
"assets/assets/Images/fish/kijihata.png": "082ade40761a74dfcc98cb50e6b64e6d",
"assets/assets/Images/fish/koi.jpg": "f1aca98e1ebf00168e4d098338ec5672",
"assets/assets/Images/fish/madai.jpg": "b913d99cf40756d8d6e9b7df7785e045",
"assets/assets/Images/fish/madai.png": "610516739efe1e28db16a82b59d28dcf",
"assets/assets/Images/fish/saba.png": "7a88b7718bb261e3fbaceb7f9b3f7376",
"assets/assets/Images/fish/sabahugu.png": "2c5406ab7d660c46e2f0916e80542e0f",
"assets/assets/Images/fish/sagoshi.png": "f7194a4bd64f09a80be3ec60e111acf8",
"assets/assets/Images/fish/sakana.jpg": "197270149d9a9320dff38ed13fa30b18",
"assets/assets/Images/fish/sawara.png": "6d48a88cebc19a0274c56fb83645da13",
"assets/assets/Images/fish/tachiuo.jpg": "b9ea3c93162502641c65b4c9d821d9ca",
"assets/assets/Images/fish.png": "2690dcdef769464d5a04f57529ab8737",
"assets/assets/Images/fishback.jpg": "cccd1f3d68e9ff004efb15bfbde56ed4",
"assets/assets/Images/hari.png": "4c6f2b13241cd99063741beda3b2e2e3",
"assets/assets/Images/jig.png": "89c822c67ef2f22de295089524b6c9a5",
"assets/assets/Images/mube.jpg": "a24c408a4af32fc528e5af87c9297ecb",
"assets/assets/Images/player.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/Images/point.gif": "36dd1c489c2e45c0aa424577efc3975f",
"assets/assets/Images/reel.png": "2685cff1e79f0da617a4d6559a041776",
"assets/assets/Images/reel1.png": "695d809fef06078a95d372b70861bc5b",
"assets/assets/Images/reel2.png": "3c229f3a40f72793b1effd39c07c33e7",
"assets/assets/Images/reel3.png": "413664225bda145013795cb411dfb880",
"assets/assets/Images/rod1.png": "343bdcb6ca5a6d1e5c1e765c46bf5961",
"assets/assets/Images/rod2.png": "0314f1c2f087c7893f4c9dc7ee0fafb6",
"assets/assets/Images/rodicon.png": "1ff6e04d95ab394311396234bcf7d49c",
"assets/assets/Images/saba.png": "6254cbf1fb2220edecf22cdd862b9abd",
"assets/assets/Images/sencho.png": "31f93307c5a076363d3acdcbcf4d187c",
"assets/assets/Images/ship.png": "2a1bcc57792fd26c57dc9f2c5c438cd4",
"assets/assets/Images/slowjig.png": "d7f4aaf84455407eb4558adc6de78309",
"assets/assets/Images/sonar.png": "bd1e718d8d43076d2b19fc29907ad215",
"assets/assets/Images/SPEED.png": "09df87b2c38a04f298c26da7d01cc750",
"assets/assets/Images/tairaba.png": "03544e4d91db131025e9981892fa8365",
"assets/assets/Images/TENSIONDRAG.png": "dea693a59acb1a40525ff3efcebe7a90",
"assets/assets/Images/unknownfish.png": "215db669697114a97c663c498cb4f64e",
"assets/assets/Images/white.png": "a6420dd4a339ca12cf90768ae5934ea1",
"assets/assets/Se/bait.mp3": "42c5148478b778379524ac908639d75a",
"assets/assets/Se/book.mp3": "5c2c0860009083f5b9aab1b1c2ff5dca",
"assets/assets/Se/bookclose.mp3": "5ef1af8ee954494826516ec64c269b66",
"assets/assets/Se/boxclose.mp3": "d22cef9a42db3ff62db0bae10755d370",
"assets/assets/Se/boxopen.mp3": "22b3d09adb6dc590c390366cc2cafcec",
"assets/assets/Se/clutch.mp3": "769e9ec46451a442f4a94e72bb7ed026",
"assets/assets/Se/drag.mp3": "74081bce13cb61f0e65e6a01ce37c68e",
"assets/assets/Se/drag2.mp3": "69f9a77168cd898ef793f5b836b23538",
"assets/assets/Se/drag2_high.mp3": "af529b0aa6e87edfc0d33e776a27179b",
"assets/assets/Se/engineon.mp3": "a7c9028087225d1753d40e6dc9f22603",
"assets/assets/Se/highjerk.mp3": "4a029842965c678817e470853de6acb8",
"assets/assets/Se/hit.mp3": "95d2d17d040e77681bea9b6152b7ba5c",
"assets/assets/Se/jingle01.mp3": "98a9b37ac6088d29d2c404d3a9a9a331",
"assets/assets/Se/kk_sonar_low.mp3": "851fdb9ba3a25d9fefbf92d753ffae82",
"assets/assets/Se/linebreak.mp3": "b3063399a764ff4506d8fc1f576a4c69",
"assets/assets/Se/lowjerk.mp3": "fa7b4d4c640ffd5223cd309ce36468c7",
"assets/assets/Se/lurebroken.mp3": "5dfc80d61e0600e473986fa9c6cfed1d",
"assets/assets/Se/middlejerk.mp3": "41970ba8014d6ef0f931ab7e4e2f6762",
"assets/assets/Se/muon01.mp3": "6504584bc25759575a77c078d097dc7b",
"assets/assets/Se/shipmove.mp3": "77f3a6960d9c94b1cf2109c0efdeb300",
"assets/assets/Se/shop.mp3": "c73f086a2d5a387c8621202eb5c5464b",
"assets/assets/Se/system27.mp3": "ba7b13d8c9276179c577a0171316b41e",
"assets/assets/Se/waterlanding.mp3": "341aa71a9cd39a0b586bea7d8479cc60",
"assets/assets/Se/waterup.mp3": "c7d306956353e421fb58e5f3d569d802",
"assets/assets/Se/waterupfish.mp3": "693952101367a3e46d859cf39670c26b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "7e6cd146d27b5932aa8c6032cea2f49d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "c918b30af0be1c5bd4fc2e2198bca247",
"/": "c918b30af0be1c5bd4fc2e2198bca247",
"main.dart.js": "845d6b715b52aaf62979329df44b6410",
"manifest.json": "e47fc872923be81230833286bf30a0aa",
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
