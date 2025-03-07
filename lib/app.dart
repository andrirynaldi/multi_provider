import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_provider/bloc/theme_bloc.dart';
import 'package:multi_provider/page/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = context.read<ThemeBloc>();
    return BlocBuilder<ThemeBloc, bool>(
      bloc: myTheme,
      builder: (context, state) {
        return MaterialApp(
          theme: state == true ? ThemeData.dark() : ThemeData.light(),
          home: HomePage(),
        );
      },
    );
  }
}
