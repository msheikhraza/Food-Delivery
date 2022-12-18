part of 'popular_imports.dart';

class PopularItemsViews extends StatelessWidget {
  const PopularItemsViews({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      appBar: AppBar(title: Text("Most Popular items",style: TextStyle(color: Colors.black),),
      elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 650,
                child: GridView.custom(
                    gridDelegate: SliverWovenGridDelegate.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      pattern: const [
                        WovenGridTile(0.8),
                        WovenGridTile(
                          6 / 7,
                          crossAxisRatio: 1,
                          alignment: AlignmentDirectional.bottomEnd,
                        ),
                      ],
                    ),
                    childrenDelegate: SliverChildBuilderDelegate(
                      childCount: PopularItem.popularitemList.length,
                      (context, index) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                            height: 25 * height,
                            width: 40 * width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20 * height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                  ),
                                  child: FancyShimmerImage(
                                    imageUrl: PopularItem
                                        .popularitemList[index].imagePath!,
                                    boxFit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        PopularItem
                                            .popularitemList[index].title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        textScaleFactor: 1,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        PopularItem
                                            .popularitemList[index].subtitle!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        textScaleFactor: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ),
            ]),
      ),
    );
  }
}
