import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkUtils {
  ///Build a dynamic link firebase
  static Future<String> buildDynamicLink(String query) async {
    String url = "https://electrikedl.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/$query'),
      androidParameters: const AndroidParameters(
        packageName: "com.pes.electrike",
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          description: "Once upon a time in the town",
          imageUrl:
          Uri.parse("https://flutter.dev/images/flutter-logo-sharing.png"),
          title: "Breaking Code's Post"),
    );
    final ShortDynamicLink dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return dynamicUrl.shortUrl.toString();
  }
}