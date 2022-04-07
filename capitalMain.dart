
import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:persistent_context/persistent_context.dart';
import 'package:quiz_app_ii_example/Color/Colors.dart';
import 'package:quiz_app_ii_example/buttons/share.dart';
import 'package:quiz_app_ii_example/buttons/tinderColumn.dart';
import 'package:quiz_app_ii_example/buttons/ask_friend.dart';
import 'package:quiz_app_ii_example/music/music.dart';
import 'package:quiz_app_ii_example/page/tindercard.dart';
import 'package:screenshot/screenshot.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../final/final_fields.dart';
import 'array_capital_allLevels.dart';
import 'array_capital_easy.dart';
import 'array_capital_hard.dart';
import 'array_capital_middle.dart';


class CapitalMain extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<CapitalMain> {


  // TODO: Add _rewardedAd
  // late RewardedAd rewardedAd;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    RewardedAd.load(
        adUnitId: reward,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad){
          print("Rewarded loaded");
          rewardedAd=ad;
          setState(() {
            isLoad=true;
          });
        }, onAdFailedToLoad: (error){
          print("Rewarded error");
        }));
  }


  QuestionCapitalData data = QuestionCapitalData();
  QuestionCapitalMiddleData data_midlle = QuestionCapitalMiddleData();
  QuestionCapitalHardData data_hard = QuestionCapitalHardData();
  QuestionCapitalAllLevelsData  dataAllLevels =  QuestionCapitalAllLevelsData();




  final CountDownController timeController = CountDownController();
  int countResult = 0;
  int check = 0;
  int elementAt = 0;
  bool isLoad = false;
  bool heightValue = true;
  bool isClosed = false;
  late bool isCorrect;
  bool height = false;
  bool colorCorrect = true;
  bool outlinedButton = true;
  bool color11 = false;
  bool color12 = false;
  bool color13 = false;
  bool color14 = false;
  bool color1 = false;
  bool color2 = false;
  bool color3 = false;
  bool color4 = false;
  bool animatedCrossFade = false;
  bool button5050 = true;
  bool button12_5050 = true;
  bool absorbing = false;
  bool absorbingButton = true;
  bool absorbingThreeButton = false;
  bool skipController = true;
  List <String> correctAnswer = [];
  Random random = new Random();
  List<int> pointValue = [0,1,2,3];
  late CardController controller;
  final screenController = ScreenshotController();

  void initState(){

    pointValue.shuffle();

    if(level==1) {
      data.dataEasy.shuffle();
      questionIndex = random.nextInt(data.questions.length-1);
    }
    if(level==2) {
      data_midlle.dataMiddle.shuffle();
      questionIndex = random.nextInt(data_midlle.questions.length-1);
    }
    if(level==3) {
      data_hard.dataHard.shuffle();
      questionIndex = random.nextInt(data_hard.questions.length-1);
    }
    if(level==4) {
      dataAllLevels.dataAllLevel.shuffle();
      questionIndex = random.nextInt(dataAllLevels.questions.length-1);
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) => _firstIncrement(context));

  }


  void clearState() => setState((){

    if(level==1) {
      if (questionIndex >= data.questions.length-1) {
        questionIndex = 0;
      } else
        questionIndex++;
    }
    if(level==2) {
      if (questionIndex >= data_midlle.questions.length-1) {
        questionIndex = 0;
      } else
        questionIndex++;
    }
    if(level==3) {
      if (questionIndex >= data_hard.questions.length-1) {
        questionIndex = 0;
      } else
        questionIndex++;
    }
    if(level==4) {
      if (questionIndex >= dataAllLevels.questions.length-1) {
        questionIndex = 0;
      } else
        questionIndex++;
    }

  });
  void Navigatorr() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }


