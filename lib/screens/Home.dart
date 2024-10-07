import 'package:flutter/material.dart';
import 'package:genme_app/widget/custom_app_bar.dart';

const infoData = [
  {
    "title": "We help Navigate Pharma",
    "description": "We partner with pharmaceutical companies and healthcare providers"
        "to facilitate access to the quality healthcare to people."
  },
  {
    "title": "Mission & Fission",
    "description": "Our mission is to streamline the pharmaceutical supply chain, "
        "enabling businesses to deliver life-saving medicines to those "
        "who need them most. Our vision is to free pharma companies to "
        "focus on innovation and patient care, while Of supply chain "
        "management, ensuring timely and accurate delivery of medicines "
        "to patients."
  },
  {
    "title": "Values",
    "description": "Our mission is guided by five core values: collaboration, "
        "innovation, integrity, empathy, and excellence. These values foster trust, "
        "streamline processes, ensure transparency, prioritize patients and customers, "
        "and drive continuous improvement. By living these values, we simplify the "
        "pharmaceutical supply chain and make a meaningful impact on people's lives."
  },
  {
    "title": "Our Team",
    "description": "Our team includes students/graduates from BITS Pilani and the IITs, "
        "along with industry veterans with over 20 years of combined experience and "
        "significant startup and industry projects."
  }
];

const teamData = [
  {
    "name": "Tirth Patel",
    "role": "Software Engineer",
    "imageUrl": "https://portfolio-tkpatel.vercel.app/assets/AboutMeImage-aPbed6c7.jpg",
    "bio": "I am a software engineer with a passion for building products that "
        "make a difference in people's lives."
  },
  // {
  //   "name": "John Doe",
  //   "role": "Software Engineer",
  //   "imageUrl": "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg",
  //   "bio": "I am a software engineer with a passion for building products that "
  //       "make a difference in people's lives."
  // },
  // {
  //   "name": "Jane Doe",
  //   "role": "Software Engineer",
  //   "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQEZrATmgHOi5ls0YCCQBTkocia_atSw0X-Q&s",
  //   "bio": "I am a software engineer with a passion for building products "
  //       "that make a difference in people's lives."
  // },
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: const GenmeAppBar().build(context),
        body: Column(
          children: [
            const CustomAppBar(
              isHome: true,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: infoData
                          .map((data) => InfoCard(
                        title: data['title']!,
                        description: data['description']!,
                      ))
                          .toList(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: teamData
                          .map((data) => MemberCard(
                        name: data['name']!,
                        role: data['role']!,
                        imageUrl: data['imageUrl']!,
                        bio: data['bio']!,
                      ))
                          .toList(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
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
}

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  const InfoCard({super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          width: constraints.maxWidth > 600 ? 600 : screenWidth * 0.9, // Limiting max width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 24 : 18, // Adjust font size based on width
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Text(
                description,
                style: TextStyle(
                  fontSize: constraints.maxWidth > 600 ? 18 : 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



class MemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final String bio;

  const MemberCard({
    super.key,
    required this.bio,
    required this.imageUrl,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          width: constraints.maxWidth > 600 ? 600 : screenWidth * 0.9, // Max width limit
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200, width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  width: constraints.maxWidth > 600 ? 100 : 80,
                  height: constraints.maxWidth > 600 ? 100 : 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: constraints.maxWidth > 600 ? 20 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      role,
                      style: TextStyle(
                        fontSize: constraints.maxWidth > 600 ? 16 : 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      bio,
                      style: TextStyle(
                        fontSize: constraints.maxWidth > 600 ? 14 : 12,
                        fontWeight: FontWeight.w300,
                      ),
                      softWrap: true,
                      maxLines: constraints.maxWidth > 600 ? 4 : 3, // Increase lines for wider screens
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
