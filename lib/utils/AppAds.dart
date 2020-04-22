import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

class AppAds {

  static AdmobInterstitial admobInterstitial;
  static AdmobReward admobReward;

  static final String _appId = Platform.isAndroid
      ? 'ca-app-pub-6009610218755987~7154197290'
      : 'ca-app-pub-6009610218755987~4144890578';
  static final String _bannerUnitId = Platform.isAndroid
      ? 'ca-app-pub-6009610218755987/3214952286'
      : 'ca-app-pub-6009610218755987/2831808905';
  static final String _screenUnitId = Platform.isAndroid
      ? 'ca-app-pub-6009610218755987/4336462264'
      : 'ca-app-pub-6009610218755987/1518727230';
  static final String _videoUnitId = Platform.isAndroid
      ? 'ca-app-pub-6009610218755987/8084135581'
      : 'ca-app-pub-6009610218755987/5900577951';

  AppAds();
//  /// Assign a listener.
//  static MobileAdListener _eventListener = (MobileAdEvent event) {
//    if (event == MobileAdEvent.clicked) {
//      print("_eventListener: The opened ad is clicked on.");
//    }
//  };
//
//  static void showBanner(
//      {String adUnitId,
//        AdSize size,
//        List<String> keywords,
//        String contentUrl,
//        bool childDirected,
//        List<String> testDevices,
//        bool testing,
//        MobileAdListener listener,
//        State state,
//        double anchorOffset,
//        AnchorType anchorType}) =>
//      _ads?.showBannerAd(
//          adUnitId: adUnitId,
//          size: size,
//          keywords: keywords,
//          contentUrl: contentUrl,
//          childDirected: childDirected,
//          testDevices: testDevices,
//          testing: testing,
//          listener: listener,
//          state: state,
//          anchorOffset: anchorOffset,
//          anchorType: anchorType);
//
//  static void hideBanner() => _ads?.closeBannerAd();
//
//
//  /// Call this static function in your State object's initState() function.
  static void init() => Admob.initialize(_appId);


  static void interstitialAds({VoidCallback onCloseSelected}){
    Function(AdmobAdEvent, Map<String, dynamic>) adEvent = (AdmobAdEvent event, Map<String, dynamic> args) {
      if (event == AdmobAdEvent.loaded){
        print('loaded');
        admobInterstitial.show();
      }
      if (event == AdmobAdEvent.closed) {
        onCloseSelected();
        print('closed');
      }};

    admobInterstitial =  AdmobInterstitial(
        adUnitId: _screenUnitId,
        listener: adEvent,
    );

    admobInterstitial.load();
  }

  static void rewardAds({VoidCallback onCloseSelected}){
    admobReward = AdmobReward(
        adUnitId: _videoUnitId,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.loaded) {
            admobReward.show();
          }
          if (event == AdmobAdEvent.closed) {
            print('closed');
            onCloseSelected;
          }}
    );
    admobReward.load();
  }
  static Widget bannerAds(){
    return AdmobBanner(
      adUnitId: _bannerUnitId,
      adSize: AdmobBannerSize.FULL_BANNER,
    );
  }


//
//  /// Remember to call this in the State object's dispose() function.
  static void disposeInter() => admobInterstitial?.dispose();
  static void disposeReward() => admobReward?.dispose();

}