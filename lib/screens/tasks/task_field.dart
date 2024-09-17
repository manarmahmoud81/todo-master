import 'package:flutter/material.dart';

class TaskFiled extends StatelessWidget {
  const TaskFiled(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText});

  final TextEditingController controller;
  final String labelText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.transparent)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(color: Colors.transparent)),
          label: Text(labelText),
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.grey)),
    );
  }
}
