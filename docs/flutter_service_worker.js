'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "f884c897934c63493528aee02c0c53d8",
"assets/assets/bgm/bgm_book.mp3": "aeb1c7d372bece72793057403ea32e51",
"assets/assets/bgm/bgm_field.mp3": "24af8bdee28fe421db22248a9243d1e9",
"assets/assets/bgm/bgm_fight_star1.mp3": "b8d6fed5cb36087f53c5cc813267ab1a",
"assets/assets/bgm/bgm_fight_star2.mp3": "901454ebec74072a12058f279d962302",
"assets/assets/bgm/bgm_fight_star3.mp3": "841ec535c2af527edc286cda935584b4",
"assets/assets/bgm/bgm_fight_star4.mp3": "ecd00afe04592932125c8771bf10db8c",
"assets/assets/bgm/bgm_fight_star5.mp3": "221b993366f1188c2f74ac4906cb8b78",
"assets/assets/bgm/bgm_fight_star5aa.mp3": "1511e8d5da53a82398a9d2d0a977ee59",
"assets/assets/bgm/boatnouta.mp3": "d25895e4a8f77b5229218986b59aadba",
"assets/assets/bgm/hamabenouta.mp3": "62ec6c186e639ae5547d92927069423d",
"assets/assets/bgm/ieji.mp3": "42903ca8afe5b87cccaafc4d9ff728d9",
"assets/assets/bgm/kaigarabushi.mp3": "e9a62dab07e847b1114603e1db717015",
"assets/assets/bgm/kanpainouta.mp3": "5936b1cbe961200d48d3e2b70818a9b5",
"assets/assets/bgm/menu.mp3": "a9742638ad9f303bc67535b1f49760ee",
"assets/assets/bgm/namiunouta.mp3": "50d31fbcdf8545900897af342b2e34bf",
"assets/assets/bgm/result.mp3": "0463b08e6ad30e035592e6c0d5e2a6d9",
"assets/assets/bgm/saitarobushi.mp3": "2f7fa75a20ac7bb17b8c3b61c9456959",
"assets/assets/bgm/sendosan.mp3": "d08d32dabe266a879438c3e911c842ee",
"assets/assets/bgm/syusen.mp3": "5dcef04fa26094040af4fb4844a78d56",
"assets/assets/bgm/tairyobushi.mp3": "83ff4372993dfb3d5708e73b6a3dbcc0",
"assets/assets/bgm/title.mp3": "52c0eb88d59dd7d6fb46a69b6e452007",
"assets/assets/images/aeae.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/images/arrow_left.png": "97454757e6b76718d951b11bf14ea1bb",
"assets/assets/images/arrow_right.png": "da0cbb5cf372a6d5e713f8b7cd07f8de",
"assets/assets/images/bc4-3.jpg": "6a7fece23647c6d3c5c0f79d724502d5",
"assets/assets/images/clown_gold.png": "84b76548a362a5a62dbc6e140d17d217",
"assets/assets/images/clown_silver.png": "b0e5ec7c60674a48c00730fceeca2bf2",
"assets/assets/images/fish/aji.png": "4e4ed3cd83b25de1c3b2077ca7526c78",
"assets/assets/images/fish/aji_e.png": "2509f346a816e0a4a6ae2355174e3ccd",
"assets/assets/images/fish/akayagara.png": "a8511c25bd0e9231b386f6d358f6551a",
"assets/assets/images/fish/aohata.png": "743bc6ff4edf7f8e5d9dfa9eabe7c223",
"assets/assets/images/fish/ayamekasago.png": "fe9e8b9c812d9fde957f29d4bb5a11da",
"assets/assets/images/fish/chikamekintoki.png": "fab507cd480c36cc9fbd7c5f3f907f22",
"assets/assets/images/fish/eso.png": "e97d9b7952bbca14bd419155d1f0478e",
"assets/assets/images/fish/hiramasa.png": "e1038ced37ab3f76717f3c42e0e4b1af",
"assets/assets/images/fish/itoyori.png": "087f254e5bb674ebb1d0b1d121d5cc46",
"assets/assets/images/fish/kihassoku.png": "8718c2c78fbf88b1f18dc025f689b13d",
"assets/assets/images/fish/kijihata.png": "082ade40761a74dfcc98cb50e6b64e6d",
"assets/assets/images/fish/koi.jpg": "f1aca98e1ebf00168e4d098338ec5672",
"assets/assets/images/fish/madai.jpg": "b913d99cf40756d8d6e9b7df7785e045",
"assets/assets/images/fish/madai.png": "610516739efe1e28db16a82b59d28dcf",
"assets/assets/images/fish/renkodai.png": "570a95ca5140351a8b01bdbc2c65f697",
"assets/assets/images/fish/saba.png": "7a88b7718bb261e3fbaceb7f9b3f7376",
"assets/assets/images/fish/sabahugu.png": "2c5406ab7d660c46e2f0916e80542e0f",
"assets/assets/images/fish/sagoshi.png": "b3fb38fbb8956d1a16f7376fc31db4cb",
"assets/assets/images/fish/sagoshi_e.png": "f7194a4bd64f09a80be3ec60e111acf8",
"assets/assets/images/fish/sakana.jpg": "197270149d9a9320dff38ed13fa30b18",
"assets/assets/images/fish/sawara.png": "6d48a88cebc19a0274c56fb83645da13",
"assets/assets/images/fish/seabass.png": "5a99f809057ddbc85d95d45ca1b12279",
"assets/assets/images/fish/shiira.png": "029757b0d730660c7b63179de77afd9f",
"assets/assets/images/fish/shimafugu.png": "29741984e719eb0f84ec07ec4f9481c4",
"assets/assets/images/fish/tachiuo.jpg": "9f377da927535b09c2ce8ef4b19d8ab5",
"assets/assets/images/fish/toragisu.png": "1c774d822758c312f1e44c9167b076f6",
"assets/assets/images/fish/ukkarikasago.png": "36609eddda4dd8c3955e5de22a55c051",
"assets/assets/images/fish.png": "2690dcdef769464d5a04f57529ab8737",
"assets/assets/images/fishback.jpg": "cccd1f3d68e9ff004efb15bfbde56ed4",
"assets/assets/images/hari.png": "4c6f2b13241cd99063741beda3b2e2e3",
"assets/assets/images/jig.png": "89c822c67ef2f22de295089524b6c9a5",
"assets/assets/images/kumo1.png": "2d94b689dd249f6338cd2ee5c83ffcb4",
"assets/assets/images/kumo2.png": "cc91e24688916e753aa2f1575fe2a229",
"assets/assets/images/kumo3.png": "a8d6c2b21eb4ce15b1f823c78943c40c",
"assets/assets/images/minimap.png": "4c792493b5822785a03df6c7551c2f51",
"assets/assets/images/mounten.png": "f5bcb31243d3d7da60adf5177c689870",
"assets/assets/images/mounten_test.png": "fed8fe92b0fa7b9b5e1c7d5b6cfd121d",
"assets/assets/images/mube.jpg": "a24c408a4af32fc528e5af87c9297ecb",
"assets/assets/images/nothing.png": "b053fb028f81bd094e3fd8007d892d70",
"assets/assets/images/player.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/images/point.gif": "36dd1c489c2e45c0aa424577efc3975f",
"assets/assets/images/reel.png": "2685cff1e79f0da617a4d6559a041776",
"assets/assets/images/reel1.png": "695d809fef06078a95d372b70861bc5b",
"assets/assets/images/reel2.png": "3c229f3a40f72793b1effd39c07c33e7",
"assets/assets/images/reel3.png": "413664225bda145013795cb411dfb880",
"assets/assets/images/reelwheel.png": "1fabd2d203a74f9e95826eef04ba9d7d",
"assets/assets/images/rod1.png": "343bdcb6ca5a6d1e5c1e765c46bf5961",
"assets/assets/images/rod2.png": "0314f1c2f087c7893f4c9dc7ee0fafb6",
"assets/assets/images/rodicon.png": "1ff6e04d95ab394311396234bcf7d49c",
"assets/assets/images/saba.png": "6254cbf1fb2220edecf22cdd862b9abd",
"assets/assets/images/sencho.png": "31f93307c5a076363d3acdcbcf4d187c",
"assets/assets/images/ship.png": "2a1bcc57792fd26c57dc9f2c5c438cd4",
"assets/assets/images/slowjig.png": "d7f4aaf84455407eb4558adc6de78309",
"assets/assets/images/sonar.png": "bd1e718d8d43076d2b19fc29907ad215",
"assets/assets/images/SPEED.png": "09df87b2c38a04f298c26da7d01cc750",
"assets/assets/images/sun.png": "b8dd13e5dd515afd0b0f1ec04e5c3821",
"assets/assets/images/tairaba.png": "680be271651384a72abaa9e0aee73cfd",
"assets/assets/images/takashima.png": "d774073825e97de70f260db437e0abad",
"assets/assets/images/tanker.png": "44dff2646fe6fc2d8d418772370aea02",
"assets/assets/images/teibou.png": "a3b6895a202fa73af273d8844fdfcb2c",
"assets/assets/images/TENSIONDRAG.png": "dea693a59acb1a40525ff3efcebe7a90",
"assets/assets/images/title.png": "0c5b7ed33e332a706de3a30177f44105",
"assets/assets/images/title_old.png": "2205c13aa68936313daf9bbbdf4bcee9",
"assets/assets/images/tutorial/aea.png": "bc5c3f756fa13507f2ff00a818c8cec2",
"assets/assets/images/tutorial/tutorial1.png": "063f40a89544077d7a2e62298b159b8e",
"assets/assets/images/tutorial/tutorial2.png": "a3c5e3f9a71cc7b1ff50e09f916bc970",
"assets/assets/images/tutorial/tutorial3.png": "6c453a496b5f78a544d936c17a067864",
"assets/assets/images/unknownfish.png": "215db669697114a97c663c498cb4f64e",
"assets/assets/images/white.png": "a6420dd4a339ca12cf90768ae5934ea1",
"assets/assets/images/windlvup.gif": "61f66bda75b5b3a06c844d54542641a5",
"assets/assets/se/bait1.mp3": "8428f685ee80daafd6af0c113b20c501",
"assets/assets/se/bait1__.mp3": "ed335ac7e0b5be9ac181b6a4f069d4a8",
"assets/assets/se/bait2.mp3": "243718df6821cf409a8cd8aa9fede6dd",
"assets/assets/se/bait_old.mp3": "42c5148478b778379524ac908639d75a",
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
"assets/assets/se/jingle01.mp3": "6180c5b8679ced1de3be7fb47894462c",
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
"assets/NOTICES": "52b99bd60bbac6659b1a524b86e16417",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "9c10858781233bf7929166525aff0286",
"/": "9c10858781233bf7929166525aff0286",
"main.dart.js": "9c7528d409ac54b4275f399abd376347",
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
