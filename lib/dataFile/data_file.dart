
import '../model/bottom_model.dart';
import '../model/home_slider_model.dart';
import '../model/introl_model.dart';
import '../model/popular_model.dart';
import '../model/release_model.dart';
import '../model/upcoming_model.dart';

class DataFile {
  static List<ModelIntro> introList = [
    ModelIntro("intro1.png", "Enjoy your", ' daily ', "podcast"),
    ModelIntro("intro2.png", "Listen to ", "podcast ", "with usefull value"),
    ModelIntro("intro3.png", "Listen your ", "favourite ", "podcast anywhere"),
    ModelIntro("intro4.png", "Welcome to ", "podcast", "")
  ];

  static List<ModelBottom> bottomList = [
    ModelBottom("home.svg", "home_bold.svg", "Home"),
    ModelBottom("discover.svg", "discover_bold.svg", "Discover"),
    ModelBottom("library.svg", "library_bold.svg", "My Library"),
    ModelBottom("profile1.svg", "profile_bold.svg", "Profile")
  ];

  static List<ModelHomeSlider> homeSliderList = [
    ModelHomeSlider(
        "home_slider1.png", "#F9D7B5", "", "Get Entertained With Poadcast"),
    ModelHomeSlider("home_slider2.png", "#FFC2C2", "BORED?", "Get Entertained"),
    ModelHomeSlider(
        "home_slider1.png", "#F9D7B5", "", "Get Entertained With Poadcast"),
  ];

  static List<ModelPopular> popularList = [
    ModelPopular("Discover Your True Self", "popular_image1.png", "25 min"),
    ModelPopular("You're Wrong About", "popular_image2.png", "40 min"),
    ModelPopular("How Did This Get Made?", "popular_image3.png", "30 min")
  ];

  static List<ModelPopular> trendingList = [
    ModelPopular("You're Wrong About", "tranding1.png", "30  min"),
    ModelPopular("Office Ladies", "tranding2.png", "35  min"),
    ModelPopular("Slow Burn", "tranding3.png", "20  min"),
    ModelPopular("Beautiful Stories", "tranding4.png", "15  min"),
    ModelPopular("Stuff You Should Know", "tranding5.png", "15  min"),
    ModelPopular("Sweet Bobby", "tranding6.png", "24 min")
  ];

  static List<ModelPopular> lifeStyleList = [
    ModelPopular("Radiolab Podcast Index", "lifestyle1.png", "20 min"),
    ModelPopular("On Purpose with Jay Shetty", "lifestyle2.png", "45 min"),
    ModelPopular("This American Life", "lifestyle3.png", "30 min"),
    ModelPopular("Planet Money", "lifestyle4.png", "31  min"),
    ModelPopular("Crime Junkie audiochuck", "lifestyle5.png", "36 min"),
    ModelPopular("SmartLess", "lifestyle6.png", "30 min"),
    ModelPopular("The Ben Shapiro Show", "lifestyle7.png", "20 min"),
    ModelPopular("2 Bears, 1 Cave with Tom Segura", "lifestyle8.png", "45 min"),
    ModelPopular("Park Predators", "lifestyle9.png", "30 min"),
  ];

  static List<ModelUpcoming> upcomingList = [
    ModelUpcoming("upcoming1.png", "Suspect", "6 Aug,2022"),
    ModelUpcoming("upcoming2.png", "Unraveled", "10 Aug,2022"),
    ModelUpcoming("upcoming3.png", "Life on the line", "16 Aug,2022")
  ];

  static List<String> timeList = [
    "10-20 min",
    "30-60 min",
    "<1hr-30 min",
    ">1hr-30 min"
  ];

  static List<String> subjectList = [
    "Art",
    "Education",
    "Technology",
    "Comedy"
  ];

  static List<ModelRelease> releaseList = [
    ModelRelease("release1.png", "Fashion- Not all as it seam"),
    ModelRelease("release2.png", "Feel Better, Live More"),
    ModelRelease("release1.png", "Fashion- Not all as it seam"),
    ModelRelease("release2.png", "Feel Better, Live More"),
  ];

  static List<String> recommendedList = [
    "recommended1.png",
    "recommended2.png",
    "recommended3.png",
    "recommended2.png",
    "recommended3.png",
    "recommended1.png",
  ];

  static List<String> trendingPodcastList = [
    "trending_pod1.png",
    "trending_pod2.png",
    "trending_pod1.png",
  ];

  static List<ModelRelease> libraryList = [
    ModelRelease("library1.png", "Slow Burn"),
    ModelRelease("library2.png", "Office Ladies"),
    ModelRelease("library3.png", "Sweet Bobby"),
    ModelRelease("library4.png", "Suspect")
  ];

  static List<ModelPopular> notificationList = [
    ModelPopular(
        "Sweet Bobby Add in Libraray ", "notification1.png", "15 Min ago"),
    ModelPopular(
        "Office Ladies Upcoming Podcast ", "notification2.png", "20 Min ago"),
    ModelPopular(
        "Mattis enim ut tellus elementum ", "notification3.png", "1 Day ago"),
    ModelPopular(
        "Iaculis nunc sed augue lacus ", "notification4.png", "1  Week ago"),
    ModelPopular("Nisi est sit amet facilisis magna", "notification5.png",
        "1  Week ago"),
    ModelPopular("Viverra justo nec ultrices dui sapi", "notification6.png",
        "1  Week ago")
  ];

  static List<ModelPopular> downloadList = [
    ModelPopular("Ep-1-consectetur adi", "notification5.png", "30  min"),
    ModelPopular("Ep-2-consectetur adi", "notification5.png", "30  min"),
    ModelPopular("Ep-3-consectetur adi", "notification5.png", "30  min"),
    ModelPopular("Ep-4-consectetur adi", "notification5.png", "30  min"),
    ModelPopular("Ep-5-consectetur adi", "notification5.png", "30  min"),
    ModelPopular("Ep-6-consectetur adi", "notification5.png", "30  min"),
  ];

  static List<ModelRelease> historyList = [
    ModelRelease("history1.png", "Slow Burn"),
    ModelRelease("history2.png", "Office Ladies"),
    ModelRelease("history3.png", "Sweet Bobby"),
    ModelRelease("history4.png", "Suspect")
  ];

  static List<ModelPopular> episodeList = [
    ModelPopular("Ep-1-consectetur adi", "detail_image.png", "30  min"),
    ModelPopular("Ep-2-consectetur adi", "detail_image.png", "35  min"),
    ModelPopular("Ep-2-consectetur adi", "detail_image.png", "35  min"),
    ModelPopular("Ep-2-consectetur adi", "detail_image.png", "35  min"),
    ModelPopular("Ep-2-consectetur adi", "detail_image.png", "35  min"),
    ModelPopular("Ep-2-consectetur adi", "detail_image.png", "35  min"),
    ModelPopular("Ep-2-consectetur adi", "detail_image.png", "35  min"),
  ];
}
