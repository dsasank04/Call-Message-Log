import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<CallLogEntry>> _callLogsFuture;

  @override
  void initState() {
    super.initState();
    _callLogsFuture = _getCallLogs();
  }

  Future<List<CallLogEntry>> _getCallLogs() async {
    var result = await CallLog.query();
    return result.toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Call Logs'),
        ),
        body: FutureBuilder(
          future: _callLogsFuture,
          builder: (BuildContext context, AsyncSnapshot<List<CallLogEntry>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to load call logs.'),
              );
            }
            final callLogs = snapshot.data!;
            return ListView.builder(
              itemCount: callLogs.length,
              itemBuilder: (BuildContext context, int index) {
                final callLog = callLogs[index];
                return ListTile(
                  leading: const Icon(Icons.call),
                  title: Text(callLog.name ?? callLog.number ?? ''),
                  subtitle: Text(
                    '${callLog.callType}',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
