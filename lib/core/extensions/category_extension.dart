import 'package:flutter_screenutil/flutter_screenutil.dart';

extension CategoryNameSize on String {
  double getSize() {
    if (length <= 5) {
      return 14.sp;
    } else if (length <= 10) {
      return 13.sp;
    } else {
      return 11.sp;
    }
  }
}
