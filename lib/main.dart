import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compress/flutter_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const ShareChatCloneApp());
}

class AppColors {
  static const primary = Color(0xFF6C35DE);
  static const secondary = Color(0xFFFF4F81);
  static const background = Color(0xFFF7F7FA);
  static const card = Color(0xFFFFFFFF);
  static const text = Color(0xFF222222);
  static const success = Color(0xFF22A06B);
}

class CreatorProfile {
  final String name;
  final String username;
  final bool isVerified;

  const CreatorProfile(this.name, this.username, {this.isVerified = true});
}

class UserPost {
  final String caption;
  final Uint8List? mediaBytes;
  final String? mediaName;
  final String? mediaPath;
  final bool isVideo;
  final DateTime createdAt;

  const UserPost({
    required this.caption,
    this.mediaBytes,
    this.mediaName,
    this.mediaPath,
    this.isVideo = false,
    required this.createdAt,
  });

  UserPost copyWith({String? caption}) => UserPost(
    caption: caption ?? this.caption,
    mediaBytes: mediaBytes,
    mediaName: mediaName,
    mediaPath: mediaPath,
    isVideo: isVideo,
    createdAt: createdAt,
  );
}

final ValueNotifier<List<UserPost>> createdPosts = ValueNotifier([]);

class AppNotification {
  final String title;
  final String message;
  final DateTime createdAt;

  const AppNotification({
    required this.title,
    required this.message,
    required this.createdAt,
  });
}

final ValueNotifier<List<AppNotification>> appNotifications = ValueNotifier([]);
final ValueNotifier<int> unreadNotificationCount = ValueNotifier(0);

const creatorProfiles = <CreatorProfile>[
  CreatorProfile('Taylor Swift', '@taylorswift'),
  CreatorProfile('Cristiano Ronaldo', '@cristiano'),
  CreatorProfile('Virat Kohli', '@virat.kohli'),
  CreatorProfile('Selena Gomez', '@selenagomez'),
  CreatorProfile('Aarav Mehta', '@aarav.mehta', isVerified: false),
  CreatorProfile('Priyanka Chopra Jonas', '@priyankachopra'),
  CreatorProfile('Lionel Messi', '@leomessi'),
  CreatorProfile('Zendaya', '@zendaya'),
  CreatorProfile('Dwayne Johnson', '@therock'),
  CreatorProfile('Serena Williams', '@serenawilliams'),
  CreatorProfile('Shah Rukh Khan', '@iamsrk'),
  CreatorProfile('Billie Eilish', '@billieeilish'),
  CreatorProfile('Elon Musk', '@elonmusk'),
  CreatorProfile('Ariana Grande', '@arianagrande'),
  CreatorProfile('Rihanna', '@badgalriri'),
  CreatorProfile('Jackie Chan', '@jackiechan'),
  CreatorProfile('Dua Lipa', '@dualipa'),
  CreatorProfile('Lisa', '@lalalalisa_m'),
  CreatorProfile('LeBron James', '@kingjames'),
  CreatorProfile('Simone Biles', '@simonebiles'),
  CreatorProfile('Kylian Mbappe', '@k.mbappe'),
  CreatorProfile('Deepika Padukone', '@deepikapadukone'),
  CreatorProfile('Alia Bhatt', '@aliaabhatt'),
  CreatorProfile('Emma Watson', '@emmawatson'),
  CreatorProfile('Chris Hemsworth', '@chrishemsworth'),
  CreatorProfile('Ryan Reynolds', '@vancityreynolds'),
  CreatorProfile('Kim Kardashian', '@kimkardashian'),
  CreatorProfile('Mark Zuckerberg', '@zuck'),
  CreatorProfile('Oprah Winfrey', '@oprah'),
  CreatorProfile('Bill Gates', '@thisisbillgates'),
  CreatorProfile('Gordon Ramsay', '@gordongram'),
  CreatorProfile('David Beckham', '@davidbeckham'),
  CreatorProfile('Marques Brownlee', '@mkbhd'),
  CreatorProfile('Lilly Singh', '@lilly'),
  CreatorProfile('Huda Kattan', '@hudabeauty'),
  CreatorProfile('PewDiePie', '@pewdiepie'),
  CreatorProfile('Novak Djokovic', '@djokernole'),
  CreatorProfile('Shakira', '@shakira'),
  CreatorProfile('Ed Sheeran', '@teddysphotos'),
  CreatorProfile('BTS', '@bts.bighitofficial'),
];

const feedCaptions = <String>[
  'A little reminder to make room for the things that make you feel alive.',
  'Studio days, late nights, and a melody that finally clicked.',
  'The work is quiet. The results will speak.',
  'A new personal best, and a lot more to chase.',
  'Good music, good people, no plans to rush home.',
  'Somewhere between the first take and the last laugh.',
  'Small steps every day add up to something huge.',
  'Sunrise looked different from up here today.',
  'A little behind-the-scenes from this week.',
  'Grateful for the team that makes the impossible look easy.',
  'Found a new favorite corner of the city.',
  'Practice, patience, and showing up again tomorrow.',
  'Weekend reset: fresh air and a phone on silent.',
  'Made this one for everyone who needed to hear it.',
  'The best conversations happen around the dinner table.',
  'A look back at a day I wish could last longer.',
  'New project, same curiosity. More soon.',
  'Taking the scenic route for once.',
  'One more reason to keep dreaming bigger.',
  'Thank you for being part of this journey.',
];

const localizedFeedCaptions = <String, List<String>>{
  'Hindi': [
    'Zindagi ki khoobsurat cheezon ke liye thodi jagah zaroor rakhein.',
    'Mehnat khamosh hoti hai, nateeje khud bolte hain.',
    'Har din ki chhoti koshish ek badi jeet ban sakti hai.',
    'Aaj ka din muskurane aur sapne dekhne ke naam.',
    'Is safar ka hissa banne ke liye shukriya.',
  ],
  'Marathi': [
    'आयुष्यात आनंद देणाऱ्या गोष्टींसाठी थोडी जागा ठेवा.',
    'मेहनत शांत असते, पण यश स्वतः बोलते.',
    'दररोजची छोटी पावले मोठा बदल घडवतात.',
    'आजचा दिवस हसण्यासाठी आणि स्वप्ने पाहण्यासाठी आहे.',
    'या प्रवासाचा भाग झाल्याबद्दल धन्यवाद.',
  ],
  'Tamil': [
    'உங்களை மகிழ்விக்கும் விஷயங்களுக்கு வாழ்க்கையில் இடம் கொடுங்கள்.',
    'உழைப்பு அமைதியாக இருக்கும், வெற்றி தானாக பேசும்.',
    'ஒவ்வொரு நாளும் சிறிய முயற்சிகள் பெரிய மாற்றத்தை தரும்.',
    'இன்று சிரிக்கவும் கனவு காணவும் ஒரு நல்ல நாள்.',
    'இந்த பயணத்தில் இணைந்ததற்கு நன்றி.',
  ],
  'Bengali': [
    'জীবনকে আনন্দ দেয় এমন জিনিসের জন্য একটু জায়গা রাখুন।',
    'পরিশ্রম নীরব থাকে, সাফল্য নিজেই কথা বলে।',
    'প্রতিদিনের ছোট পদক্ষেপ বড় পরিবর্তন আনে।',
    'আজ হাসার এবং স্বপ্ন দেখার জন্য একটি সুন্দর দিন।',
    'এই যাত্রার অংশ হওয়ার জন্য ধন্যবাদ।',
  ],
};

