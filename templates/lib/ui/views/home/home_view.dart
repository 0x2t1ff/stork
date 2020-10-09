import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../ui_helpers.dart';
import './home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (ctx, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You've pushed the button this many times:",
                style: TextStyle(fontSize: 18),
              ),
              verticalSpaceMedium,
              Text(
                model.counter.toString(),
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.incrementCounter,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
