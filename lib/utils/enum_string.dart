import 'package:aafia/widgets/my_request_container.dart';

extension ParseToString on RequestStatus {
  String toShortString() {
    return this.toString().split('.').last;
  }
}