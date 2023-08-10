
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class ScreenLockComponent extends StatefulWidget {
  VoidCallback unLock ;
  ScreenLockComponent(this.unLock,{Key? key}) : super(key: key);

  @override
  State<ScreenLockComponent> createState() => _ScreenLockComponentState();
}

class _ScreenLockComponentState extends State<ScreenLockComponent> {
  @override
  Widget build(BuildContext context) {
    return ScreenLock(
      title: const Text('Pleas Enter Passcode'),
      correctString:'810511',
      onUnlocked: widget.unLock,
    );
  }
}