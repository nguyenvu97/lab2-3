import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Job {
  final String job;
  final String contentJob;

  final String createdBy;

  Job({required this.contentJob, required this.createdBy, required this.job});

  Map<String, dynamic> toJson() {
    return {
      'job': job,
      'contentJob': contentJob,
      'createdBy': createdBy,
    };
  }

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      job: json['job'],
      contentJob: json['contentJob'],
      createdBy: json['createdBy'],
    );
  }
}

Future<String> _getLocalFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return '${directory.path}/dataJob.json';
}

Future<void> addJobToFile(Job job) async {
  final file = File("dataJob.json");
  final contents = jsonEncode(job);
  await file.writeAsString(contents);
}

Future<List<Job>?> readJob() async {
  List<Job> jobs = [];
  var filePath = await _getLocalFilePath();
  final file = File(filePath);
  if (await file.exists()) {
    final data = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(data);
    return jsonData.map((json) => Job.fromJson(json)).toList();
  } else {
    print("file not open");
    return [];
  }
}

class ListJob extends StatefulWidget {
  const ListJob({super.key});

  @override
  State<ListJob> createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<Widget> listJob = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addJob();
    });
  }

  void addJob() {
    List<Job> jobs = [
      Job(
        job: 'Beach Paradise',
        contentJob: '350',
        createdBy: 'nguyenvu',
      ),
      Job(
        job: 'City Break',
        contentJob: '400',
        createdBy: 'nguyenvu',
      ),
      Job(
        job: 'Ski Adventure',
        contentJob: '750',
        createdBy: 'nguyenvu',
      ),
      Job(
        job: 'Space Blast',
        contentJob: '600',
        createdBy: 'nguyenvu',
      ),
    ];

    jobs.forEach((job) {
      // addJobToFile(job);
      listJob.add(JsonContainer(job));
      _listKey.currentState!.insertItem(listJob.length - 1);
    });
  }

  Tween<Offset> offset = Tween(begin: Offset(1, 0), end: Offset(0, 0));
  @override
  Widget build(BuildContext context) {
    return AnimatedList(
        key: _listKey,
        initialItemCount: listJob.length,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: animation.drive(offset),
            child: listJob[index],
          );
        });
  }

  Widget JsonContainer(Job job) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${job.job} ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[300])),
          Text(job.contentJob,
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          //  ListView.builder(itemBuilder: itemBuilder)
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: FlutterLogo(),
      ),
      trailing: Text('\$${job.createdBy}'),
    );
  }
}
