part of 'stages_bloc.dart';

@immutable
abstract class StagesEvent {}
class StagesInitialEvent extends StagesEvent{}
class StagesLoadedEvent extends StagesEvent{

}
class AddStagesEvent extends StagesEvent{}
