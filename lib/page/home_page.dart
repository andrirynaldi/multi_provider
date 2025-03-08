import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_provider/bloc/counter_bloc.dart';
import 'package:multi_provider/bloc/theme_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = context.read<ThemeBloc>();
    final myCounter = context.read<CounterBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener<ThemeBloc, bool>(
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Theme is ${state ? 'dark' : 'light'} activated'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  listenWhen: (previous, current) => previous != current,
                ),
                BlocListener<CounterBloc, int>(
                  listener: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Counter: $state'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  listenWhen: (previous, current) {
                    if (current == 10) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
              ],
              child: BlocBuilder<CounterBloc, int>(
                bloc: myCounter,
                builder: (context, state) {
                  return Text(
                    '$state',
                    style: TextStyle(fontSize: 50),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    myCounter.increment();
                  },
                  child: Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    myCounter.decrement();
                  },
                  child: Text('Decrement'),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myTheme.changeTheme();
        },
        child: Icon(Icons.lightbulb),
      ),
    );
  }
}
