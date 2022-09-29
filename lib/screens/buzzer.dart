import 'package:flutter/material.dart';

import 'package:grpc/grpc.dart';
import 'package:buzzer/proto/generated/buzzer.pbgrpc.dart';

class BuzzerPage extends StatefulWidget {
    const BuzzerPage({super.key, required this.title});

    final String title;

    @override
    State<BuzzerPage> createState() => _BuzzerPageState();
}

class _BuzzerPageState extends State<BuzzerPage> {
    
    final ClientChannel channel = ClientChannel(
        '10.0.2.2',
        port: 50000,
        options: ChannelOptions(
            credentials: ChannelCredentials.insecure(),
            codecRegistry:
                CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
        ),
    );

    void _buttonPressed() async {
        final stub = BuzzerClient(channel);

        try {
            var response = await stub.openDoor(
                OpenDoorRequest()..message = "Hello!",
                options: CallOptions(compression: const GzipCodec()),
            );
            _showSnackbar("Reply received: ${response.message}");
        } catch (e) {
            print("Caught error: $e");
        }
    }

    void _showSnackbar(String message) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
        ));
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text(widget.title),
            ),
            body: Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Container(
                            height: 200.0,
                            width: 200.0,
                            child: FittedBox(
                                child: FloatingActionButton(
                                    onPressed: _buttonPressed,
                                    child: const Text("OPEN"),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
