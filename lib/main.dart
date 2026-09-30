import 'package:flutter/material.dart';

import 'dart:math';

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
};

String creatorMediaSlug(CreatorProfile creator) {
  return creator.username.substring(1).replaceAll(RegExp(r'[^a-z0-9]+'), '_');
}

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
                  _buildLanguageChip('English', language.contains('English')),
                  const SizedBox(width: 8),
                  _buildLanguageChip('हिन्दी', language.contains('Hindi')),
                  const SizedBox(width: 8),
                  _buildLanguageChip('मराठी', language.contains('Marathi')),
                  const SizedBox(width: 8),
                  _buildLanguageChip('தமிழ்', language.contains('Tamil')),
                  const SizedBox(width: 8),
                  _buildLanguageChip('বাংলা', language.contains('Bengali')),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: creatorProfiles.length,
              itemBuilder: (context, index) {
                return PostCard(index: index, language: language);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChip(String label, bool isSelected) {
    return Container(
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

  const PostCard({super.key, required this.index, required this.language});

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
    final creator = creatorProfiles[widget.index % creatorProfiles.length];
    final mediaSlug = creatorMediaSlug(creator);
    final mediaAsset = bundledCreatorSlugs.contains(mediaSlug)
        ? 'assets/media/$mediaSlug/$_mediaVariant.jpg'
        : 'assets/media/creator_placeholder.svg';
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
              child: Text(
                'U${widget.index}',
                style: const TextStyle(color: Colors.white),
              ),
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
              '${creator.username} • ${feedLocations[widget.index % feedLocations.length]} • $_hoursAgo hours ago • ${widget.language}',
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
              feedCaptions[widget.index % feedCaptions.length],
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[200],
            child: Image.asset(
              mediaAsset,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image, size: 64)),
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
                _buildTrendItem('#Mumbai', '24.5K posts'),
                _buildTrendItem('#Cricket', '18.2K posts'),
                _buildTrendItem('#Festival', '15.8K posts'),
                _buildTrendItem('#Food', '11.4K posts'),
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
                ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: const Text('Creator A'),
                  subtitle: const Text('1.2M followers'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Follow'),
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: const Text('Creator B'),
                  subtitle: const Text('850K followers'),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Follow'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem(String hashtag, String count) {
    return ListTile(
      leading: const Icon(Icons.local_fire_department, color: Colors.orange),
      title: Text(hashtag, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(count),
      trailing: const Icon(Icons.chevron_right),
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
class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final creator = creatorProfiles[4];
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.video_camera_front,
                    size: 80,
                    color: Colors.white24,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'LIVE VIDEO STREAM',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
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
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
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
                          fontSize: 12,
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
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Rayan: "Amazing stream! 🔥"',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  _buildComment('Rahul', 'Amazing! 🔥'),
                  _buildComment('Priya', 'Great stream'),
                  _buildComment('Ankit', '❤️❤️'),
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
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
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
          Text(
            '$user: ',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// --- Creator Profile & Dashboard ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final creator = creatorProfiles[5];
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
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        creator.name,
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
                    creator.username,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('245K', 'Followers'),
                      _buildStat('1.2M', 'Likes'),
                      _buildStat('45', 'Following'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
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
                          '1.24M',
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
                      subtitle: const Text('Your Earnings: ₹24,850'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MonetizationScreen(),
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
  const MonetizationScreen({super.key});

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
                    const Text(
                      '₹24,850',
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
