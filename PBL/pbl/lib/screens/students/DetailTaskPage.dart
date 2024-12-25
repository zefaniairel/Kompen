import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mobile/providers/TaskProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile/themes/typography.dart';
import 'package:mobile/themes/colors.dart';

class DetailTaskPage extends ConsumerStatefulWidget {
  const DetailTaskPage({Key? key}) : super(key: key);

  @override
  _DetailTaskPageState createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends ConsumerState<DetailTaskPage> {
  String? _fileName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int taskId = ModalRoute.of(context)?.settings.arguments as int;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    } else {
      print("No file selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskProvider);
    final task = tasks.first;

    if (task == null) {
      return Center(child: CircularProgressIndicator());
    }

    final String? file = task.tipe == "file" ? task.file : null;
    final String? url = task.tipe == "url" ? task.url : null;

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.accentColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Detail Tugas',
            style: MyTypography.headline2.copyWith(color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: MyColors.surfaceColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          task.judul ?? '',
                          style: MyTypography.headline2
                              .copyWith(color: MyColors.onSurfaceColor),
                        ),
                        SizedBox(height: 8),
                        Text("Dosen: ${task.dosen}",
                            style: TextStyle(color: MyColors.onSurfaceColor)),
                        SizedBox(height: 8),
                        Text(task.deskripsi ?? '',
                            style: TextStyle(color: MyColors.onSurfaceColor)),
                        SizedBox(height: 8),
                        Text("Bobot: 20",
                            style: TextStyle(color: MyColors.onSurfaceColor)),
                        if (task.status == "terima") SizedBox(height: 8),
                        if (task.status == "terima")
                          LinearProgressIndicator(
                            value: (task.progress ?? 0) / 100,
                            color: Colors.green,
                            backgroundColor: Colors.grey[300],
                          ),
                        SizedBox(height: 8),
                        if (task.progress != null)
                          Text("Progress: ${task.progress}%",
                              style: TextStyle(color: MyColors.onSurfaceColor)),
                        SizedBox(height: 8),
                        Text("Deadline: 12 Desember 2024",
                            style: TextStyle(color: MyColors.onSurfaceColor)),
                        SizedBox(height: 8),
                        if (task.file != null)
                          Row(
                            children: [
                              Text("File Pendukung: ",
                                  style: TextStyle(
                                      color: MyColors.onSurfaceColor)),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Download File',
                                    style: MyTypography.caption
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        if (task.url != null)
                          Row(
                            children: [
                              Text("URL Pendukung: ",
                                  style: TextStyle(
                                      color: MyColors.onSurfaceColor)),
                              TextButton(
                                  onPressed: () {
                                    if (url != null) _launchURL(url);
                                  },
                                  child: Text(url ?? '',
                                      style: TextStyle(
                                          color: MyColors.primaryColor)))
                            ],
                          ),
                        if (task.status == null)
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.accentColor,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                "Request Tugas",
                                textAlign: TextAlign.center,
                                style: MyTypography.bodyText2
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                if (task.status == "terima")
                  Card(
                    color: MyColors.surfaceColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Kumpulkan Tugas",
                            style: MyTypography.headline2
                                .copyWith(color: MyColors.onSurfaceColor),
                          ),
                          SizedBox(height: 16),
                          if (task.tipe == "file")
                            GestureDetector(
                              onTap: _pickFile,
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: MyColors.accentColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.attach_file,
                                        color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      "Upload File",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (task.tipe == "url")
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'URL',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          SizedBox(height: 16),
                          if (_fileName != null) ...[
                            Text("Selected File: $_fileName",
                                style: const TextStyle(
                                    color: MyColors.onSurfaceColor)),
                          ],
                          GestureDetector(
                            onTap: () {
                              if (_fileName != null) {
                                print("File Submitted: $_fileName");
                              } else {
                                print("No file selected!");
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: MyColors.accentColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Submit",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