//показ диалога при запуске
  void _firstIncrement(BuildContext context) {
    final currentCount = PersistentContext.of(context).get('counter') ?? counter;
    if(currentCount<1){
      timeController.pause();
      setState(() {
        absorbing=true;
        absorbingThreeButton=true;
      });
      CoolAlert.show(
        confirmBtnTextStyle: TextStyle(fontSize: 11,color: Colors.white),
        confirmBtnColor: Color(0xff42b5a4),
        backgroundColor: Color(0xff42b5a4),
        confirmBtnText: "watchAds1".tr(),
        cancelBtnText: 'exit'.tr(),
        barrierDismissible: false,
        lottieAsset: "assets/favorite.json",
        loopAnimation: true,
        type: CoolAlertType.info,
        title: "outLives".tr(),
        showCancelBtn: true,
        onCancelBtnTap:() =>  Navigatorr(),
        onConfirmBtnTap:() =>
            rewardedAd.show(onUserEarnedReward: (ad,reward){
              PersistentContext.of(context).set(
                'counter',
                currentCount+1,
              );
              absorbing=false;
              absorbingThreeButton=false;
              Navigator.of(context).pop();
              timeController.start();
              if(button5050==false) {
                button5050=!button5050;
              }
              if(button12_5050==false) {
                button12_5050=!button12_5050;
              }
            }
            ),
        context: context,
        text: "watchVideo".tr(),
      );
    }
  }

