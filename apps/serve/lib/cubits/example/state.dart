part of 'cubit.dart';

abstract class ExampleCubitState extends Equatable {
  final ActiveStatus status;
  final ActiveStatus statusPrior;
  final ActiveStatus headerStatus;
  final ActiveStatus headerStatusPrior;
  final ObjectStruct object;

  const ExampleCubitState({
    required this.status,
    required this.statusPrior,
    required this.headerStatus,
    required this.headerStatusPrior,
    required this.object,
  });

  @override
  List<Object> get props => [
        status,
        statusPrior,
        headerStatus,
        headerStatusPrior,
        object,
      ];

  double get height {
    switch (status) {
      case ActiveStatus.hidden:
        return 0;
      case ActiveStatus.full:
        return 300;
    }
  }

  double get priorHeight {
    switch (statusPrior) {
      case ActiveStatus.hidden:
        return 0;
      case ActiveStatus.full:
        return 300;
    }
  }

  bool commentChanged(ExampleCubitState previous) =>
      status != previous.status || statusPrior != previous.statusPrior;

  bool headerChanged(ExampleCubitState previous) =>
      headerStatus != previous.headerStatus ||
      headerStatusPrior != previous.headerStatusPrior;
}

class ExampleState extends ExampleCubitState {
  const ExampleState({
    required super.status,
    required super.statusPrior,
    required super.headerStatus,
    required super.headerStatusPrior,
    required super.object,
  });
}
