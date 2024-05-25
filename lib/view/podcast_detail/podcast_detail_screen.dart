import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ecpods/dataFile/data_file.dart';
import 'package:ecpods/model/popular_model.dart';
import 'package:ecpods/routes/app_routes.dart';
import 'package:ecpods/util/constant_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../util/color_category.dart';
import '../../util/constant.dart';

class PodcastDetailScreen extends StatefulWidget {
  const PodcastDetailScreen({super.key});

  @override
  State<PodcastDetailScreen> createState() => _PodcastDetailScreenState();
}

class _PodcastDetailScreenState extends State<PodcastDetailScreen> {
  void backClick() {
    Constant.backToPrev(context);
  }

  List<ModelPopular> episodeLists = DataFile.episodeList;

  late PlayerController playerController;
  String? musicFile;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _initialiseControllers();
    _getDir();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    _preparePlayers();
  }

  void _initialiseControllers() {
    playerController = PlayerController()
      ..addListener(() {
        if (mounted) setState(() {});
      });
  }

  Future<ByteData> _loadAsset(String path) async {
    return await rootBundle.load(path);
  }

  @override
  void dispose() {
    playerController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _preparePlayers() async {
    final file1 = File('${appDirectory.path}/dummy_audio.mp3');
    await file1.writeAsBytes((await _loadAsset('assets/audios/dummy_audio.mp3'))
        .buffer
        .asUint8List());
    await playerController.preparePlayer(file1.path);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(bgDark);
    Constant.setupSize(context);
    return WillPopScope(
      onWillPop: () async {
        backClick();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgDark,
        body: SafeArea(
          child: Column(
            children: [
              getVerSpace(30.h),
              getAppBar(() {
                backClick();
              }, "Slow Burn"),
              getVerSpace(40.h),
              Expanded(
                  child: ListView(
                primary: true,
                shrinkWrap: false,
                children: [
                  buildPodcastPoster(),
                  getVerSpace(20.h),
                  buildPodcastDetail(),
                  getVerSpace(30.h),
                  Container(
                    decoration: BoxDecoration(
                        color: containerBg,
                        borderRadius: BorderRadius.circular(22.h)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.h, vertical: 20.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            getCustomFont("15:20", 14.sp, Colors.white, 1,
                                fontWeight: FontWeight.w700),
                            if (playerController.playerState !=
                                PlayerState.stopped) ...[
                              AudioFileWaveforms(
                                size: Size(250.w, 35.h),
                                playerController: playerController,
                                playerWaveStyle: PlayerWaveStyle(
                                    scaleFactor: 0.4,
                                    fixedWaveColor: "#E0E0E0".toColor(),
                                    liveWaveColor: accentColor),
                              ),
                            ],
                            getCustomFont("20:15", 14.sp, Colors.white, 1,
                                fontWeight: FontWeight.w700),
                          ],
                        ),
                        getVerSpace(30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getSvgImage("rotate_left.svg",
                                height: 42.h, width: 42.h),
                            getHorSpace(40.h),
                            GestureDetector(
                              onTap: () async {
                                playerController.playerState ==
                                        PlayerState.playing
                                    ? await playerController.pausePlayer()
                                    : await playerController.startPlayer(
                                        finishMode: FinishMode.loop);
                              },
                              child: getSvgImage(
                                  playerController.playerState ==
                                          PlayerState.playing
                                      ? "pause.svg"
                                      : "play1.svg",
                                  height: 72.h,
                                  width: 72.h),
                            ),
                            getHorSpace(40.h),
                            getSvgImage("rotate_Right.svg",
                                height: 42.h, width: 42.h),
                          ],
                        )
                      ],
                    ),
                  ),
                  getVerSpace(30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getCustomFont(
                          "Episodes(40)", 15.sp, "#F9F9F9".toColor(), 1,
                          fontWeight: FontWeight.w700),
                      GestureDetector(
                        onTap: () {
                          Constant.sendToNext(context, Routes.episodeListRoute);
                        },
                        child: getCustomFont("View All", 12.sp, accentColor, 1,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  getVerSpace(20.h),
                  buildEpisodeList(),
                  getVerSpace(40.h),
                  buildLibraryButton(context),
                  getVerSpace(40.h)
                ],
              ))
            ],
          ).paddingSymmetric(horizontal: 20.h),
        ),
      ),
    );
  }

  Widget buildLibraryButton(BuildContext context) {
    return getButton(context, accentColor, "Add To Library", Colors.black, () {
      showToast("Add to library", context);
    }, 18.sp,
        weight: FontWeight.w700,
        buttonHeight: 60.h,
        borderRadius: BorderRadius.circular(12.h));
  }

  ListView buildEpisodeList() {
    return ListView.builder(
      itemCount: 3,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        ModelPopular modelPopular = episodeLists[index];
        return Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
              color: containerBg, borderRadius: BorderRadius.circular(22.h)),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    getAssetImage(modelPopular.image,
                        height: 56.h, width: 56.h),
                    getHorSpace(12.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCustomFont(modelPopular.name, 16.sp, Colors.white, 1,
                            fontWeight: FontWeight.w700),
                        getVerSpace(6.h),
                        getCustomFont("${modelPopular.time}  •  Listening",
                            12.sp, searchHint, 1,
                            fontWeight: FontWeight.w400)
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  getSvgImage("import.svg", width: 20.h, height: 20.h),
                  getHorSpace(11.h),
                  getSvgImage("play_white.svg", height: 20.h, width: 20.h)
                ],
              )
            ],
          ),
        ).marginOnly(bottom: 20.h);
      },
    );
  }

  Column buildPodcastDetail() {
    return Column(
      children: [
        getCustomFont("Slow Burn", 22.sp, Colors.white, 1,
            fontWeight: FontWeight.w700),
        getVerSpace(2.h),
        getMultilineCustomFont(
            "Podcast produced by Slate Plus", 16.sp, hintColor,
            fontWeight: FontWeight.w400)
      ],
    );
  }

  Widget buildPodcastPoster() {
    return SizedBox(
      height: 251.h,
      width: 251.h,
      child: SfRadialGauge(axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          startAngle: 270,
          endAngle: 270,
          axisLineStyle: AxisLineStyle(
            thickness: 10.h,
            color: "#30FF9D9D".toColor(),
            thicknessUnit: GaugeSizeUnit.logicalPixel,
          ),
          annotations: [
            GaugeAnnotation(
              widget: getAssetImage("detail_image.png")
                  .paddingSymmetric(horizontal: 30.h, vertical: 30.h),
              positionFactor: 0.04,
            )
          ],
          pointers: <GaugePointer>[
            RangePointer(
                value: 60,
                width: 10.h,
                sizeUnit: GaugeSizeUnit.logicalPixel,
                cornerStyle: CornerStyle.startCurve,
                color: accentColor),
            MarkerPointer(
              value: 60,
              markerType: MarkerType.circle,
              color: "#D9D9D9".toColor(),
              borderColor: accentColor,
              borderWidth: 3.h,
              markerHeight: 16.h,
              markerWidth: 16.h,
            )
          ],
        ),
      ]),
    );
  }
}

class WaveBubble extends StatelessWidget {
  final PlayerController playerController;
  final VoidCallback onTap;
  final bool isSender;
  final bool isPlaying;

  const WaveBubble({
    super.key,
    required this.playerController,
    required this.onTap,
    required this.isPlaying,
    this.isSender = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(
          bottom: 6,
          right: isSender ? 0 : 10,
          top: 6,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSender ? const Color(0xFF276bfd) : const Color(0xFF343145),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onTap,
              icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
              color: Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width / 2, 70),
              playerController: playerController,
              density: 1.5,
              playerWaveStyle: const PlayerWaveStyle(
                scaleFactor: 0.8,
                fixedWaveColor: Colors.white30,
                liveWaveColor: Colors.white,
                waveCap: StrokeCap.butt,
              ),
            ),
            if (isSender) const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
