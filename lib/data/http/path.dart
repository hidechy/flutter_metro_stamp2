enum APIPath {
  getStationStamp,
  getholiday,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getStationStamp:
        return 'getStationStamp';
      case APIPath.getholiday:
        return 'getholiday';
    }
  }
}
