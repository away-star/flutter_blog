import 'package:flutter/material.dart';


/*
防止接口爆破的滑动验证组件
 */
class SliderDialog extends StatefulWidget {
  final int randomNumber;
  final int maxNumber;

  SliderDialog({required this.randomNumber,required this.maxNumber} );

  @override
  _SliderDialogState createState() => _SliderDialogState();
}

class _SliderDialogState extends State<SliderDialog> {
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Slide to verify'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_forward, size: 48),
          SizedBox(height: 24),
          Text('${widget.randomNumber}'),
          SizedBox(height: 24),
          Slider(
            min: 0,
            max: widget.maxNumber.toDouble(),
            divisions: 100,
            label: '$sliderValue',
            onChanged: (double value) {
              setState(() {
                sliderValue = value;
              });
            },
            onChangeEnd: (double value) {
              Navigator.of(context).pop(value.toInt());
            },
            value: sliderValue,
          ),
        ],
      ),
    );
  }
}
