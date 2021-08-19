import 'package:flutter/material.dart';

Widget defultButton({
  double width = double.infinity,
  Color background = Colors.cyan,
  bool isUpperCase = true,
  double raduis = 0.0,
  @required final VoidCallback? function,
  @required String? text,
}) =>
    Container(
      width: width,
      height: 40.0,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  Function? onChange,
  Function? onSubmit,
  required Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool? isPassword = false,
  final VoidCallback? suffixPressed,
}) =>
    TextFormField(
      controller: controller!,
      keyboardType: type!,
      obscureText: isPassword!,
      onChanged: (s) {
        onChange!(s);
      },
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      validator: (s) {
        validate!(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        border: OutlineInputBorder(),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed!,
              )
            : null,
      ),
    );
