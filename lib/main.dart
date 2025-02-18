import 'package:chakra/src/app.dart';
import 'package:chakra/src/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully.");
  } catch (e, stackTrace) {
    print("Error during Firebase initialization: $e");
    print(stackTrace);
  }

  var dir = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Box box = await Hive.openBox(Constants.BOX_NAME);

  runApp(MyApp());
}
