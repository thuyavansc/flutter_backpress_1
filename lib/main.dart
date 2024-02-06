import 'package:flutter/material.dart';

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Confirmation Dialog Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ConfirmationPage(),
//     );
//   }
// }
//
// class ConfirmationPage extends StatelessWidget {
//   const ConfirmationPage({Key? key}) : super(key: key);
//
//   Future<bool> _onBackPressed(BuildContext context) async {
//     // Show the dialog and wait for user response
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Confirm Exit'),
//           content: const Text('Are you sure you want to exit?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 // User tapped the cancel button, pop the dialog and return false
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: const Text('Exit'),
//               onPressed: () {
//                 // User tapped the exit button, pop the dialog and return true
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       // Register the callback function to handle back button press
//       onWillPop: () => _onBackPressed(context),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Confirmation Dialog Example'),
//         ),
//         body: const Center(
//           child: Text('Press the back button to show the confirmation dialog.'),
//         ),
//       ),
//     );
//   }
// }




void main() => runApp(const NavigatorPopHandlerApp());

class NavigatorPopHandlerApp extends StatelessWidget {
  const NavigatorPopHandlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const _HomePage(),
        '/two': (BuildContext context) => const _PageTwo(),
      },
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Page One'),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/two');
              },
              child: const Text('Next page'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageTwo extends StatefulWidget {
  const _PageTwo();

  @override
  State<_PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<_PageTwo> {
  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Page Two'),
            PopScope(
              canPop: false,
              onPopInvoked: (bool didPop) {
                if (didPop) {
                  return;
                }
                _showBackDialog();
              },
              child: TextButton(
                onPressed: () {
                  _showBackDialog();
                },
                child: const Text('Go back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
