part of "./tracking_imports.dart";

class Prepration extends StatelessWidget {
  const Prepration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Order Has Been Placed Now its Preparing", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700), textScaleFactor: 2, textAlign: TextAlign.center,),
SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Image.network(
              "https://media.tenor.com/04Cbc1xMK68AAAAd/cooking-flavours.gif"),
        ),
            SizedBox(height: 10,),
            TweenAnimationBuilder<Duration>(
                duration: Duration(minutes: 3),
                tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
                onEnd: () {
                  print('Timer ended');
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes = value.inMinutes;
                  final seconds = value.inSeconds % 60;
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('$minutes:$seconds',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)));
                }),
            SizedBox(height: 30,),
            Consumer<GoogleMapProvider>(builder: (_,v,__){
              return         Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: appButton(
                    voidCallback: () {
                      v.animateTo(v.position!.latitude, v.position!.longitude);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TrackingView()));
                    },
                    title: AppStrings.app__trackString),
              );

            },)


          ]),
    );
  }
}
