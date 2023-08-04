enum APIPath {
  getStationStamp,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getStationStamp:
        return 'getStationStamp';
    }
  }
}
