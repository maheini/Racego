import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  const ColoredButton(this.child,
      {Color? color,
      this.onPressed,
      bool? isLoading,
      bool? isDisabled,
      Key? key})
      //            if isDisabled -> isLoading=false, else isLoading = isLoading
      : isLoading = (isDisabled ?? false) ? false : (isLoading ?? false),
        isDisabled = isDisabled ?? false,
        color = isDisabled ?? false ? Colors.grey : color,
        super(key: key);

  final bool isDisabled;
  final bool isLoading;
  final Color? color;
  final Widget? child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: isLoading
          ? BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              backgroundBlendMode: BlendMode.saturation,
            )
          : null,
      padding: const EdgeInsets.all(4),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              color != null ? MaterialStateProperty.all<Color>(color!) : null,
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(20)),
        ),
        onPressed: isLoading || isDisabled ? () {} : onPressed,
        child: SizedBox(
          width: 25,
          height: 25,
          child: isLoading ? const CircularProgressIndicator() : child,
        ),
      ),
    );
  }
}
