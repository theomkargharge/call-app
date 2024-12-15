// import 'package:flutter/material.dart';
// import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

// class IncomingCall extends StatefulWidget {
//   const IncomingCall({super.key});

//   @override
//   State<IncomingCall> createState() => _IncomingCallState();
// }

// class _IncomingCallState extends State<IncomingCall> {
//   void getPermission() async {
//     await FlutterCallkitIncoming.requestFullIntentPermission();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     getPermission();
//   }

//   void call() async {
//     CallKitParams params = CallKitParams(
//       id: '_currentUuid',
//       nameCaller: 'Hien Nguyen',
//       handle: '0123456789',
//       type: 1,
//       textAccept: "Accept",
//       textDecline: "Decline",
//       extra: <String, dynamic>{'userId': '1a2b3c4d'},
//     );
//     await FlutterCallkitIncoming.showMissCallNotification(params);
//     setState(() {
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//               onPressed: () {
//                 call();
//               },
//               child: Text('data'))
//         ],
//       ),
//     );
//   }
// }
