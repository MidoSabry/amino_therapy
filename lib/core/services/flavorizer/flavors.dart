import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../global/enums/global_enum.dart';
import 'flavor_model.dart';

abstract class Flavor {
  FlavorModel get getCurrentFlavor;
}

class DevelopmentFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = 'Development App'
        ..baseUrl = dotenv.env['BASE_URL_DEV']
        ..description = 'Development Flavor Egypt'
        ..androidBundleId = 'com.2p.erpsystem.dev'
        ..iosBundleId = 'com.2p.erpsystem.dev'
        ..flavorType = FlavorsTypes.dev;
}

class StageFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = 'Stage App'
        ..baseUrl = dotenv.env['BASE_URL_STAGE']
        ..description = 'Stage Flavor Egypt'
        ..androidBundleId = 'com.2p.erpsystem.stage'
        ..iosBundleId = 'com.2p.erpsystem.stage'
        ..flavorType = FlavorsTypes.stage;
}

class ProductionFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = '2P ERP'
        ..baseUrl = dotenv.env['BASE_URL_PROD']
        ..description = 'Production Flavor'
        ..androidBundleId = 'com.2p.erpsystem'
        ..iosBundleId = 'com.2p.erpsystem'
        ..flavorType = FlavorsTypes.prod;
}

class EnterpriseFlavor extends Flavor {
  @override
  FlavorModel get getCurrentFlavor =>
      FlavorModel()
        ..title = 'Enterprise App'
        ..baseUrl = dotenv.env['BASE_URL_ENTER']
        ..description = 'Enterprise Flavor'
        ..androidBundleId = 'com.2p.erpsystem.enterprise'
        ..iosBundleId = 'com.2p.erpsystem.enterprise'
        ..flavorType = FlavorsTypes.enterprise;
}
