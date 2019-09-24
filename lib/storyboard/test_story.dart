import 'package:flutter/material.dart';
import 'package:storyboard/storyboard.dart';


class TestStory extends Story {
  @override
  List<Widget> get storyContent {
    return [TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'What do people call you?',
        labelText: 'Name *',
      ),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String value) {
        return value.contains('@') ? 'Do not use the @ char.' : null;
      },
    ), const Placeholder()];
  }
}
