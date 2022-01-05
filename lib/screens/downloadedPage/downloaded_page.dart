import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_extention/flutter_file_utils.dart';
import 'package:meditation_alive/services/global_method.dart';
import 'package:path_provider/path_provider.dart';

class DownloadScreen extends StatefulWidget {
  static const routeName = '/DownloadScreen';

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    var files;

    // void getFiles() async {
    //   //asyn function to get list of files
    //   List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    //   var root = storageInfo[0]
    //       .rootDir; //storageInfo[1] for SD card, geting the root directory
    //   var fm = FileManager(root: Directory(root)); //
    //   files = await fm.filesTree(
    //       //set fm.dirsTree() for directory/folder tree list
    //       excludedPaths: [
    //         "/storage/emulated/0/Meditation Alive"
    //       ], extensions: [
    //     "mp4",
    //     "pdf"
    //   ] //optional, to filter files, remove to list all,
    //       //remove this if your are grabbing folder list
    //       );
    //   setState(() {}); //update the UI
    // }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Downloads"),
        ),
        body: FutureBuilder(
            future: _files(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].path.split('/').last),
                    );
                  },
                );
              } else
              // if (snapshot.connectionState == ConnectionState.waiting)
              {
                return Center(child: Text("Loading"));
              }
            }),
      ),
    );
  }

  Future<List<FileSystemEntity>> _files() async {
    Directory? root = await getExternalStorageDirectory();
    List<FileSystemEntity>? files =
        await FileManager(root: root!).walk().toList();

    return files;
  }
}
