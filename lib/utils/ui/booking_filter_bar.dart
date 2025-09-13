import 'package:flutter/material.dart';

enum BookingFilter { all, pending, approved, rejected }

class BookingFilterBar extends StatelessWidget {
  const BookingFilterBar({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final BookingFilter selected;
  final ValueChanged<BookingFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        children: BookingFilter.values.map((filter) {
          return ChoiceChip(
            showCheckmark: false,
            label: Text(_filterLabel(filter)),
            selected: selected == filter,
            onSelected: (selected) {
              if (selected) onChanged(filter);
            },
          );
        }).toList(),
      ),
    );
  }

  String _filterLabel(BookingFilter filter) {
    switch (filter) {
      case BookingFilter.all:
        return 'All';
      case BookingFilter.pending:
        return 'Pending';
      case BookingFilter.approved:
        return 'Approved';
      case BookingFilter.rejected:
        return 'Denied';
    }
  }
}
