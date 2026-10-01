import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

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

const creatorProfiles = <CreatorProfile>[
  CreatorProfile('Taylor Swift', '@taylorswift'),
  CreatorProfile('Cristiano Ronaldo', '@cristiano'),
  CreatorProfile('Virat Kohli', '@virat.kohli'),
  CreatorProfile('Selena Gomez', '@selenagomez'),
  CreatorProfile('MrBeast', '@mrbeast'),
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
  'Good food, good people, no plans to rush home.',
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
  '@mrbeast': 'Greenville',
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
  'mrbeast',
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
  'mrbeast',
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
  String _selectedLanguage = 'हिन्दी (Hindi)';

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
      const LiveStreamScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
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
            child: ListView.builder(
              itemCount: homeCreators.length,
              itemBuilder: (context, index) {
                return PostCard(
                  index: index,
                  creator: homeCreators[index],
                  language: language,
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
              '${creator.username} • ${creatorLocations[creator.username] ?? 'Global'} • $_hoursAgo hours ago • ${widget.language}',
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
    return Scaffold(
      appBar: AppBar(title: const Text('Trending 🔥')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Top Trends in $language',
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
                _buildTrendItem(context, '#Mumbai', '24.5K posts'),
                _buildTrendItem(context, '#Cricket', '18.2K posts'),
                _buildTrendItem(context, '#Festival', '15.8K posts'),
                _buildTrendItem(context, '#Food', '11.4K posts'),
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
                _buildCreatorTile(
                  context,
                  creatorProfiles[0],
                  '285M followers',
                ),
                _buildCreatorTile(
                  context,
                  creatorProfiles[1],
                  '680M followers',
                ),
                _buildCreatorTile(
                  context,
                  creatorProfiles[2],
                  '275M followers',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem(BuildContext context, String hashtag, String count) {
    return ListTile(
      leading: const Icon(Icons.local_fire_department, color: Colors.orange),
      title: Text(hashtag, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(count),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrendPostsScreen(
              topic: hashtag.substring(1),
              language: language,
            ),
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
    'Cricket': {
      '@cristiano',
      '@virat.kohli',
      '@leomessi',
      '@serenawilliams',
      '@kingjames',
      '@simonebiles',
      '@k.mbappe',
    },
    'Festival': {
      '@taylorswift',
      '@shakira',
      '@badgalriri',
      '@dualipa',
      '@iamsrk',
    },
    'Food': {
      '@mrbeast',
      '@therock',
      '@selenagomez',
      '@arianagrande',
      '@gordongram',
    },
  };

  @override
  Widget build(BuildContext context) {
    final usernames = topicCreators[topic] ?? topicCreators.values.first;
    final indices = feedCreatorProfiles
        .asMap()
        .entries
        .where((entry) => usernames.contains(entry.value.username))
        .map((entry) => entry.key)
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text('#$topic posts')),
      body: ListView.builder(
        itemCount: indices.length,
        itemBuilder: (context, index) {
          final creator =
              feedCreatorProfiles[indices[index] % feedCreatorProfiles.length];
          return PostCard(
            index: indices[index] % feedCreatorProfiles.length,
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

// --- Create Post & Video Upload ---
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLowDataMode = false;

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
                  value: 'Hindi',
                  items: const [
                    DropdownMenuItem(value: 'Hindi', child: Text('हिन्दी')),
                    DropdownMenuItem(value: 'English', child: Text('English')),
                  ],
                  onChanged: (v) {},
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
              'Media Upload (Tier-2/3 Optimized)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.image),
                    label: const Text('Image'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) => StatefulBuilder(
                          builder:
                              (
                                BuildContext context,
                                StateSetter setModalState,
                              ) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const ListTile(
                                      title: Text(
                                        'Video Compression',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.high_quality),
                                      title: const Text('High (40 MB)'),
                                      onTap: () => Navigator.pop(ctx),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.sd),
                                      title: const Text('Medium (20 MB)'),
                                      onTap: () => Navigator.pop(ctx),
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.data_saver_on,
                                        color: AppColors.success,
                                      ),
                                      title: const Text('Low (10 MB)'),
                                      onTap: () => Navigator.pop(ctx),
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Low Data Mode'),
                                      subtitle: const Text(
                                        'Automatically compress for slow networks',
                                      ),
                                      value: _isLowDataMode,
                                      onChanged: (val) {
                                        setModalState(() {
                                          _isLowDataMode = val!;
                                        });
                                        setState(() {
                                          _isLowDataMode = val!;
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                        ),
                      );
                    },
                    icon: const Icon(Icons.video_call),
                    label: const Text('Video'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post published!')),
                  );
                  _controller.clear();
                },
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
  const LiveStreamScreen({super.key});

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
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            ),
          )
          ..setLooping(true)
          ..initialize().then((_) {
            if (mounted) {
              setState(() {});
              _videoController.play();
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
    final creator = creatorProfiles[4];
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: _videoController.value.isInitialized
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController.value.size.width,
                        height: _videoController.value.size.height,
                        child: VideoPlayer(_videoController),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondary,
                      ),
                    ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(creatorAssetPath(creator)),
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

// --- Monetization Screen ---
class MonetizationScreen extends StatelessWidget {
  final int earnings;

  const MonetizationScreen({super.key, required this.earnings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monetization 💰')),
      body: Padding(
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
                      '₹$earnings',
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
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Withdrawal Request Sent!'),
                          ),
                        );
                      },
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
