import 'package:books_app/generated/l10n.dart';
import 'package:books_app/providers/books_provider.dart';

import 'package:flutter/material.dart';

class FilterDialogContent extends StatefulWidget {
  final String query;
  final SortType sortType;
  final Function(String, SortType) onSaved;

  const FilterDialogContent({
    super.key,
    required this.query,
    required this.sortType,
    required this.onSaved,
  });

  @override
  State<FilterDialogContent> createState() => _FilterDialogContentState();
}

class _FilterDialogContentState extends State<FilterDialogContent> {
  final TextEditingController _queryController = TextEditingController();
  final ValueNotifier<SortType> _sortType = ValueNotifier(SortType.none);

  @override
  void initState() {
    //
    _queryController.text = widget.query;
    _sortType.value = widget.sortType;
    super.initState();
  }

  @override
  void dispose() {
    _queryController.dispose();
    _sortType.dispose();
    super.dispose();
  }

  void toggleSortType(SortType type) {
    if (_sortType.value == type) {
      _sortType.value = SortType.none;
      return;
    }
    _sortType.value = type;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      scrollable: true,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: Theme.of(context).primaryColor,
            side: BorderSide(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).back),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: const StadiumBorder(),
            side: const BorderSide(
              width: 2,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            widget.onSaved(_queryController.text, _sortType.value);
            // print(widget.query);

            Navigator.of(context).pop();
          },
          child: Text(
            S.of(context).save,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
      content: ValueListenableBuilder<SortType>(
          valueListenable: _sortType,
          builder: (context, sortType, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _queryController,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                        color: Colors.grey[700],
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      labelText: S.of(context).searchByName),
                ),
                const SizedBox(
                  height: 15,
                ),
                _FilterRow(
                  label: S.of(context).sortByAthAsc,
                  sortType: SortType.authorAsc,
                  value: sortType,
                  onPressed: toggleSortType,
                ),
                _FilterRow(
                  label: S.of(context).sortByAthDes,
                  sortType: SortType.authorDesc,
                  value: sortType,
                  onPressed: toggleSortType,
                ),
                _FilterRow(
                  label: S.of(context).sortByTitleAsc,
                  sortType: SortType.titleAsc,
                  value: sortType,
                  onPressed: toggleSortType,
                ),
                _FilterRow(
                  label: S.of(context).sortByAthDes,
                  sortType: SortType.titleDesc,
                  value: sortType,
                  onPressed: toggleSortType,
                ),
              ],
            );
          }),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String label;
  final SortType sortType;
  final SortType value;
  final Function(SortType) onPressed;

  const _FilterRow({
    required this.label,
    required this.sortType,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[700]),
        ),
        Checkbox(
          side: BorderSide(color: Theme.of(context).primaryColor),
          activeColor: Theme.of(context).primaryColor,
          value: value == sortType,
          onChanged: (_) => onPressed(sortType),
        ),
      ],
    );
  }
}
