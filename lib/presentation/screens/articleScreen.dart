// ignore_for_file: prefer_const_constructors

import 'package:dashborad/bloc/articles/articlest_cubit.dart';
import 'package:dashborad/presentation/wedgits/glassmorphism_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../data/remote/repo.dart';

class ArticleScreen extends StatelessWidget {
  final dynamic state;
  final dynamic cubit;
  const ArticleScreen({
    required this.state,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    Repository? repo;
    return BlocProvider(
      create: (context) => ArticlesCubit(repo ?? Repository()),
      child: BlocConsumer<ArticlesCubit, ArticlesState>(
        listener: (context, state) {},
        builder: (context, state) {
          final articleCubit = context.read<ArticlesCubit>();
          return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Draggable<Map<String, dynamic>>(
                      data: {"type": "Text"},
                      child: GlassmorphismContainer(
                        child: Center(
                          child: Text('Text',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                      ),
                      feedback: GlassmorphismContainer(
                        child: Center(
                          child: Text('Text',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                      ),
                      onDragStarted: () {
                        articleCubit.setCurrentItem("Text");
                      },
                    ),
                    SizedBox(
                      width: screenSize.width * 0.1,
                    ),
                    Draggable<Map<String, dynamic>>(
                      data: {"type": "Media"},
                      child: GlassmorphismContainer(
                        child: Center(
                          child: Text('Media',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                      ),
                      feedback: GlassmorphismContainer(
                        child: Center(
                          child: Text('Media',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white)),
                        ),
                      ),
                      onDragStarted: () {
                        articleCubit.setCurrentItem("Media");
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                GlassmorphismContainer(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.6,
                  child: Padding(
                    padding: EdgeInsets.all(screenSize.width * 0.01),
                    child: DragTarget<Map<String, dynamic>>(
                      builder: (context, accepted, rejected) {
                        return ReorderableListView.builder(
                          itemCount: articleCubit.droppedItems.length,
                          itemBuilder: (context, index) {
                            final item = articleCubit.droppedItems[index];
                            if (item['type'] == 'Text') {
                              return ListTile(
                                  key: ValueKey(item),
                                  title: Column(
                                    children: [
                                      ToolBar(
                                        controller: articleCubit.controller,
                                        toolBarColor: Colors.cyan.shade50,
                                        activeIconColor: Colors.green,
                                        padding: const EdgeInsets.all(8),
                                        iconSize: 20,
                                        toolBarConfig:
                                            articleCubit.customToolBarList,
                                      ),
                                      QuillHtmlEditor(
                                        text: "Text",
                                        controller: articleCubit.controller,
                                        minHeight: screenSize.height * 0.1,
                                      ),
                                    ],
                                  )

                                  // TextFormField(
                                  //   decoration: InputDecoration(
                                  //     labelText: 'Enter text',
                                  //   ),
                                  //   onFieldSubmitted: (value) {
                                  //     // يمكنك التعامل مع النص هنا إذا كنت بحاجة لحفظه أو استخدامه لاحقًا
                                  //   },
                                  // ),
                                  );
                            } else if (item['type'] == 'Media') {
                              return ListTile(
                                key: ValueKey(item),
                                title: InkWell(
                                  onTap: () async {
                                    // اختيار الصورة
                                  },
                                  child:
                                      Icon(Icons.add_photo_alternate, size: 48),
                                ),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                          onReorder: (oldIndex, newIndex) {
                            articleCubit.reorderItems(oldIndex, newIndex);
                          },
                        );
                      },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        articleCubit.dropingItems(data);
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
