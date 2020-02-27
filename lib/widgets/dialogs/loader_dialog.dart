import 'package:flutter/material.dart';

class LoaderDialog extends StatelessWidget {
  const LoaderDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
