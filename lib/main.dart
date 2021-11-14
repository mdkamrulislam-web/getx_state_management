import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_state_management/controllers/counter_controller.dart';
import 'package:get/get.dart';
import 'package:getx_state_management/controllers/user_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyStatelessHome(),
      // const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterController _counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            GetBuilder<CounterController>(builder: (_) {
              return Text(
                _counterController.counter.toString(),
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterController.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ignore: must_be_immutable
class MyStatelessHome extends StatelessWidget {
  // final CounterController _counterController = Get.put(CounterController());

  MyStatelessHome({Key? key}) : super(key: key);
  String data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("widget.title"),
      ),
      body: GetX<UserController>(
          init: UserController(),
          initState: (userController) {},
          builder: (userController) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        userController.user.value.name,
                      ),
                      TextField(
                        onChanged: (value) => data = value,
                      ),
                      TextButton(
                        onPressed: () {
                          userController.user.update((val) {
                            val!.name = data;
                          });
                        },
                        child: const Text(
                          "Change Name",
                        ),
                      ),
                      Obx(() {
                        return Text(
                            "User Age: ${Get.find<UserController>().user.value.age}");
                      }),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 50),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          '${userController.user.value.name} has pushed the button this many times:',
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<CounterController>(
                    init: CounterController(),
                    builder: (counterController) {
                      return Text(
                        counterController.counter.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      );
                    },
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Get.find<CounterController>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Get.find<CounterController>().decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
