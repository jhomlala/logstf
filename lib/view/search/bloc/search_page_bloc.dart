import 'package:logstf/view/common/bloc_provider.dart';
import 'package:logstf/model/internal/search_data.dart';

class SearchPageBloc {
  SearchData _searchData;

  setSearchData(SearchData searchData){
    if (searchData != null){
      _searchData = searchData;
    } else {
      _searchData = SearchData();
    }
  }

  SearchData getSearchData(){
    return _searchData;
  }
}

class SearchPageBlocProvider extends BlocProvider<SearchPageBloc>{
  @override
  SearchPageBloc create() {
    return SearchPageBloc();
  }

}
