import 'package:flutter/material.dart';
import '../../../widgets/actions/bla_icon_button.dart';

import '../../../../model/ride/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../ride_pref/widgets/ride_pref_form.dart';

class RidePrefModal extends StatelessWidget {
  const RidePrefModal({super.key, required this.initialPreference});

  final RidePreference? initialPreference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back icon
            BlaIconButton(
              onPressed: () => onBackSelected(context), 
              icon: Icons.close
            ),
            SizedBox(height: BlaSpacings.m),

            // Title
            Text(
              "Edit your search",
              style: BlaTextStyles.title.copyWith(color: BlaColors.textNormal),
            ),

            // Form
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: RidePrefForm(
                  initialPreference: initialPreference,
                  onSubmit: (pref) => onSubmit(context, pref),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onBackSelected(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onSubmit(BuildContext context, RidePreference newPreference) {
    Navigator.of(context).pop(newPreference);
  }
}