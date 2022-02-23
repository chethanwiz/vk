import 'package:cirilla/service/ads_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatefulWidget {
  final double height;

  const BannerAds({Key? key, this.height = 50}) : super(key: key);

  @override
  _BannerAdsState createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  // COMPLETE: Add a BannerAd instance
  late BannerAd _ad;

  // COMPLETE: Add _isAdLoaded
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    // COMPLETE: Create a BannerAd instance
    _ad = BannerAd(
      adUnitId: AdService.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          if (kDebugMode) {
            print('Ad load failed (code=${error.code} message=${error.message})');
          }
        },
      ),
    );

    // COMPLETE: Load an ad
    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded) return SizedBox(height: widget.height);

    return Container(
      child: AdWidget(ad: _ad),
      width: _ad.size.width.toDouble(),
      height: widget.height,
      alignment: Alignment.center,
    );
  }
}
