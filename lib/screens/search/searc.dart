import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshop/Component/component.dart';
import 'package:newshop/screens/settings/cubit_search/cubit_sea.dart';
import 'package:newshop/screens/settings/cubit_search/state_search.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitSearch(),
      child: BlocConsumer<CubitSearch, SearchCubitState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controlText: searchControl,
                          onSubmit: (String searchValue) {
                            CubitSearch.get(context).getSearchData(searchValue);
                          },
                          validate: (String valueSearch) {
                            if (valueSearch.isEmpty) {
                              return 'You must write word to search';
                            }
                            return null;
                          },
                          textLabel: 'Search',
                          prefix: Icons.search,
                          type: TextInputType.text),
                      SizedBox(
                        height: 8,
                      ),
                      if (state is LoadingStateSearch)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SuccessStateSearch)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  listProductBuilder(
                                      CubitSearch.get(context)
                                          .searchModel
                                          .data
                                          .data[index],
                                      context,
                                      isOldPrice: false),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: CubitSearch.get(context)
                                  .searchModel
                                  .data
                                  .data
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
