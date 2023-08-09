enum APIPath {
  getStationStamp,
  getholiday,
  getAllTemple,
  getWalkRecord2,
}

extension APIPathExtension on APIPath {
  String? get value {
    switch (this) {
      case APIPath.getStationStamp:
        return 'getStationStamp';
      case APIPath.getholiday:
        return 'getholiday';
      case APIPath.getAllTemple:
        return 'getAllTemple';
      case APIPath.getWalkRecord2:
        return 'getWalkRecord2';
    }
  }
}