String localizedCaption(int index, String language) {
  final languageKey = language.contains('Hindi')
      ? 'Hindi'
      : language.contains('Marathi')
      ? 'Marathi'
      : language.contains('Tamil')
      ? 'Tamil'
      : language.contains('Bengali')
      ? 'Bengali'
      : null;
  final captions = languageKey == null
      ? feedCaptions
      : localizedFeedCaptions[languageKey]!;
  return captions[index % captions.length];
}

String languageKey(String language) {
  if (language.contains('Hindi')) return 'Hindi';
  if (language.contains('Marathi')) return 'Marathi';
  if (language.contains('Tamil')) return 'Tamil';
  if (language.contains('Bengali')) return 'Bengali';
  if (language.contains('Telugu')) return 'Telugu';
  if (language.contains('Gujarati')) return 'Gujarati';
  return 'English';
}

class TrendingTopic {
  final String id;
  final String postCount;
  final Set<String> languages;
  final Map<String, String> labels;

  const TrendingTopic({
    required this.id,
    required this.postCount,
    required this.languages,
    required this.labels,
  });

  String labelFor(String language) =>
      labels[languageKey(language)] ?? labels['English']!;
}

const trendingTopics = <TrendingTopic>[
  TrendingTopic(
    id: 'Mumbai',
    postCount: '24.5K posts',
    languages: {'English', 'Hindi', 'Gujarati'},
    labels: {'English': '#Mumbai', 'Hindi': '#मुंबई', 'Gujarati': '#મુંબઈ'},
  ),
  TrendingTopic(
    id: 'Cricket',
    postCount: '18.2K posts',
    languages: {
      'English',
      'Hindi',
      'Marathi',
      'Tamil',
      'Bengali',
      'Telugu',
      'Gujarati',
    },
    labels: {
      'English': '#Cricket',
      'Hindi': '#क्रिकेट',
      'Marathi': '#क्रिकेट',
      'Tamil': '#கிரிக்கெட்',
      'Bengali': '#ক্রিকেট',
      'Telugu': '#క్రికెట్',
      'Gujarati': '#ક્રિકેટ',
    },
  ),
  TrendingTopic(
    id: 'Festival',
    postCount: '15.8K posts',
    languages: {'English', 'Hindi', 'Marathi', 'Bengali', 'Telugu', 'Gujarati'},
    labels: {
      'English': '#Festival',
      'Hindi': '#त्योहार',
      'Marathi': '#सण',
      'Bengali': '#উৎসব',
      'Telugu': '#పండుగ',
      'Gujarati': '#તહેવાર',
    },
  ),
  TrendingTopic(
    id: 'Music',
    postCount: '11.4K posts',
    languages: {
      'English',
      'Hindi',
      'Marathi',
      'Tamil',
      'Bengali',
      'Telugu',
      'Gujarati',
    },
    labels: {
      'English': '#Music',
      'Hindi': '#संगीत',
      'Marathi': '#संगीत',
      'Tamil': '#இசை',
      'Bengali': '#সঙ্গীত',
      'Telugu': '#సంగీతం',
      'Gujarati': '#સંગીત',
    },
  ),
  TrendingTopic(
    id: 'Football',
    postCount: '10.6K posts',
    languages: {
      'English',
      'Hindi',
      'Marathi',
      'Tamil',
      'Bengali',
      'Telugu',
      'Gujarati',
    },
    labels: {
      'English': '#Football',
      'Hindi': '#फ़ुटबॉल',
      'Marathi': '#फुटबॉल',
      'Tamil': '#கால்பந்து',
      'Bengali': '#ফুটবল',
      'Telugu': '#ఫుట్‌బాల్',
      'Gujarati': '#ફૂટબૉલ',
    },
  ),
  TrendingTopic(
    id: 'Bollywood',
    postCount: '9.7K posts',
    languages: {'Hindi'},
    labels: {'Hindi': '#बॉलीवुड'},
  ),
  TrendingTopic(
    id: 'Ganeshotsav',
    postCount: '8.3K posts',
    languages: {'Marathi'},
    labels: {'Marathi': '#गणेशोत्सव'},
  ),
  TrendingTopic(
    id: 'TamilCinema',
    postCount: '7.9K posts',
    languages: {'Tamil'},
    labels: {'Tamil': '#தமிழ்சினிமா'},
  ),
  TrendingTopic(
    id: 'DurgaPuja',
    postCount: '7.2K posts',
    languages: {'Bengali'},
    labels: {'Bengali': '#দুর্গাপূজা'},
  ),
  TrendingTopic(
    id: 'Sankranti',
    postCount: '6.8K posts',
    languages: {'Telugu'},
    labels: {'Telugu': '#సంక్రాంతి'},
  ),
  TrendingTopic(
    id: 'Uttarayan',
    postCount: '5.9K posts',
    languages: {'Gujarati'},
    labels: {'Gujarati': '#ઉત્તરાયણ'},
  ),
];

const trendingCreatorHandlesByLanguage = <String, List<String>>{
  'English': ['@taylorswift', '@serenawilliams', '@cristiano'],
  'Hindi': ['@iamsrk', '@virat.kohli', '@priyankachopra'],
  'Marathi': ['@virat.kohli', '@iamsrk', '@aarav.mehta'],
  'Tamil': ['@deepikapadukone', '@priyankachopra', '@lilly'],
  'Bengali': ['@iamsrk', '@virat.kohli', '@aliaabhatt'],
  'Telugu': ['@virat.kohli', '@priyankachopra', '@deepikapadukone'],
  'Gujarati': ['@aarav.mehta', '@virat.kohli', '@iamsrk'],
};

const trendingCreatorFollowerCounts = <String, String>{
  '@taylorswift': '285M followers',
  '@serenawilliams': '18M followers',
  '@cristiano': '680M followers',
  '@iamsrk': '45M followers',
  '@virat.kohli': '275M followers',
  '@priyankachopra': '92M followers',
  '@aarav.mehta': '12K followers',
  '@deepikapadukone': '80M followers',
  '@lilly': '14M followers',
  '@aliaabhatt': '85M followers',
};

