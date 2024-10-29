import 'package:flutter/material.dart';

import '../view_model/data/local/shared_helper.dart';
import '../view_model/data/local/shared_keys.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${SharedHelper.getData(SharedKeys.userName)}'),
      ),
    );
  }
}
