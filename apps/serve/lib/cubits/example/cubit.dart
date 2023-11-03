import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

// this could probably live in the domain layer
class ObjectStruct extends Equatable {
  final String name;
  final String photo;

  const ObjectStruct({
    required this.name,
    required this.photo,
  });

  @override
  List<Object> get props => [name, photo];
}

// this could probably live in the domain layer
enum ActiveStatus {
  hidden,
  full,
}

const initialExample = ExampleState(
  status: ActiveStatus.full,
  statusPrior: ActiveStatus.full,
  headerStatus: ActiveStatus.full,
  headerStatusPrior: ActiveStatus.full,
  object: ObjectStruct(name: '', photo: ''),
);

class ExampleCubit extends Cubit<ExampleCubitState> {
  ExampleCubit() : super(initialExample);

  void reset() => emit(initialExample);

  void update({
    ActiveStatus? status,
    ActiveStatus? statusPrior,
    ActiveStatus? headerStatus,
    ActiveStatus? headerStatusPrior,
    ObjectStruct? object,
  }) =>
      emit(ExampleState(
        status: status ?? state.status,
        statusPrior: statusPrior ?? state.statusPrior,
        headerStatus: headerStatus ?? state.headerStatus,
        headerStatusPrior: headerStatusPrior ?? state.headerStatusPrior,
        object: object ?? state.object,
      ));

  void hide() => update(
        status: ActiveStatus.hidden,
        statusPrior: state.status,
        headerStatus: ActiveStatus.hidden,
        headerStatusPrior: state.headerStatus,
      );
  void show() => update(
        status: ActiveStatus.full,
        statusPrior: state.status,
        headerStatus: ActiveStatus.full,
        headerStatusPrior: state.headerStatus,
      );

  void toggleHidden() {
    if (state.status == ActiveStatus.full) {
      hide();
    } else if (state.status == ActiveStatus.hidden) {
      show();
    }
  }
}


/* example use:
import 'package:flutter_bloc/flutter_bloc.dart';

// using the bloc pattern allows you to favor StatelessWidgets
class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ExampleCubit, ExampleCubitState>(
        
        // you don't have to re-build on every state change
        buildWhen: (previous, current) => previous.status != current.status,

        // build according to current state
        builder: (context, state) => state.status == ActiveStatus.full
              ? Body(name: state.object.name)
              : const SizedBox.shrink()); // could be button to change state
}
*/