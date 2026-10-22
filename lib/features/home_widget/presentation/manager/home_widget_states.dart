sealed class HomeWidgetStates {}

class HomeWidgetInitialState extends HomeWidgetStates {}

// Get Home Widget Data

class GetDataLoading extends HomeWidgetStates {}

class GetDataSuccess extends HomeWidgetStates {}

// Update Home Widget Setup

class UpdateDataLoading extends HomeWidgetStates {}

class UpdateDataSuccess extends HomeWidgetStates {}

class UpdateDataFailure extends HomeWidgetStates {
  final String message;
  UpdateDataFailure(this.message);
}
