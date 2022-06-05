import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String message;
  final void Function()? onPressed;
  const AppError(this.message, this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CupertinoButton(
              color: Colors.black,
              child: const Text('Try again',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
