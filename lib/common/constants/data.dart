import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
const JWT_TOKEN = 'JWT_TOKEN';

// localhost
const emulatorIp = '10.0.2.2:8080';
const simulatorIp = '127.0.0.1:8080';

//final ip = Platform.isIOS ? simulatorIp : emulatorIp;
final ip = 'w1ait5zcb8.execute-api.ap-northeast-2.amazonaws.com/GreatickerApiStage/';