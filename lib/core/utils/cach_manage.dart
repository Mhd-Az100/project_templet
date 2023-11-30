import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachManager {
  static final customCachManager = CacheManager(
    Config("cacheKey",
        maxNrOfCacheObjects: 100, stalePeriod: const Duration(days: 15)),
  );
}
