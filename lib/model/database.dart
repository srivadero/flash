import 'dart:io';
import 'package:flash/model/entities.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<Isar>((ref) => throw UnimplementedError());

class IsarDatabase {
  IsarDatabase._init();

  static Future<Isar> init({required String directory}) async {
    WidgetsFlutterBinding.ensureInitialized();

    final o = IsarDatabase._init();
    return o._getDatabaseProvider(directory: directory);
  }

  Future<Isar> _getDatabaseProvider({directory}) async {
    final dirName = await _getDatabaseDirectory(directory);
    return await Isar.open(
      [ObraSchema, LoteSchema],
      name: 'flash',
      directory: dirName,
    );
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
}