const feedLocations = <String>[
  'Mumbai',
  'New York',
  'Seoul',
  'London',
  'Nairobi',
  'Paris',
  'Los Angeles',
  'Tokyo',
  'Lagos',
  'Dubai',
  'Sydney',
  'Mexico City',
];
const creatorLocations = <String, String>{
  '@taylorswift': 'Nashville',
  '@cristiano': 'Funchal',
  '@virat.kohli': 'Mumbai',
  '@selenagomez': 'Los Angeles',
  '@aarav.mehta': 'Pune',
  '@priyankachopra': 'Mumbai',
  '@leomessi': 'Rosario',
  '@zendaya': 'Los Angeles',
  '@therock': 'Miami',
  '@serenawilliams': 'Palm Beach',
  '@iamsrk': 'Mumbai',
  '@billieeilish': 'Los Angeles',
  '@elonmusk': 'Austin',
  '@arianagrande': 'Boca Raton',
  '@badgalriri': 'Bridgetown',
  '@jackiechan': 'Hong Kong',
  '@dualipa': 'London',
  '@lalalalisa_m': 'Bangkok',
  '@kingjames': 'Los Angeles',
  '@simonebiles': 'Houston',
  '@k.mbappe': 'Paris',
  '@deepikapadukone': 'Bengaluru',
  '@aliaabhatt': 'Mumbai',
  '@emmawatson': 'Oxford',
  '@chrishemsworth': 'Byron Bay',
  '@vancityreynolds': 'New York',
  '@kimkardashian': 'Los Angeles',
  '@zuck': 'Palo Alto',
  '@oprah': 'Montecito',
  '@thisisbillgates': 'Seattle',
  '@gordongram': 'London',
  '@davidbeckham': 'London',
  '@mkbhd': 'New York',
  '@lilly': 'Los Angeles',
  '@hudabeauty': 'Dubai',
  '@pewdiepie': 'Brighton',
  '@djokernole': 'Belgrade',
  '@shakira': 'Miami',
  '@teddysphotos': 'Suffolk',
  '@bts.bighitofficial': 'Seoul',
};

const bundledCreatorSlugs = <String>{
  'taylorswift',
  'cristiano',
  'virat_kohli',
  'selenagomez',
  'priyankachopra',
  'leomessi',
  'zendaya',
  'therock',
  'serenawilliams',
  'iamsrk',
  'billieeilish',
  'elonmusk',
  'arianagrande',
  'badgalriri',
  'jackiechan',
  'dualipa',
  'kingjames',
  'simonebiles',
  'k_mbappe',
  'deepikapadukone',
  'aliaabhatt',
  'emmawatson',
  'chrishemsworth',
  'pewdiepie',
  'shakira',
  'teddysphotos',
  'thisisbillgates',
};

const multiVariantCreatorSlugs = <String>{
  'taylorswift',
  'cristiano',
  'virat_kohli',
  'selenagomez',
  'priyankachopra',
  'leomessi',
  'zendaya',
  'therock',
  'serenawilliams',
  'iamsrk',
};

String creatorMediaSlug(CreatorProfile creator) {
  return creator.username.substring(1).replaceAll(RegExp(r'[^a-z0-9]+'), '_');
}

String creatorAssetPath(CreatorProfile creator) {
  if (creator.username == '@aarav.mehta') {
    return 'assets/media/aarav_mehta.png';
  }
  final slug = creatorMediaSlug(creator);
  return bundledCreatorSlugs.contains(slug)
      ? 'assets/media/$slug/1.jpg'
      : 'assets/media/creator_placeholder.png';
}

const viewerAvatarPaths = <String, String>{
  'Rahul': 'assets/media/viewer_avatar_1.png',
  'Priya': 'assets/media/viewer_avatar_2.png',
  'Ankit': 'assets/media/viewer_avatar_3.png',
  'Maya': 'assets/media/viewer_avatar_4.png',
  'Arjun': 'assets/media/viewer_avatar_1.png',
  'Kavya': 'assets/media/viewer_avatar_2.png',
  'Liam': 'assets/media/viewer_avatar_3.png',
  'Aisha': 'assets/media/viewer_avatar_4.png',
  'Rayan': 'assets/media/viewer_avatar_1.png',
};

final feedCreatorProfiles = creatorProfiles
    .where((creator) => bundledCreatorSlugs.contains(creatorMediaSlug(creator)))
    .toList(growable: false);

class ShareChatCloneApp extends StatelessWidget {
  const ShareChatCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShareChat - Indic Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final Set<int> _visitedTabs = {0};
  String _selectedLanguage = 'English';
  Timer? _notificationTimer;
  final Random _notificationRandom = Random();

  static const _notificationExamples = <(String, String)>[
    ('New like', 'Someone liked one of your posts.'),
    ('New comment', 'Priya commented on a recent post.'),
    ('Creator update', 'A creator you follow shared something new.'),
    ('Community highlight', 'Your post is getting noticed by the community.'),
    ('Live now', 'A creator is live. Join the conversation.'),
  ];

  @override
  void initState() {
    super.initState();
    _scheduleRandomNotification();
  }

  void _scheduleRandomNotification() {
    final seconds = 30 + _notificationRandom.nextInt(31);
    _notificationTimer = Timer(Duration(seconds: seconds), () {
      if (!mounted) return;
      final example =
          _notificationExamples[_notificationRandom.nextInt(
            _notificationExamples.length,
          )];
      appNotifications.value = [
        AppNotification(
          title: example.$1,
          message: example.$2,
          createdAt: DateTime.now(),
        ),
        ...appNotifications.value,
      ].take(100).toList();
      unreadNotificationCount.value++;
      _scheduleRandomNotification();
    });
  }

  @override
  void dispose() {
    _notificationTimer?.cancel();
    super.dispose();
  }

