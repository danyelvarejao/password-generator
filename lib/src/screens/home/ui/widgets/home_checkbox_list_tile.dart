import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class HomeCheckBoxListTile extends StatefulWidget {
  const HomeCheckBoxListTile({Key? key, required this.title, required this.value, required this.onValueChanged})
      : super(key: key);

  final String title;
  final bool value;
  final Function(bool) onValueChanged;

  @override
  State<HomeCheckBoxListTile> createState() => _HomeCheckBoxListTileState();
}

class _HomeCheckBoxListTileState extends State<HomeCheckBoxListTile> {
  late bool _isChecked;

  @override
  void initState() {
    _isChecked = widget.value;
    super.initState();
  }

  void toggleChecked() {
    setState(() {
      _isChecked = !_isChecked;
    });

    widget.onValueChanged.call(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: toggleChecked,
        child: Row(
          children: [
            SizedBox(
              width: 24.0,
              height: 24.0,
              child: Checkbox(
                activeColor: AppColors.neonGreen,
                checkColor: AppColors.veryDarkGrey,
                value: _isChecked,
                onChanged: (bool? value) => toggleChecked(),
              ),
            ),
            const SizedBox(width: 8.0),
            Flexible(
              child: Text(widget.title),
            ),
          ],
        ),
      ),
    );
  }
}
