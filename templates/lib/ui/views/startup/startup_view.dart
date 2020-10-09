import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.handleStartupLogic(),
      builder: (ctx, model, child) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}
