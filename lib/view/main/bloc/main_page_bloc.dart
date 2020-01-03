import '../../common/bloc_provider.dart';

class MainPageBloc {}

class MainPageBlocProvider extends BlocProvider<MainPageBloc> {
  @override
  MainPageBloc create() {
    return MainPageBloc();
  }
}

final MainPageBloc logsSearchBloc = MainPageBloc();
