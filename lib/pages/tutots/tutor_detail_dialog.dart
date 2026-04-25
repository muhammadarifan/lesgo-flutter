import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:lesgo_flutter/models/tutor/tutor.dart';

class TutorDetailDialog extends StatelessWidget {
  const TutorDetailDialog({super.key, required this.tutor});

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return FDialog(
      title: Text('Detail Tutor'),
      body: FItemGroup(
        style: const .delta(spacing: 4),
        intrinsicWidth: null,
        divider: .full,
        children: [
          .item(title: const Text('Name'), details: Text(tutor.name)),
          .item(title: const Text('Email'), details: Text(tutor.email ?? '')),
          .item(title: const Text('Phone'), details: Text(tutor.phone ?? '')),
          .item(
            title: const Text('Address'),
            details: Text(tutor.address ?? ''),
          ),
          .item(
            title: const Text('Gender'),
            details: Text(tutor.gender.displayName),
          ),
          .item(
            title: const Text('Status'),
            details: Text(tutor.isActive ? 'Active' : 'Inactive'),
          ),
        ],
      ),
      actions: [
        FButton(onPress: () => context.pop(), child: const Text('Close')),
      ],
    );
  }
}