  void _changeLanguage(String lang) {
    setState(() {
      _selectedLanguage = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        language: _selectedLanguage,
        onLanguageChange: _changeLanguage,
      ),
      TrendingScreen(language: _selectedLanguage),
      const CreatePostScreen(),
      LiveStreamScreen(isActive: _currentIndex == 3),
      const ProfileScreen(),
    ];

    return Scaffold(
      // Keep visited tabs mounted. Several tabs own asynchronous resources
      // (media pickers, video controllers, and dialogs); tearing those trees
      // down on every tab change can leave callbacks using deactivated context.
      body: IndexedStack(
        index: _currentIndex,
        children: List<Widget>.generate(
          screens.length,
          (index) => _visitedTabs.contains(index)
              ? screens[index]
              : const SizedBox.shrink(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _visitedTabs.add(index);
        }),
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 48, color: AppColors.secondary),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// --- Home Screen ---
class HomeScreen extends StatelessWidget {
  final String language;
  final Function(String) onLanguageChange;

  const HomeScreen({
    super.key,
    required this.language,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    final homeCreators = feedCreatorProfiles.toList()..shuffle(Random());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShareChat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: unreadNotificationCount,
            builder: (context, count, _) => IconButton(
              tooltip: 'Notifications',
              onPressed: () {
                unreadNotificationCount.value = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications),
                  if (count > 0)
                    Positioned(
                      right: -8,
                      top: -6,
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          count > 99 ? '99+' : '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => LanguageSelector(
                  currentLang: language,
                  onSelect: (l) {
                    onLanguageChange(l);
                    Navigator.pop(ctx);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 8),
                  _buildLanguageChip(
                    'English',
                    'English',
                    language.contains('English'),
                  ),
                  const SizedBox(width: 8),
                  _buildLanguageChip(
                    'हिन्दी',
                    'हिन्दी (Hindi)',
                    language.contains('Hindi'),
                  ),
                  const SizedBox(width: 8),
                  _buildLanguageChip(
                    'मराठी',
                    'मराठी (Marathi)',
                    language.contains('Marathi'),
                  ),
                  const SizedBox(width: 8),
                  _buildLanguageChip(
                    'தமிழ்',
                    'தமிழ் (Tamil)',
                    language.contains('Tamil'),
                  ),
                  const SizedBox(width: 8),
                  _buildLanguageChip(
                    'বাংলা',
                    'বাংলা (Bengali)',
                    language.contains('Bengali'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<UserPost>>(
              valueListenable: createdPosts,
              builder: (context, posts, _) {
                final contentCount = posts.length + homeCreators.length;
                final adCount = contentCount ~/ 4;
                return ListView.builder(
                  itemCount: contentCount + adCount,
                  itemBuilder: (context, index) {
                    if ((index + 1) % 5 == 0 && index ~/ 5 < adCount) {
                      return SponsoredAdCard(
                        key: ValueKey('ad-$index'),
                        adIndex: index ~/ 5,
                      );
                    }
                    final contentIndex = index - index ~/ 5;
                    if (contentIndex < posts.length) {
                      return UserPostCard(
                        key: ValueKey(posts[contentIndex]),
                        post: posts[contentIndex],
                      );
                    }
                    final creator = homeCreators[contentIndex - posts.length];
                    return PostCard(
                      key: ValueKey(creator.username),
                      index: contentIndex - posts.length,
                      creator: creator,
                      language: language,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(
    String label,
    String languageValue,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () => onLanguageChange(languageValue),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primary : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  final String currentLang;
  final Function(String) onSelect;
  LanguageSelector({
    super.key,
    required this.currentLang,
    required this.onSelect,
  });

  final List<String> languages = [
    'English',
    'हिन्दी (Hindi)',
    'मराठी (Marathi)',
    'தமிழ் (Tamil)',
    'বাংলা (Bengali)',
    'తెలుగు (Telugu)',
    'ગુજરાતી (Gujarati)',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Choose Your Language',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Text(languages[i]),
              trailing: currentLang == languages[i]
                  ? const Icon(Icons.check_circle, color: AppColors.success)
                  : const Icon(Icons.circle_outlined),
              onTap: () => onSelect(languages[i]),
            ),
          ),
        ),
      ],
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  String _timeLabel(DateTime createdAt) {
    final elapsed = DateTime.now().difference(createdAt);
    if (elapsed.inMinutes < 1) return 'Just now';
    if (elapsed.inHours < 1) return '${elapsed.inMinutes} min ago';
    if (elapsed.inDays < 1) return '${elapsed.inHours} hr ago';
    return '${elapsed.inDays} days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ValueListenableBuilder<List<AppNotification>>(
        valueListenable: appNotifications,
        builder: (context, notifications, _) {
          if (notifications.isEmpty) {
            return const Center(
              child: Text('New notifications will appear here.'),
            );
          }
          return ListView.separated(
            itemCount: notifications.length,
            separatorBuilder: (_, _) => const Divider(height: 1, indent: 72),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFEDE5FF),
                  child: Icon(
                    Icons.notifications_active,
                    color: AppColors.primary,
                  ),
                ),
                title: Text(
                  notification.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(notification.message),
                trailing: Text(
                  _timeLabel(notification.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final int index;
  final String language;
  final String? captionOverride;
  final CreatorProfile creator;

  const PostCard({
    super.key,
    required this.index,
    required this.language,
    required this.creator,
    this.captionOverride,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _hoursAgo;
  late int _likes;
  late int _comments;
  late int _mediaVariant;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    final random = Random();
    _hoursAgo = random.nextInt(23) + 1; // 1 to 23 hours ago
    _likes = random.nextInt(5000) + 100; // 100 to 5100 likes
    _comments = random.nextInt(500) + 10; // 10 to 510 comments
    _mediaVariant = random.nextInt(3) + 1;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likes--;
        _isLiked = false;
      } else {
        _likes++;
        _isLiked = true;
      }
    });
  }

  void _showCommentDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: AppColors.primary),
                  onPressed: () {
                    Navigator.pop(ctx);
                    setState(() {
                      _comments++;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Comment added!')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final creator = widget.creator;
    final mediaSlug = creatorMediaSlug(creator);
    final hasMedia = bundledCreatorSlugs.contains(mediaSlug);
    final mediaVariant = multiVariantCreatorSlugs.contains(mediaSlug)
        ? _mediaVariant
        : 1;
    final mediaAsset = hasMedia
        ? 'assets/media/$mediaSlug/$mediaVariant.jpg'
        : 'assets/media/creator_placeholder.png';
    final avatarVariant = multiVariantCreatorSlugs.contains(mediaSlug)
        ? (mediaVariant == 1 ? 2 : 1)
        : 1;
    final avatarAsset = hasMedia
        ? 'assets/media/$mediaSlug/$avatarVariant.jpg'
        : 'assets/media/creator_placeholder.png';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: AppColors.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.secondary,
              backgroundImage: AssetImage(avatarAsset),
            ),
            title: Row(
              children: [
                Flexible(
                  child: Text(
                    creator.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 4),
                if (creator.isVerified)
                  const Icon(Icons.verified, color: Colors.blue, size: 16),
              ],
            ),
            subtitle: Text(
              '${creator.username} • ${creatorLocations[creator.username] ?? 'Global'} • $_hoursAgo hours ago',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Wrap(
                    children: [
                      const ListTile(
                        title: Text(
                          'Community Guidelines',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.report),
                        title: const Text('Report Post'),
                        onTap: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Report submitted for moderation.'),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.block),
                        title: const Text('Block User'),
                        onTap: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              widget.captionOverride ??
                  localizedCaption(widget.index, widget.language),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.grey[200],
            child: Image.asset(
              mediaAsset,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 250,
                child: Center(child: Icon(Icons.broken_image, size: 64)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                InkWell(
                  onTap: _toggleLike,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? Colors.red : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$_likes',
                          style: TextStyle(
                            color: _isLiked ? Colors.red : Colors.black87,
                            fontWeight: _isLiked
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: _showCommentDialog,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text('$_comments'),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => Wrap(
                        children: [
                          const ListTile(title: Text('Share to platform')),
                          ListTile(
                            leading: const Icon(
                              Icons.message,
                              color: Colors.green,
                            ),
                            title: const Text('WhatsApp'),
                            onTap: () => Navigator.pop(ctx),
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                            title: const Text('Facebook'),
                            onTap: () => Navigator.pop(ctx),
                          ),
                          ListTile(
                            leading: const Icon(Icons.copy),
                            title: const Text('Copy Link'),
                            onTap: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.share, color: Colors.grey),
                  label: const Text(
                    'Share',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Trending Screen ---
class TrendingScreen extends StatelessWidget {
  final String language;
  const TrendingScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = languageKey(language);
    final trendingCreators = creatorProfiles
        .where(
          (creator) => trendingCreatorHandlesByLanguage[selectedLanguage]!
              .contains(creator.username),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Trending 🔥')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Top Trends',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ...trendingTopics
                    .where(
                      (topic) => topic.languages.contains(selectedLanguage),
                    )
                    .map((topic) => _buildTrendItem(context, topic)),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Trending Creators',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                ...trendingCreators.map(
                  (creator) => _buildCreatorTile(
                    context,
                    creator,
                    trendingCreatorFollowerCounts[creator.username] ??
                        'Trending creator',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem(BuildContext context, TrendingTopic topic) {
    return ListTile(
      leading: const Icon(Icons.local_fire_department, color: Colors.orange),
      title: Text(
        topic.labelFor(language),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(topic.postCount),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                TrendPostsScreen(topic: topic.id, language: language),
          ),
        );
      },
    );
  }

  Widget _buildCreatorTile(
    BuildContext context,
    CreatorProfile creator,
    String followers,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.secondary,
        backgroundImage: AssetImage(creatorAssetPath(creator)),
      ),
      title: Row(
        children: [
          Flexible(child: Text(creator.name, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 4),
          if (creator.isVerified)
            const Icon(Icons.verified, color: Colors.blue, size: 16),
        ],
      ),
      subtitle: Text('${creator.username} • $followers'),
      trailing: ElevatedButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Following ${creator.username}')),
        ),
        child: const Text('Follow'),
      ),
    );
  }
}

class TrendPostsScreen extends StatelessWidget {
  final String topic;
  final String language;

  const TrendPostsScreen({
    super.key,
    required this.topic,
    required this.language,
  });

  static const topicCreators = <String, Set<String>>{
    'Mumbai': {
      '@virat.kohli',
      '@priyankachopra',
      '@iamsrk',
      '@deepikapadukone',
      '@aliaabhatt',
    },
    // Keep sports topics scoped to athletes who play that sport.
    'Cricket': {'@virat.kohli'},
    'Football': {'@cristiano', '@leomessi', '@k.mbappe'},
    'Festival': {
      '@taylorswift',
      '@shakira',
      '@badgalriri',
      '@dualipa',
      '@iamsrk',
    },
    'Music': {
      '@taylorswift',
      '@billieeilish',
      '@arianagrande',
      '@teddysphotos',
      '@shakira',
      '@dualipa',
      '@badgalriri',
      '@bts.bighitofficial',
    },
    'Bollywood': {
      '@iamsrk',
      '@priyankachopra',
      '@aliaabhatt',
      '@deepikapadukone',
    },
    'Ganeshotsav': {
      '@virat.kohli',
      '@iamsrk',
      '@priyankachopra',
      '@aliaabhatt',
    },
    'TamilCinema': {'@priyankachopra', '@deepikapadukone', '@aliaabhatt'},
    'DurgaPuja': {'@iamsrk', '@priyankachopra', '@virat.kohli'},
    'Sankranti': {'@virat.kohli', '@priyankachopra', '@deepikapadukone'},
    'Uttarayan': {'@virat.kohli', '@aarav.mehta', '@priyankachopra'},
  };

  @override
  Widget build(BuildContext context) {
    final usernames = topicCreators[topic] ?? const <String>{};
    final indices = feedCreatorProfiles
        .asMap()
        .entries
        .where((entry) => usernames.contains(entry.value.username))
        .map((entry) => entry.key)
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text('#$topic posts')),
      body: indices.isEmpty
          ? Center(child: Text('No $topic posts yet.'))
          : ListView.builder(
              itemCount: indices.length,
              itemBuilder: (context, index) {
                final creator = feedCreatorProfiles[indices[index]];
                return PostCard(
                  index: indices[index],
                  language: language,
                  creator: creator,
                  captionOverride:
                      '${creator.name} shared a ${topic.toLowerCase()} update with the community.',
                );
              },
            ),
    );
  }
}

class SponsoredAdCard extends StatelessWidget {
  final int adIndex;

  const SponsoredAdCard({super.key, required this.adIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      color: const Color(0xFFF2F7FF),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.campaign, color: AppColors.primary),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Sponsored',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Ad options',
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ad preferences opened.')),
                  ),
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/media/Ad${(adIndex % 4) + 1}.png',
                width: double.infinity,
                height: 260,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPostCard extends StatelessWidget {
  final UserPost post;

  const UserPostCard({super.key, required this.post});

  Future<void> _handleOption(BuildContext context, String option) async {
    if (option == 'edit') {
      final controller = TextEditingController(text: post.caption);
      final caption = await showDialog<String>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Edit post'),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 4,
            decoration: const InputDecoration(hintText: 'Write a caption'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, controller.text),
              child: const Text('Save'),
            ),
          ],
        ),
      );
      controller.dispose();
      if (caption == null || !context.mounted) return;
      if (caption.trim().isEmpty && post.mediaBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('A text-only post needs a caption.')),
        );
        return;
      }
      final posts = List<UserPost>.of(createdPosts.value);
      final index = posts.indexWhere((item) => identical(item, post));
      if (index < 0) return;
      posts[index] = post.copyWith(caption: caption.trim());
      createdPosts.value = posts;
      return;
    }

    if (option == 'delete') {
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Delete post?'),
          content: const Text('This post will be removed from your feed.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
      if (shouldDelete == true && context.mounted) {
        createdPosts.value = createdPosts.value
            .where((item) => !identical(item, post))
            .toList();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Post deleted.')));
      }
      return;
    }

    if (option == 'copy') {
      await Clipboard.setData(ClipboardData(text: post.caption));
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Post text copied.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasMedia = post.mediaBytes != null;
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Text('RR', style: TextStyle(color: Colors.white)),
            ),
            title: const Text(
              'Rayan Rawat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('@Rayan_141 • ${_postTimeLabel(post.createdAt)}'),
            trailing: PopupMenuButton<String>(
              tooltip: 'Post options',
              onSelected: (option) => _handleOption(context, option),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Edit caption'),
                  ),
                ),
                PopupMenuItem(
                  value: 'copy',
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.copy),
                    title: Text('Copy post text'),
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    dense: true,
                    leading: Icon(Icons.delete_outline, color: Colors.red),
                    title: Text('Delete post'),
                  ),
                ),
              ],
            ),
          ),
          if (post.caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(post.caption),
            ),
          if (hasMedia && post.isVideo && post.mediaPath != null)
            VideoPostPlayer(path: post.mediaPath!, name: post.mediaName)
          else if (hasMedia)
            Image.memory(
              post.mediaBytes!,
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox(
                height: 120,
                child: Center(child: Icon(Icons.broken_image_outlined)),
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class VideoPostPlayer extends StatefulWidget {
  final String path;
  final String? name;

  const VideoPostPlayer({super.key, required this.path, this.name});

  @override
  State<VideoPostPlayer> createState() => _VideoPostPlayerState();
}

class _VideoPostPlayerState extends State<VideoPostPlayer> {
  late final VideoPlayerController _controller;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    final uri = kIsWeb ? Uri.parse(widget.path) : Uri.file(widget.path);
    _controller = VideoPlayerController.networkUrl(uri)
      ..initialize()
          .then((_) {
            if (mounted) {
              _controller.setVolume(0);
              setState(() {});
            }
          })
          .catchError((_) {
            if (mounted) setState(() => _failed = true);
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return Container(
        height: 220,
        color: Colors.black87,
        alignment: Alignment.center,
        child: Text(
          widget.name ?? 'Video could not be previewed',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
    if (!_controller.value.isInitialized) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return GestureDetector(
      onTap: () => setState(() {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      }),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),
            if (!_controller.value.isPlaying)
              const Icon(Icons.play_circle_fill, color: Colors.white, size: 58),
          ],
        ),
      ),
    );
  }
}

String _postTimeLabel(DateTime createdAt) {
  final elapsed = DateTime.now().difference(createdAt);
  if (elapsed.inMinutes < 1) return 'Just now';
  if (elapsed.inHours < 1) return '${elapsed.inMinutes}m ago';
  if (elapsed.inDays < 1) return '${elapsed.inHours}h ago';
  return '${elapsed.inDays}d ago';
}

// --- Create Post & Video Upload ---
enum VideoUploadQuality {
  dataSaver,
  balanced,
  high,
  original;

  String get title => switch (this) {
    VideoUploadQuality.dataSaver => 'Data saver',
    VideoUploadQuality.balanced => 'Balanced',
    VideoUploadQuality.high => 'High quality',
    VideoUploadQuality.original => 'Original',
  };

  String get description => switch (this) {
    VideoUploadQuality.dataSaver =>
      'Smallest file · up to 480p · best for slow networks',
    VideoUploadQuality.balanced => 'Clear video · up to 720p',
    VideoUploadQuality.high => 'Sharper video · up to 1080p · larger file',
    VideoUploadQuality.original => 'Keep the original file without compression',
  };

  VideoCompressConfig? get config => switch (this) {
    VideoUploadQuality.dataSaver => const VideoCompressConfig(
      qualityPercent: 35,
      codec: VideoCodec.h264,
      maxWidth: 480,
      maxHeight: 854,
      container: VideoContainer.mp4,
    ),
    VideoUploadQuality.balanced => const VideoCompressConfig(
      qualityPercent: 60,
      codec: VideoCodec.h264,
      maxWidth: 720,
      maxHeight: 1280,
      container: VideoContainer.mp4,
    ),
    VideoUploadQuality.high => const VideoCompressConfig(
      qualityPercent: 80,
      codec: VideoCodec.h264,
      maxWidth: 1080,
      maxHeight: 1920,
      container: VideoContainer.mp4,
    ),
    VideoUploadQuality.original => null,
  };
}

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  Uint8List? _selectedMediaBytes;
  String? _selectedMediaName;
  String? _selectedMediaPath;
  String? _selectedCompressionSummary;
  bool _selectedMediaIsVideo = false;
  bool _isPickingMedia = false;
  double? _compressionProgress;
  String? _mediaProgressLabel;
  String _selectedLanguage = 'English';

  Future<VideoUploadQuality?> _chooseVideoQuality() {
    return showModalBottomSheet<VideoUploadQuality>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                'Video upload quality',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Choose how much data to use before selecting a video.',
              ),
            ),
            for (final quality in VideoUploadQuality.values)
              ListTile(
                leading: Icon(switch (quality) {
                  VideoUploadQuality.dataSaver => Icons.network_check,
                  VideoUploadQuality.balanced => Icons.hd_outlined,
                  VideoUploadQuality.high => Icons.high_quality_outlined,
                  VideoUploadQuality.original => Icons.video_file_outlined,
                }, color: AppColors.primary),
                title: Text(quality.title),
                subtitle: Text(quality.description),
                onTap: () => Navigator.pop(context, quality),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _pickMedia({required bool video}) async {
    if (_isPickingMedia) return;
    final quality = video ? await _chooseVideoQuality() : null;
    if (video && quality == null) return;
    if (!mounted) return;
    setState(() => _isPickingMedia = true);
    try {
      setState(() {
        _mediaProgressLabel = video ? 'Choose a video…' : 'Choose an image…';
        _compressionProgress = null;
      });
      final picker = ImagePicker();
      final media = video
          ? await picker.pickVideo(source: ImageSource.gallery)
          : await picker.pickImage(
              source: ImageSource.gallery,
              imageQuality: 90,
            );
      if (media == null || !mounted) return;

      XFile preparedMedia = media;
      String? compressionSummary;
      if (video && quality != VideoUploadQuality.original) {
        setState(() {
          _mediaProgressLabel =
              'Compressing for ${quality!.title.toLowerCase()}…';
          _compressionProgress = 0;
        });
        final result = await FlutterCompress.instance.compress(
          media.path,
          quality!.config!,
          onProgress: (progress) {
            if (mounted) {
              setState(() => _compressionProgress = progress.progress);
            }
          },
        );
        preparedMedia = XFile(result.outputPath);
        compressionSummary = result.skipped
            ? 'Already optimized · original kept'
            : '${quality.title} · ${result.savedPercent.toStringAsFixed(0)}% smaller';
      } else if (video) {
        compressionSummary = 'Original quality · not compressed';
      }

      if (!mounted) return;
      setState(() => _mediaProgressLabel = 'Preparing media…');
      final bytes = await preparedMedia.readAsBytes();
      if (!mounted) return;
      setState(() {
        _selectedMediaBytes = bytes;
        _selectedMediaName = media.name;
        _selectedMediaPath = preparedMedia.path;
        _selectedCompressionSummary = compressionSummary;
        _selectedMediaIsVideo = video;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not select media: $error')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPickingMedia = false;
          _compressionProgress = null;
          _mediaProgressLabel = null;
        });
      }
    }
  }

  void _publishPost() {
    final caption = _controller.text.trim();
    if (caption.isEmpty && _selectedMediaBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add text or choose an image or video.')),
      );
      return;
    }
    createdPosts.value = [
      UserPost(
        caption: caption,
        mediaBytes: _selectedMediaBytes,
        mediaName: _selectedMediaName,
        mediaPath: _selectedMediaPath,
        isVideo: _selectedMediaIsVideo,
        createdAt: DateTime.now(),
      ),
      ...createdPosts.value,
    ];
    _controller.clear();
    setState(() {
      _selectedMediaBytes = null;
      _selectedMediaName = null;
      _selectedMediaPath = null;
      _selectedCompressionSummary = null;
      _selectedMediaIsVideo = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post published to your feed and profile.')),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String transliterate(String text) {
    Map<String, String> words = {
      "namaste": "नमस्ते",
      "hello": "हेलो",
      "aaj": "आज",
      "mausam": "मौसम",
      "accha": "अच्छा",
      "hai": "है",
    };
    String result = text.toLowerCase();
    for (var word in words.keys) {
      result = result.replaceAll(word, words[word]!);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What\'s happening?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Type here (e.g. aaj mausam accha hai)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedLanguage,
                  items: const [
                    DropdownMenuItem(value: 'English', child: Text('English')),
                    DropdownMenuItem(value: 'Hindi', child: Text('हिन्दी')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLanguage = value);
                    }
                  },
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _controller.text = transliterate(_controller.text);
                    });
                  },
                  icon: const Icon(Icons.translate),
                  label: const Text('Transliterate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(height: 40),
            const Text(
              'Add photos or videos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isPickingMedia
                        ? null
                        : () => _pickMedia(video: false),
                    icon: const Icon(Icons.image),
                    label: Text(
                      _selectedMediaBytes != null && !_selectedMediaIsVideo
                          ? 'Change image'
                          : 'Image',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isPickingMedia
                        ? null
                        : () => _pickMedia(video: true),
                    icon: const Icon(Icons.video_call),
                    label: Text(
                      _selectedMediaBytes != null && _selectedMediaIsVideo
                          ? 'Change video'
                          : 'Video',
                    ),
                  ),
                ),
              ],
            ),
            if (_isPickingMedia) ...[
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: _compressionProgress),
                  if (_mediaProgressLabel != null) ...[
                    const SizedBox(height: 6),
                    Text(_mediaProgressLabel!),
                  ],
                ],
              ),
            ],
            if (_selectedMediaBytes != null) ...[
              const SizedBox(height: 16),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  if (_selectedMediaIsVideo)
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.play_circle_fill,
                        size: 64,
                        color: Colors.white,
                      ),
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        _selectedMediaBytes!,
                        width: double.infinity,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                  IconButton.filled(
                    onPressed: () => setState(() {
                      _selectedMediaBytes = null;
                      _selectedMediaName = null;
                      _selectedMediaPath = null;
                      _selectedCompressionSummary = null;
                      _selectedMediaIsVideo = false;
                    }),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              if (_selectedMediaName != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    _selectedMediaName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (_selectedCompressionSummary != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _selectedCompressionSummary!,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isPickingMedia ? null : _publishPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'POST',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Live Stream Screen ---
class LiveStreamScreen extends StatefulWidget {
  final bool isActive;

  const LiveStreamScreen({super.key, this.isActive = true});

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  late final VideoPlayerController _videoController;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, String>> _liveComments = [
    {'user': 'Rahul', 'text': 'Amazing! 🔥'},
    {'user': 'Priya', 'text': 'Great stream'},
    {'user': 'Ankit', 'text': '❤️❤️'},
  ];
  Timer? _chatTimer;
  int _nextComment = 0;
  String _chatLanguage = 'English';

  final autoComments = const [
    ('Maya', 'This live is incredible!'),
    ('Arjun', 'बहुत बढ़िया stream 🔥'),
    ('Kavya', 'Super performance!'),
    ('Liam', 'Greetings from London!'),
    ('Aisha', 'வணக்கம் everyone!'),
  ];

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('assets/media/aarav_live_video.mp4')
          ..setLooping(true)
          ..initialize().then((_) {
            if (mounted) {
              _videoController.setVolume(0);
              setState(() {});
              if (widget.isActive) _videoController.play();
            }
          });
    _chatTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      final comment = autoComments[_nextComment % autoComments.length];
      _nextComment++;
      if (mounted) {
        setState(
          () => _liveComments.add({'user': comment.$1, 'text': comment.$2}),
        );
      }
    });
  }

  @override
  void didUpdateWidget(covariant LiveStreamScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive == widget.isActive ||
        !_videoController.value.isInitialized) {
      return;
    }
    if (widget.isActive) {
      _videoController.play();
    } else {
      _videoController.pause();
    }
  }

  @override
  void dispose() {
    _chatTimer?.cancel();
    _commentController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _sendComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _liveComments.add({'user': 'Rayan', 'text': text});
      _commentController.clear();
    });
  }

  void _chooseChatLanguage() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ListView(
        shrinkWrap: true,
        children:
            [
                  'English',
                  'हिन्दी',
                  'मराठी',
                  'தமிழ்',
                  'বাংলা',
                  'తెలుగు',
                  'ગુજરાતી',
                ]
                .map(
                  (language) => ListTile(
                    leading: const Icon(Icons.translate),
                    title: Text(language),
                    trailing: language == _chatLanguage
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () {
                      setState(() => _chatLanguage = language);
                      Navigator.pop(ctx);
                    },
                  ),
                )
                .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final creator = creatorProfiles.firstWhere(
      (profile) => profile.username == '@aarav.mehta',
    );
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/media/aarav_live_background.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  if (_videoController.value.isInitialized)
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController.value.size.width,
                        height: _videoController.value.size.height,
                        child: VideoPlayer(_videoController),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: const AssetImage(
                      'assets/media/aarav_mehta.png',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            creator.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (creator.isVerified)
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 14,
                            ),
                        ],
                      ),
                      Text(
                        creator.username,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '⭐ SUPER CHAT - ₹100',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Rayan: "Amazing stream! 🔥"',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  ..._liveComments
                      .take(8)
                      .map(
                        (comment) =>
                            _buildComment(comment['user']!, comment['text']!),
                      ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: const TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendComment(),
                      decoration: InputDecoration(
                        hintText: 'Write in $_chatLanguage...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white24,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.translate, color: Colors.white70),
                    onPressed: _chooseChatLanguage,
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendComment,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.monetization_on,
                      color: Colors.amber,
                      size: 30,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) => Wrap(
                          children: [
                            const ListTile(
                              title: Text(
                                'Highlight your message',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: const Text('₹10'),
                              title: const Text('Super Chat'),
                              onTap: () => Navigator.pop(ctx),
                            ),
                            ListTile(
                              leading: const Text('₹50'),
                              title: const Text('Super Chat'),
                              onTap: () => Navigator.pop(ctx),
                            ),
                            ListTile(
                              leading: const Text('₹100'),
                              title: const Text('Super Chat (Highlighted)'),
                              onTap: () => Navigator.pop(ctx),
                            ),
                            ListTile(
                              leading: const Text('₹500'),
                              title: const Text('Super Chat (Premium)'),
                              onTap: () => Navigator.pop(ctx),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.card_giftcard,
                      color: AppColors.secondary,
                      size: 30,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) => Wrap(
                          children: [
                            const ListTile(
                              title: Text(
                                'Send Virtual Gift',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: const Text('❤️'),
                              title: const Text('Heart'),
                              trailing: const Text('₹10'),
                              onTap: () => Navigator.pop(ctx),
                            ),
                            ListTile(
                              leading: const Text('🌹'),
                              title: const Text('Rose'),
                              trailing: const Text('₹20'),
                              onTap: () => Navigator.pop(ctx),
                            ),
                            ListTile(
                              leading: const Text('👑'),
                              title: const Text('Crown'),
                              trailing: const Text('₹500'),
                              onTap: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('You sent a Crown!'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComment(String user, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(
              viewerAvatarPaths[user] ?? viewerAvatarPaths.values.first,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$user: ',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Creator Profile & Dashboard ---
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _firstName = 'Rayan';
  String _lastName = 'Rawat';
  String _username = 'Rayan_141';
  String _bio = 'Creator, developer, and storyteller';
  late final int _totalViews;
  late final int _earnings;
  late final int _profileLikes;

  @override
  void initState() {
    super.initState();
    final random = Random();
    _totalViews = random.nextInt(9001) + 1000;
    _earnings = random.nextInt(9001) + 1000;
    _profileLikes = random.nextInt(1001) + 1000;
  }

  Future<void> _editProfile() async {
    final firstNameController = TextEditingController(text: _firstName);
    final lastNameController = TextEditingController(text: _lastName);
    final usernameController = TextEditingController(text: _username);
    final bioController = TextEditingController(text: _bio);

    final updatedProfile = await showDialog<List<String>>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last name'),
              ),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: bioController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (firstNameController.text.trim().isEmpty ||
                  usernameController.text.trim().isEmpty) {
                return;
              }
              Navigator.pop(dialogContext, [
                firstNameController.text.trim(),
                lastNameController.text.trim(),
                usernameController.text.trim().replaceFirst('@', ''),
                bioController.text.trim(),
              ]);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      firstNameController.dispose();
      lastNameController.dispose();
      usernameController.dispose();
      bioController.dispose();
    });

    if (updatedProfile != null && mounted) {
      setState(() {
        _firstName = updatedProfile[0];
        _lastName = updatedProfile[1];
        _username = updatedProfile[2];
        _bio = updatedProfile[3];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '$_firstName $_lastName'.trim();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.primary,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      'RR',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Colors.blue, size: 18),
                    ],
                  ),
                  Text(
                    '@$_username',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 6),
                  Text(_bio, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('285', 'Followers'),
                      _buildStat('$_profileLikes', 'Likes'),
                      _buildStat('190', 'Following'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _editProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                    ),
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<List<UserPost>>(
              valueListenable: createdPosts,
              builder: (context, posts, _) => Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Your posts (${posts.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (posts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('Your published posts will appear here.'),
                      )
                    else
                      ...posts.map(
                        (post) => UserPostCard(key: ValueKey(post), post: post),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Content Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: const Text('🎵 Music'),
                        backgroundColor: AppColors.background,
                      ),
                      Chip(
                        label: const Text('😂 Comedy'),
                        backgroundColor: AppColors.background,
                      ),
                      Chip(
                        label: const Text('🎥 Vlogs'),
                        backgroundColor: AppColors.background,
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  const Text(
                    'Creator Dashboard',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDashboardCard(
                          'Total Views',
                          '$_totalViews',
                          Icons.visibility,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildDashboardCard(
                          'Engagement',
                          '8.4%',
                          Icons.trending_up,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(
                        Icons.monetization_on,
                        color: AppColors.success,
                        size: 40,
                      ),
                      title: const Text(
                        'Monetization',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Your Earnings: ₹$_earnings'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MonetizationScreen(earnings: _earnings),
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 40,
                      ),
                      title: const Text(
                        'Get Verified Badge',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('₹999 / year'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Subscribed to Verification Badge!'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildDashboardCard(String title, String val, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              val,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawalRequest {
  final int amount;
  final String bankName;
  final String accountLastFour;
  final DateTime createdAt;

  const WithdrawalRequest({
    required this.amount,
    required this.bankName,
    required this.accountLastFour,
    required this.createdAt,
  });
}

// --- Monetization Screen ---
class MonetizationScreen extends StatefulWidget {
  final int earnings;

  const MonetizationScreen({super.key, required this.earnings});

  @override
  State<MonetizationScreen> createState() => _MonetizationScreenState();
}

class _MonetizationScreenState extends State<MonetizationScreen> {
  late int _balance;
  final List<WithdrawalRequest> _withdrawalRequests = [];

  @override
  void initState() {
    super.initState();
    _balance = widget.earnings;
  }

  Future<void> _requestWithdrawal() async {
    final formKey = GlobalKey<FormState>();
    final holderController = TextEditingController();
    final bankController = TextEditingController();
    final accountController = TextEditingController();
    final ifscController = TextEditingController();
    final phoneController = TextEditingController();
    final amountController = TextEditingController(text: '$_balance');

    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Bank details for withdrawal'),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: holderController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Account holder name',
                    ),
                    validator: (value) =>
                        value == null || value.trim().length < 2
                        ? 'Enter the account holder name'
                        : null,
                  ),
                  TextFormField(
                    controller: bankController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(labelText: 'Bank name'),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter the bank name'
                        : null,
                  ),
                  TextFormField(
                    controller: accountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Account number',
                    ),
                    validator: (value) =>
                        value == null ||
                            !RegExp(r'^\d{9,18}$').hasMatch(value.trim())
                        ? 'Enter a 9–18 digit account number'
                        : null,
                  ),
                  TextFormField(
                    controller: ifscController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'IFSC code'),
                    validator: (value) =>
                        value == null ||
                            !RegExp(
                              r'^[A-Z]{4}0[A-Z0-9]{6}$',
                            ).hasMatch(value.trim().toUpperCase())
                        ? 'Enter a valid IFSC code'
                        : null,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Registered phone number',
                    ),
                    validator: (value) =>
                        value == null ||
                            !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value.trim())
                        ? 'Enter a valid phone number'
                        : null,
                  ),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Withdrawal amount (max ₹$_balance)',
                    ),
                    validator: (value) {
                      final amount = int.tryParse(value?.trim() ?? '');
                      if (amount == null || amount <= 0) {
                        return 'Enter an amount greater than zero';
                      }
                      if (amount > _balance) {
                        return 'Amount exceeds your balance';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: const Text('Submit request'),
          ),
        ],
      ),
    );

    final amount = int.tryParse(amountController.text.trim()) ?? 0;
    final bankName = bankController.text.trim();
    final accountNumber = accountController.text.trim();
    holderController.dispose();
    bankController.dispose();
    accountController.dispose();
    ifscController.dispose();
    phoneController.dispose();
    amountController.dispose();

    if (submitted != true || !mounted) return;
    setState(() {
      _balance -= amount;
      _withdrawalRequests.insert(
        0,
        WithdrawalRequest(
          amount: amount,
          bankName: bankName,
          accountLastFour: accountNumber.substring(accountNumber.length - 4),
          createdAt: DateTime.now(),
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Withdrawal request submitted. Transfer is simulated in this demo.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monetization 💰')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: AppColors.primary,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text(
                      'Your Earnings',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹$_balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'This Month',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _balance > 0 ? _requestWithdrawal : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Withdraw Funds'),
                    ),
                  ],
                ),
              ),
            ),
            if (_withdrawalRequests.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Withdrawal requests',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              ..._withdrawalRequests.map(
                (request) => Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_balance,
                      color: AppColors.primary,
                    ),
                    title: Text('₹${request.amount} • Pending'),
                    subtitle: Text(
                      '${request.bankName} • Account ending ${request.accountLastFour}',
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            const Text(
              'Revenue Breakdown',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            const ListTile(
              leading: Icon(Icons.pie_chart, color: AppColors.primary),
              title: Text('Creator Revenue Share'),
              trailing: Text(
                '70%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.success,
                ),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.business, color: Colors.grey),
              title: Text('Platform Share'),
              trailing: Text(
                '30%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Earnings Sources',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.monetization_on, color: Colors.amber),
              title: const Text('Super Chat'),
              trailing: const Text(
                '₹18,200',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.card_giftcard,
                color: AppColors.secondary,
              ),
              title: const Text('Virtual Gifts'),
              trailing: const Text(
                '₹6,650',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
