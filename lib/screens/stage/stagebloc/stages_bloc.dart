import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tolaby/services/Stages.dart';
import '../../../modles/stage_model.dart';
part 'stages_event.dart';
part 'stages_state.dart';

class StagesBloc extends Bloc<StagesEvent, StagesState> {

  List<Stage>? stages;
  StagesBloc() : super(StagesInitial()) {
    on<StagesEvent>((event, emit) async {

      if(event is StagesLoadedEvent){
        emit(StagesLoading());
        stages=await StagesServices.getStags();
        emit(StagesSuccess(stages??[] ));
      }
      else if(event is AddStagesEvent){
        emit(StagesLoading());
        stages=await StagesServices.getStags();
        emit(StagesSuccess(stages??[] ));
      }
      else if(event is Stagesfailer){
        emit(Stagesfailer());
      }
    }

    );
  }

}
