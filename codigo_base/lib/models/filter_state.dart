import '../base/index.dart';

class FilterState {
  final FilterOption selectedFilter;
  final int filterValue;
  final bool isSwitchEnabled;
  FilterState({required this.selectedFilter, required this.filterValue, required this.isSwitchEnabled});
}