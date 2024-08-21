import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greaticker/common/constants/dot_env_keys.dart';

final Duration ThrottleTimeConstant = Duration(seconds: int.parse(dotenv.get(THROTTLE_LIMIT)));