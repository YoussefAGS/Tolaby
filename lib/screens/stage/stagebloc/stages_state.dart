part of 'stages_bloc.dart';

@immutable
abstract class StagesState {}

class StagesInitial extends StagesState {}
class StagesSuccess extends StagesState {
  final List<Stage> stages;

  StagesSuccess(this.stages);
}
class Stagesfailer extends StagesState {}
class StagesLoading extends StagesState {}
