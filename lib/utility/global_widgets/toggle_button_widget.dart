import 'package:flutter/material.dart';

class ToggleSliderWidget extends StatefulWidget {
   ToggleSliderWidget({super.key,required this.isClosed});
   bool isClosed;
  @override
  _ToggleSliderWidgetState createState() => _ToggleSliderWidgetState();
}

class _ToggleSliderWidgetState extends State<ToggleSliderWidget> {
  bool isOn = false;

  void toggleSwitch() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: GestureDetector(
        //onTap: toggleSwitch,
        child: Container(
          width: 90,
          height: 35,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: widget.isClosed ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Stack(
            children: [
              Align(
                alignment: widget.isClosed ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.isClosed ? 'Close' : 'Open',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
