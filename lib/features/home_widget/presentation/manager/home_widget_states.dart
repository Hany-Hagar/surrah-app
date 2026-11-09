sealed class HomeWidgetStates {}

class HomeWidgetInitialState extends HomeWidgetStates {}

// Get Data

class GetDataLoading extends HomeWidgetStates {}

class GetDataSuccess extends HomeWidgetStates {}

// Update Data

class UpdateDataLoading extends HomeWidgetStates {}

class UpdateDataSuccess extends HomeWidgetStates {}

class UpdateDataFailure extends HomeWidgetStates {
  final String message;
  UpdateDataFailure(this.message);
}

// Update Widget
class UpdateWidgetLoading extends HomeWidgetStates {}

class UpdateWidgetSuccess extends HomeWidgetStates {}

class UpdateWidgetFailure extends HomeWidgetStates {
  final String message;
  UpdateWidgetFailure(this.message);
}


