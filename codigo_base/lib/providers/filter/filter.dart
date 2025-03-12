import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import '../../base/index.dart';
import '../../models/index.dart';

part 'filter.g.dart';

@riverpod
class FilterNotifier extends _$FilterNotifier {
  @override
  FilterState build() {
    return FilterState(
        selectedFilter: FilterOption.todos,
        filterValue: 50,
        isSwitchEnabled: false);
  }

  void setFilterOption(FilterOption option) {
    state = FilterState(
        selectedFilter: option,
        filterValue: state.filterValue,
        isSwitchEnabled: state.isSwitchEnabled);
  }

  void setFilterValue(int newValue) {
    state = FilterState(
        selectedFilter: state.selectedFilter,
        filterValue: newValue,
        isSwitchEnabled: state.isSwitchEnabled);
  }

  void toggleSwitch(bool newValue) {
    state = FilterState(
        selectedFilter: state.selectedFilter,
        filterValue: state.filterValue,
        isSwitchEnabled: newValue);
  }
}

@riverpod
List<DropdownMenuItem<FilterOption>> filterOptions(ref) {
  final filterState = ref.watch(filterNotifierProvider);
  return [
    DropdownMenuItem(value: FilterOption.todos, child: Text('Todos')),
    DropdownMenuItem(
        value: FilterOption.menorIgualN,
        child: Text('Precio ≤ ${filterState.filterValue}')),
    DropdownMenuItem(
        value: FilterOption.mayorN,
        child: Text('Precio > ${filterState.filterValue}')),
  ];
}
