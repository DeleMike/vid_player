import 'package:flutter/material.dart';

class OptionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              child: Text('Play'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Video information'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Add subtitle'),
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Play as audio'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}