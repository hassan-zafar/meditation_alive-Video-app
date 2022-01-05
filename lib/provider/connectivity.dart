import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityService with ChangeNotifier{
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionController.add(_getStatus(result));
    });
  }

  StreamController<ConnectivityStatus> connectionController =
      StreamController<ConnectivityStatus>();

  ConnectivityStatus _getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Mobile;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Online;
    }
  }
}

enum ConnectivityStatus { Wifi, Mobile, Offline, Online }
