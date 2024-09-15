import 'package:flutter/material.dart';
import 'package:labjob/Lab2/ActorHomePage.dart';
import 'package:labjob/Lab3/TextFailInput.dart';
import 'package:labjob/Lab3/job.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController job = TextEditingController();
TextEditingController createdBy = TextEditingController();
TextEditingController contentJob = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("ListJob")),
      body: AnimatedContainer(
        duration: Duration(microseconds: 200),
        child: Column(
          children: [
            Flexible(child: ListJob()),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: media.height * 0.5,
                                  width: media.width * 1,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: Column(
                                    children: <Widget>[
                                      TextFailInput(
                                        controller: job,
                                        textName: 'Job',
                                        obscureText: false,
                                      ),
                                      TextFailInput(
                                        controller: createdBy,
                                        textName: 'createdBy',
                                        obscureText: false,
                                      ),
                                      TextFailInput(
                                        controller: contentJob,
                                        textName: 'contentJob',
                                        obscureText: false,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          addJobToFile(Job(
                                              job: job.text.trim(),
                                              createdBy: createdBy.text.trim(),
                                              contentJob:
                                                  contentJob.text.trim()));
                                        },
                                        child: Container(
                                          height: media.height * 0.05,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: Colors.red,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text("Add Job"),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: Icon(Icons.add))),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ActorHomePage()));
              },
              child: Container(
                height: media.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: Text("Navigotor Actor "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
