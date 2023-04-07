import 'dart:io';

import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class IsarDatabase {
  IsarDatabase._x();

  static Future<Isar> create({required String directory}) async {
    WidgetsFlutterBinding.ensureInitialized();

    final comp = IsarDatabase._x();
    return comp.getDatabaseProvider(directory: directory);
  }

  Future<Isar> getDatabaseProvider({directory}) async {
    final dirName = await _getDatabaseDirectory(directory);
    return await Isar.open(
      [ObraSchema, LoteSchema],
      name: 'flash',
      directory: dirName,
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<String?> _getDatabaseDirectory(String directoryName) async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory = await getExternalStorageDirectory();
        if (directory != null) {
          String newPath = "";
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Android/$directoryName";
          return newPath;
        }
      }
    }
    return null;
  }
}
