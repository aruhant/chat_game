import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class Product {
  ProductDetails? details;
  bool purchased;
  Product(this.details, {this.purchased = false});
  @override
  String toString() => 'Product{details: $details, purchased: $purchased}';
}

final Map<String, Product> _products = {};

final InAppPurchase _inAppPurchase = InAppPurchase.instance;

// load PRoduct details
FutureProvider<Map<String, Product>> iapDetailsProvider =
    FutureProvider<Map<String, Product>>((ref) async {
  final products = await _inAppPurchase.queryProductDetails(<String>{
    'b1',
    'b1s01',
    'b1s02',
    'b1s03',
    'b1s04',
    'b1s05',
    'b1s06',
    'b1s07',
    'b1s08',
    'b1s09',
    'b1s10',
    'b1s11',
    'b1s12'
  });
  _products.clear();
  products.productDetails.forEach((element) {
    if (_products.containsKey(element.id))
      _products[element.id]!.details = element;
    else
      _products[element.id] = Product(element);
  });

  final purchases = _inAppPurchase.purchaseStream
    ..listen((List<PurchaseDetails> purchaseDetailsList) {
      for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
        if (purchaseDetails.status == PurchaseStatus.purchased) {
          if (_products.containsKey(purchaseDetails.productID))
            _products[purchaseDetails.productID]!.purchased = true;
          else
            _products[purchaseDetails.productID] =
                Product(null, purchased: true);
        }
      }
      ref.refresh(iapDetailsProvider);
      Log.d(_products.toString());
    });
  Log.w(_products.toString());

  return _products;
});
