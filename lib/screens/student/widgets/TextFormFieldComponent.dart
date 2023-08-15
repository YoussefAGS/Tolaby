import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextFormFieldComponent extends StatefulWidget {

  TextEditingController controller;
  String hint;
  String labl;
  TextInputType typeKeyboard;
  TextInputAction action;
  String ? Function(String?) validate;


  TextFormFieldComponent({super.key,
    required this.action,
    required this.controller,
    required this.hint,
    required this.typeKeyboard,
    required this.validate,
    required this.labl,
  });

  @override
  State<TextFormFieldComponent> createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.ltr,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),
      ],
      validator: widget.validate,
      keyboardType: widget.typeKeyboard,
      textInputAction: widget.action,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.labl,
        labelStyle:  const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
            fontSize: 16,fontWeight: FontWeight.normal),
        hintStyle: const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
            fontSize: 16,fontWeight: FontWeight.normal),
        focusColor: Colors.cyan,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      style: const TextStyle(
        color: Color.fromRGBO(36, 39, 43, 1.0),
        fontWeight: FontWeight.normal,
        fontSize: 18,
      ),
    );
  }
}