//показ диалога при нехватке
  void _increment(BuildContext context) {

    if (fullVersion == 1) {
      final currentCount = PersistentContext.of(context).get('counter') ??
          counter;

      if (currentCount > 1) {
        PersistentContext.of(context).set(
          'counter',
          currentCount - 1,
        );
      }
      if (currentCount < 2) {
        PersistentContext.of(context).set(
          'counter',
          currentCount - 1,
        );
        setState(() {
          timeController.pause();
          absorbingButton=!absorbingButton;
        });
        CoolAlert.show(
          confirmBtnTextStyle: TextStyle(fontSize: 11,color: Colors.white),
          confirmBtnColor: Color(0xff42b5a4),
          backgroundColor: Color(0xff42b5a4),
          confirmBtnText: "watchAds1".tr(),
          cancelBtnText: 'exit'.tr(),
          barrierDismissible: false,
          lottieAsset: "assets/favorite.json",
          loopAnimation: true,
          type: CoolAlertType.info,
          title: "outLives".tr(),
          showCancelBtn: true,
          onCancelBtnTap: () => Navigatorr(),
          onConfirmBtnTap: () =>
              rewardedAd.show(onUserEarnedReward: (ad, reward) {
                PersistentContext.of(context).set(
                  'counter',
                  currentCount,
                );
                Navigator.of(context).pop();
                absorbingButton=!absorbingButton;
              }
              ),
          context: context,
          text: "watchVideo".tr(),
        );
      }
    }
  }

  style(){
    return TextStyle(fontSize: 14,
        color: Colors.white,fontWeight: FontWeight.bold,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0.6, 0.6),
            blurRadius: 1.0,
            color: Colors.black26,
          ),
          Shadow(
            offset: Offset(0.6, 0.6),
            blurRadius: 1.0,
            color: Colors.black26,
          ),
        ] );
  }

  @override
  Widget build(BuildContext context) {
    level = PersistentContext.of(context).get('level') ?? 1;
    return Screenshot(controller: screenController,
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(color: ColorConstants.TealColor,
              gradient: LinearGradient(
                colors: [ColorConstants.amberAccentColor, ColorConstants.amberAccent80Color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10,),

                //таймер
                CircularCountDownTimer(
                  controller: timeController,
                  textStyle: TextStyle(color: Colors.white),
                  duration: 31,
                  width: 40,
                  height: 40,
                  fillColor: Colors.lightGreen,
                  ringColor: ColorConstants.TransparentColor,
                  isReverseAnimation: true,
                  isReverse: true,
                  textFormat: CountdownTextFormat.S,
                  autoStart: true,
                  onComplete: (){
                    setState(() {
                      _increment(context);
                      absorbingButton=!absorbingButton;
                      correctAnswer.clear();
                      correctAnswer.add('timeout'.tr());
                      //  _questionIndex++;
                      heightValue =! heightValue;
                      absorbing =!absorbing;

                      if(pointValue.elementAt(0) == 0) {
                        color11 = !color11;
                        colorCorrect =false;
                      }
                      if(pointValue.elementAt(1) == 0) {
                        color12 = !color12;
                        colorCorrect =false;
                      }
                      if(pointValue.elementAt(2) == 0) {
                        color13 = !color13;
                        colorCorrect =false;
                      }
                      if(pointValue.elementAt(3) == 0) {
                        color14 = !color14;
                        colorCorrect =false;
                      }

                      Future.delayed(const Duration(milliseconds: 1000),(){
                        setState(() {
                          isClosed=!isClosed;
                          height=!height;
                          animatedCrossFade=!animatedCrossFade;
                        });
                      });
                    });
                  },
                ),

                Spacer(flex: 1),

                //Tinder, карточки
                ZoomTapAnimation(begin: 1.0,end: 1.5,
                  onTap: (){},
                  child: AbsorbPointer(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: height?MediaQuery.of(context).size.height * 0.65: MediaQuery.of(context).size.height * 0.5,
                      width: height?MediaQuery.of(context).size.width * 1.2:  MediaQuery.of(context).size.width * 0.9,
                      child: TinderSwapCard(
                        allowVerticalMovement: false,
                        orientation: AmassOrientation.top,
                        totalNum:
                        (level==1)? data.questions[questionIndex].title.length :
                        (level==2)?data_midlle.questions[questionIndex].title.length :
                        (level==3)?data_hard.questions[questionIndex].title.length:
                            dataAllLevels.questions[questionIndex].title.length,
                        stackNum: 5,
                        maxWidth: height?MediaQuery.of(context).size.width * 1.0 : MediaQuery.of(context).size.width * 0.9,
                        maxHeight: height? MediaQuery.of(context).size.height * 1.7:MediaQuery.of(context).size.width * 0.9,
                        minWidth: MediaQuery.of(context).size.width * 0.65,
                        minHeight: MediaQuery.of(context).size.width * 0.89,
                        cardBuilder: (context, index) => Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side:BorderSide(
                              color: Colors.black,
                              width: 0.2,
                            ),
                          ),
                          child: TinderColumn(
                            colorCorrect:colorCorrect,
                            correctAnswer:correctAnswer,
                            height:height,
                            questionIndex:questionIndex,
                            data:
                            (level==1)?
                            data :
                            (level==2)?
                            data_midlle :
                            (level==3)?
                            data_hard: dataAllLevels
                          ),
                          shadowColor: Colors.black,),
                        cardController: controller = CardController(),
                        swipeUpdateCallback:
                            (DragUpdateDetails details, Alignment align)  {
                          /// Get swiping card's alignment
                          if (align.x < 0) {

                          } else if (align.x > 0) {
                            //Card is RIGHT swiping
                          }
                        },
                        swipeCompleteCallback:
                            (CardSwipeOrientation orientation, int index) {

                          /// Get orientation & index of swiped card!
                        },
                      ),
                    ),
                  ),
                ),

                Spacer(flex: 2),
                // верхние 3 кнопки, их анимация, кнопка продолжить и поделиться
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 600),
                  crossFadeState: animatedCrossFade ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild:
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //кнопка поделиться возле продолжить
                        Expanded(
                          child: Stack(alignment:  AlignmentDirectional.topCenter,
                            children: [
                              //кнопка поделиться
                              ShareButton(screenController: screenController,),
                            ],
                          ),
                          flex: 1,
                        ),
                        //кнопка продолжить
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10,left: 20),
                            child: Container(
                              child: AbsorbPointer(absorbing: absorbingButton,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    //side: BorderSide( width: 0.8, color: Colors.black38),
                                    backgroundColor: Colors.lightGreen,
                                  ),
                                  onPressed:() {
                                    setState(() {
                                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                                      pointValue.shuffle();
                                      height=!height;
                                      color1=false;
                                      color2=false;
                                      color3=false;
                                      color4=false;
                                      color11=false;
                                      color12=false;
                                      color13=false;
                                      color14=false;
                                      absorbing=!absorbing;
                                      absorbingButton=!absorbingButton;

                                      if(button5050==false) {
                                        button5050=!button5050;
                                      }
                                      if(button12_5050==false) {
                                        button12_5050=!button12_5050;
                                      }

                                      Future.delayed(const Duration(milliseconds: 700),(){
                                        setState(() {
                                          controller.triggerRight();

                                          Future.delayed(const Duration(milliseconds: 800),(){
                                            setState(() {
                                              timeController.restart();
                                              clearState();
                                              isClosed=!isClosed;
                                              animatedCrossFade=!animatedCrossFade;

                                            });
                                          });
                                        });
                                      });
                                    });
                                  },
                                  child: Wrap(
                                    spacing: 8.0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      Text(('continue').tr(),style:TextStyle(fontSize:20,color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          flex: 4,
                        ),
                      ],),
                  ),
                  secondChild:
                  AbsorbPointer(
                    absorbing: absorbingThreeButton,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //кнопка 50х50
                        Expanded (
                          child: Stack(alignment: AlignmentDirectional.topCenter,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 2),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 1500),
                                  child:
                                  Container(width: MediaQuery.of(context).size.width,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        //side: BorderSide( width: 0.8, color: Colors.black38),
                                        backgroundColor: ColorConstants.TransparentColor,
                                      ),
                                      onPressed:() {
                                        setState(() {
                                          Music.instance.playerCorrect();
                                          // skipController=false;
                                          _increment(context);
                                          // preferences.setInt('counter',  10);
                                          timeController.pause();
                                          // preferences.setInt('counter', count-1);
                                          //counter.$ += 1;
                                          if(pointValue.elementAt(0) == 0 ||pointValue.elementAt(1) == 0 ) {
                                            button5050 = false;
                                          }
                                          if(pointValue.elementAt(2) == 0 ||pointValue.elementAt(3) == 0 ) {
                                            button12_5050 = false;
                                          }
                                        });
                                      },
                                      child: FittedBox(fit: BoxFit.contain,
                                        child: Wrap(spacing: 10.0, crossAxisAlignment: WrapCrossAlignment.center,alignment: WrapAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.help_outline,
                                              color: Colors.white,
                                              size: 20.0,
                                            ),
                                            Text("50/50", style:TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child:(fullVersion==1)? Stack(alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.favorite,color: Colors.white, size: 20.0,),
                                    Text('-1', style:TextStyle(fontSize:12))
                                  ],):SizedBox.shrink(),
                                right: 15,
                                bottom: 30,
                              )
                            ],
                          ),
                          flex: 1,
                        ),

                        //кнопка поделиться с другом
                        Expanded (
                          child: Stack(alignment:  AlignmentDirectional.topCenter,
                            children: [
                              AskFriend(screenController: screenController,timeController: timeController,),
                            ],
                          ),
                          flex: 1,
                        ),

                        //кнопка пропустить
                        Expanded (
                          child: Stack(alignment: AlignmentDirectional.topCenter,
                            children: [Padding(
                              padding: const EdgeInsets.only(left: 2.0,right: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    //side: BorderSide( width: 0.8, color: Colors.black38),
                                    backgroundColor: ColorConstants.TransparentColor,
                                  ),
                                  onPressed:() {
                                    setState(()  {
                                      Music.instance.playerCorrect();
                                      _increment(context);
                                      timeController.pause();
                                      skipController=true;
                                      absorbingButton=!absorbingButton;

                                      correctAnswer.clear();
                                      correctAnswer.add(('skip1').tr());
                                      //  _questionIndex++;
                                      heightValue =! heightValue;
                                      absorbing =!absorbing;

                                      if(pointValue.elementAt(0) == 0) {
                                        color11 = !color11;
                                        colorCorrect =true;
                                      }
                                      if(pointValue.elementAt(1) == 0) {
                                        color12 = !color12;
                                        colorCorrect =false;
                                      }
                                      if(pointValue.elementAt(2) == 0) {
                                        color13 = !color13;
                                        colorCorrect =false;
                                      }
                                      if(pointValue.elementAt(3) == 0) {
                                        color14 = !color14;
                                        colorCorrect =false;
                                      }

                                      Future.delayed(const Duration(milliseconds: 1000),(){
                                        setState(() {
                                          isClosed=!isClosed;
                                          height=!height;
                                          animatedCrossFade=!animatedCrossFade;
                                        });
                                      });
                                    });
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Wrap(
                                      spacing: 8.0,
                                      alignment: WrapAlignment.start,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.double_arrow,
                                          color: Colors.white,
                                          size: 18.0,
                                        ),
                                        Text(("skip").tr(), style:TextStyle(fontSize:12,color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),


                              Positioned(
                                child: (fullVersion==1)?Stack(alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.favorite,color: Colors.white, size: 20.0,),
                                    Text('-1', style:TextStyle(fontSize:12))
                                  ],):SizedBox.shrink(),
                                right: 15,
                                bottom: 30,
                              )
                            ],
                          ),
                          flex: 1,
                        ),
                      ],),
                  ),
                ),

                AbsorbPointer(
                  absorbing: absorbing,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    height: isClosed ? 0.0 : 145.0,
                    curve: Curves.decelerate,
                    child: SingleChildScrollView(child:
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        mainAxisExtent:MediaQuery.of(context).size.height * grid,
                      ),
                      children: [
                        //кнопка 1 (слева вверху)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          color: color11 ? ColorConstants.GreenColor : Colors.transparent,
                          child:button12_5050? OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              //side: BorderSide( width: 0.8, color: Colors.black38),
                              backgroundColor:  color1 ? ColorConstants.RedColor : ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            child:
                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:style(),textAlign: TextAlign.center,)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:style(),textAlign: TextAlign.center,)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:style(),textAlign: TextAlign.center,)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:style(),textAlign: TextAlign.center,)),
                            onPressed: () {
                              setState(() {
                                skipController=true;
                                timeController.pause();
                                absorbingButton=!absorbingButton;
                                correctAnswer.clear();

                                (level==1)?
                                correctAnswer.add('${data.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[0])}'):
                                (level==2)?
                                correctAnswer.add('${data_midlle.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[0])}'):
                                (level==3)?
                                correctAnswer.add('${data_hard.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[0])}'):
                                correctAnswer.add('${dataAllLevels.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[0])}');

                                //  _questionIndex++;
                                heightValue =!heightValue;
                                absorbing =!absorbing;

                                if(pointValue.elementAt(0) == 0) {
                                  Music.instance.playerCorrect();
                                  color11 = !color11;
                                  colorCorrect =true;
                                }
                                if(pointValue.elementAt(0) == 1) {
                                  Music.instance.playerInCorrect();
                                  color1 = !color1;
                                  colorCorrect =false;
                                  _increment(context);
                                }
                                if(pointValue.elementAt(0) == 2) {
                                  Music.instance.playerInCorrect();
                                  color1 = !color1;
                                  colorCorrect =false;
                                  _increment(context);
                                }
                                if(pointValue.elementAt(0) == 3) {
                                  Music.instance.playerInCorrect();
                                  color1 = !color1;
                                  colorCorrect =false;
                                  _increment(context);
                                }
                                if(pointValue.elementAt(1) == 0) {
                                  Music.instance.playerInCorrect();
                                  color12 = !color12;
                                  colorCorrect =false;
                                }
                                if(pointValue.elementAt(2) == 0) {
                                  Music.instance.playerInCorrect();
                                  color13 = !color13;
                                  colorCorrect =false;
                                }
                                if(pointValue.elementAt(3) == 0) {
                                  Music.instance.playerInCorrect();
                                  color14 = !color14;
                                  colorCorrect =false;
                                }

                                Future.delayed(const Duration(milliseconds: 1000),(){
                                  setState(() {
                                    isClosed=!isClosed;
                                    height=!height;
                                    animatedCrossFade=!animatedCrossFade;
                                  });
                                });
                              });},
                          ):OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              //side: BorderSide( width: 0.8, color: Colors.black38),
                              backgroundColor:ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            onPressed: () {  },
                            child:
                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:TextStyle(
                                color:button12_5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:TextStyle(
                                color:button12_5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:TextStyle(
                                color:button12_5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[0])}',style:TextStyle(
                                color:button12_5050? Colors.white:Colors.grey),textAlign: TextAlign.center)),
                          ),
                        ),

                        //кнопка 2 (справа вверху)
                        AnimatedContainer(
                          duration:Duration(milliseconds: 500),
                          color: color12 ? ColorConstants.GreenColor : Colors.transparent,
                          child: button12_5050 ? OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: color2 ?ColorConstants.RedColor : ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            child:

                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: style(),textAlign: TextAlign.center,)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: style(),textAlign: TextAlign.center,)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: style(),textAlign: TextAlign.center,)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: style(),textAlign: TextAlign.center,)),

                            onPressed: () {
                              setState(() {
                                skipController=true;
                                timeController.pause();
                                absorbingButton=!absorbingButton;
                                correctAnswer.clear();
                                (level==1)?
                                correctAnswer.add('${data.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[1])}'):
                                (level==2)?
                                correctAnswer.add('${data_midlle.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[1])}'):
                                (level==3)?
                                correctAnswer.add('${data_hard.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[1])}'):
                                correctAnswer.add('${dataAllLevels.questions[questionIndex].answer.map(
                                      (value) =>  value['answer'],
                                ).elementAt(pointValue[1])}');

                                absorbing =!absorbing;

                                if(pointValue.elementAt(1) == 0) {
                                  Music.instance.playerCorrect();
                                  color12 = !color12;
                                  colorCorrect =true;
                                }
                                if(pointValue.elementAt(1) == 1) {
                                  Music.instance.playerInCorrect();
                                  color2 = !color2;
                                  colorCorrect =false;
                                  _increment(context);
                                }
                                if(pointValue.elementAt(1) == 2) {
                                  Music.instance.playerInCorrect();
                                  color2 = !color2;
                                  colorCorrect =false;
                                  _increment(context);
                                }
                                if(pointValue.elementAt(1) == 3) {
                                  Music.instance.playerInCorrect();
                                  color2 = !color2;
                                  colorCorrect =false;
                                  _increment(context);
                                }

                                if(pointValue.elementAt(0) == 0) {
                                  Music.instance.playerInCorrect();
                                  color11 = !color11;
                                  colorCorrect =false;
                                }
                                if(pointValue.elementAt(2) == 0) {
                                  Music.instance.playerInCorrect();
                                  color13 = !color13;
                                  colorCorrect =false;
                                }
                                if(pointValue.elementAt(3) == 0) {
                                  Music.instance.playerInCorrect();
                                  color14 = !color14;
                                  colorCorrect =false;
                                }

                                Future.delayed(const Duration(milliseconds: 1000),(){
                                  setState(() {
                                    isClosed=!isClosed;
                                    height=!height;
                                    animatedCrossFade=!animatedCrossFade;
                                  });
                                });

                              });},
                          ):OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            onPressed: () {  },
                            child:
                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: TextStyle(
                                color:button12_5050? Colors.white:Colors.grey ),textAlign: TextAlign.center)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: TextStyle(
                                color:button12_5050? Colors.white:Colors.grey ),textAlign: TextAlign.center)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: TextStyle(
                                color:button12_5050? Colors.white:Colors.grey ),textAlign: TextAlign.center)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[1])}',style: TextStyle(
                                color:button12_5050? Colors.white:Colors.grey ),textAlign: TextAlign.center)),
                          ),
                        ),

                        //кнопка 3 (слева внизу)
                        AnimatedContainer(
                          duration:Duration(milliseconds: 500),
                          color: color13 ? ColorConstants.GreenColor : Colors.transparent,
                          child:button5050? OutlinedButton(
                            style: OutlinedButton.styleFrom(

                              backgroundColor: color3 ? ColorConstants.RedColor : ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            child:

                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: style(),textAlign: TextAlign.center,)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: style(),textAlign: TextAlign.center,)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: style(),textAlign: TextAlign.center,)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: style(),textAlign: TextAlign.center,)),

                            onPressed: () {

                              setState(() {
                                skipController=true;
                                timeController.pause();
                                absorbingButton = !absorbingButton;
                                correctAnswer.clear();

                                (level==1)?
                                correctAnswer.add(
                                    '${data.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[2])}'):
                                (level==2)?
                                correctAnswer.add(
                                    '${data_midlle.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[2])}'):
                                (level==3)?
                                correctAnswer.add(
                                    '${data_hard.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[2])}'):
                                correctAnswer.add(
                                    '${dataAllLevels.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[2])}');


                                absorbing = !absorbing;

                                if (pointValue.elementAt(2) == 0) {
                                  Music.instance.playerCorrect();
                                  color13 = !color13;
                                  colorCorrect = true;
                                }
                                if (pointValue.elementAt(2) == 1) {
                                  Music.instance.playerInCorrect();
                                  color3 = !color3;
                                  colorCorrect = false;
                                  _increment(context);
                                }
                                if (pointValue.elementAt(2) == 2) {
                                  Music.instance.playerInCorrect();
                                  color3 = !color3;
                                  colorCorrect = false;
                                  _increment(context);
                                }
                                if (pointValue.elementAt(2) == 3) {
                                  Music.instance.playerInCorrect();
                                  color3 = !color3;
                                  colorCorrect = false;
                                  _increment(context);
                                }


                                if (pointValue.elementAt(0) == 0) {
                                  Music.instance.playerInCorrect();
                                  color11 = !color11;
                                  colorCorrect = false;
                                }
                                if (pointValue.elementAt(1) == 0) {
                                  Music.instance.playerInCorrect();
                                  color12 = !color12;
                                  colorCorrect = false;
                                }
                                if (pointValue.elementAt(3) == 0) {
                                  Music.instance.playerInCorrect();
                                  color14 = !color14;
                                  colorCorrect = false;
                                }

                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  setState(() {
                                    isClosed = !isClosed;
                                    height = !height;
                                    animatedCrossFade = !animatedCrossFade;
                                  });
                                });
                              });
                            },
                          ):OutlinedButton(
                            style: OutlinedButton.styleFrom(

                              backgroundColor:ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            onPressed: () {  },
                            child:

                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center,)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[2])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center)),


                          ),
                        ),

                        //кнопка 4 (справа внизу)
                        AnimatedContainer(
                          duration:Duration(milliseconds: 500),
                          color: color14 ? ColorConstants.GreenColor : Colors.transparent,
                          child: button5050? OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: color4 ? ColorConstants.RedColor : ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            child:

                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: style(),textAlign: TextAlign.center,)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: style(),textAlign: TextAlign.center,)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: style(),textAlign: TextAlign.center,)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: style(),textAlign: TextAlign.center,)),

                            onPressed: () {
                              setState(()  {
                                //  playerSound();
                                skipController=true;
                                timeController.pause();
                                absorbingButton = !absorbingButton;
                                correctAnswer.clear();

                                (level==1)?
                                correctAnswer.add(
                                    '${data.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[3])}'):
                                (level==2)?
                                correctAnswer.add(
                                    '${data_midlle.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[3])}'):
                                (level==3)?
                                correctAnswer.add(
                                    '${data_hard.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[3])}'):
                                correctAnswer.add(
                                    '${dataAllLevels.questions[questionIndex].answer
                                        .map(
                                          (value) => value['answer'],
                                    ).elementAt(pointValue[3])}');

                                absorbing = !absorbing;

                                if (pointValue.elementAt(3) == 0) {
                                  Music.instance.playerCorrect();
                                  color14 = !color14;
                                  colorCorrect = true;
                                }
                                if (pointValue.elementAt(3) == 1) {
                                  Music.instance.playerInCorrect();
                                  color4 = !color4;
                                  colorCorrect = false;
                                  _increment(context);
                                }
                                if (pointValue.elementAt(3) == 2) {
                                  Music.instance.playerInCorrect();
                                  color4 = !color4;
                                  colorCorrect = false;
                                  _increment(context);
                                }
                                if (pointValue.elementAt(3) == 3) {
                                  Music.instance.playerInCorrect();
                                  color4 = !color4;
                                  colorCorrect = false;
                                  _increment(context);
                                }

                                if (pointValue.elementAt(0) == 0) {
                                  Music.instance.playerInCorrect();
                                  color11 = !color11;
                                  colorCorrect = false;
                                }
                                if (pointValue.elementAt(1) == 0) {
                                  Music.instance.playerInCorrect();
                                  color12 = !color12;
                                  colorCorrect = false;
                                }
                                if (pointValue.elementAt(2) == 0) {
                                  Music.instance.playerInCorrect();
                                  color13 = !color13;
                                  colorCorrect = false;
                                }

                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  setState(() {
                                    isClosed = !isClosed;
                                    height = !height;
                                    animatedCrossFade = !animatedCrossFade;
                                  });
                                });
                              });
                            },
                          ):OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor:  ColorConstants.TransparentColor,
                            ),
                            // color: color ? Colors.blue : Colors.transparent,
                            onPressed: () {  },
                            child:

                            (level==1)?
                            ListTile(title: Text('${data.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            (level==2)?
                            ListTile(title: Text('${data_midlle.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            (level==3)?
                            ListTile(title: Text('${data_hard.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center)):
                            ListTile(title: Text('${dataAllLevels.questions[questionIndex].answer.map(
                                  (value) =>  value['answer'],
                            ).elementAt(pointValue[3])}',style: TextStyle(
                                color:button5050? Colors.white:Colors.grey),textAlign: TextAlign.center))

                          ),
                        )
                      ],
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
