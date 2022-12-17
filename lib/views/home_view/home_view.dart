part of 'home_imports.dart';

class HomeViews extends StatefulWidget {
  const HomeViews({super.key});

  @override
  State<HomeViews> createState() => _HomeViewsState();
}

class _HomeViewsState extends State<HomeViews> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 20), (result) {
      Provider.of<GoogleMapProvider>(context, listen: false)
          .getcureentuser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 2,
              child: Center(
                child: SizedBox(
                  height: 20 * height,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        ordercard(
                          title: AppStrings.app__order__id,
                          subtitle: AppStrings.app__orderID__number,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ordercard(
                          title: AppStrings.app__order__name,
                          subtitle: AppStrings.app__ordename,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        appButton(
                            voidCallback: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => TrackingView()));
                            },
                            title: AppStrings.app__trackString)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
