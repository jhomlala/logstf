import 'package:inject/inject.dart';
import 'package:logstf/bloc/log_details_bloc.dart';

@module
class BlocModule {
  @provide
  Provider<LogDetailsBloc> provideLogDetailsBloc() {
    return Provider<LogDetailsBloc>(() => LogDetailsBloc());
  }
}

typedef S ItemCreator<S>();
class Provider<T> {
  ItemCreator<T> creator;
  Provider(this.creator);
  T create() {
    return creator();
  }
}
