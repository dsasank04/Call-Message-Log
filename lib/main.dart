import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];
  List<CallLogEntry> _callLogs = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  Future<void> _getCallLogs() async {
    var result = await CallLog.query();
    setState(() => _callLogs = result.toList());
  }

  Future<void> _getSmsMessages() async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      final messages = await _query.querySms(
        kinds: [SmsQueryKind.inbox, SmsQueryKind.sent],
        count: 10,
      );
      debugPrint('sms inbox messages: ${messages.length}');
      setState(() => _messages = messages);
    } else {
      await Permission.sms.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Call Logs & SMS Inbox'),
        ),
        body: _getBody(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            if (index == 1) {
              _getSmsMessages();
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Call Logs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'SMS Inbox',
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return _buildCallLogs();
      case 1:
        return _buildSmsMessages();
      default:
        return Container();
    }
  }

  Widget _buildCallLogs() {
    if (_callLogs.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
      itemCount: _callLogs.length,
      itemBuilder: (BuildContext context, int index) {
        final callLog = _callLogs[index];
        return ListTile(
          leading: const Icon(Icons.call),
          title: Text(callLog.name ?? callLog.number ?? ''),
          subtitle: Text(
            '${callLog.callType}',
          ),
        );
      },
    );
  }

  Widget _buildSmsMessages() {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _messages.length,
        itemBuilder: (BuildContext context, int i) {
          var message = _messages[i];
          return ListTile(
            leading: const Icon(Icons.message_rounded),
            title: Text('${message.sender} [${message.date}]'),
            subtitle: Text('${message.body}'),
          );
        },
      ),
    );
  }
}
