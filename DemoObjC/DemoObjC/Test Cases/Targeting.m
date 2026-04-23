//
//  Targeting.m
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import "Targeting.h"
@import LimelightSDK;

/*
 Debug/test data generator for the Limelight ad targeting system.

 Creates a fully populated LimelightTargeting object with mock data covering:
     - App info: bundle ID, store URL, categories, publisher, and content metadata (title, series, genre, etc.)
     - User info: demographics, geo-location, extended IDs, and custom segments
     - Shared targeting data: reusable segments with IDs, names, values, and extension dictionaries

 Intended purely for testing/debugging — simulates a real targeting payload without a live data source.

 */
@implementation LLTargeting (Demo)

+ (LLTargeting *)demo {
    LLTargeting *targeting = [[LLTargeting alloc] init];
    LLData *targetingData = [self generateTargetingData];
    targeting.app = [self generateApp:targetingData];
    targeting.user = [self generateUser:targetingData];
    return targeting;
}

+ (LLData *)generateTargetingData {
    LLSegment *seg1 = [[LLSegment alloc] init];
    seg1.id = @"seg_1";
    seg1.name = @"Test Segment Name 1";
    seg1.value = @"Test Segment Value 1";
    seg1.ext = @{@"segment1_ext_key": @"segment1_ext_value"};

    LLSegment *seg2 = [[LLSegment alloc] init];
    seg2.id = @"seg_2";
    seg2.name = @"Test Segment Name 2";
    seg2.value = @"Test Segment Value 2";
    seg2.ext = @{@"segment2_ext_key": @"segment2_ext_value"};

    LLData *data = [[LLData alloc] init];
    data.id = @"data_1";
    data.name = @"Test Data";
    data.segment = @[seg1, seg2];
    data.ext = @{@"data_ext_key": @"data_ext_value"};
    return data;
}

+ (LLApp *)generateApp:(LLData *)targetingData {
    LLPublisher *publisher = [[LLPublisher alloc] init];
    publisher.id = @"pub_1";
    publisher.name = @"Test Publisher";
    publisher.categories = @[@"IAB1"];
    publisher.domain = @"publisher.com";
    publisher.ext = @{@"publisher_ext_key": @"publisher_ext_value"};

    LLProducer *producer = [[LLProducer alloc] init];
    producer.id = @"prod_1";
    producer.name = @"Test Producer";
    producer.categories = @[@"IAB1", @"IAB2"];
    producer.domain = @"producer.com";
    producer.ext = @{@"producer_ext_key": @"producer_ext_value"};

    LLContent *content = [[LLContent alloc] init];
    content.id = @"content_1";
    content.episodeNumeric = @1;
    content.title = @"Test Video";
    content.series = @"Test Series";
    content.season = @"Season 1";
    content.artist = @"Test Artist";
    content.genre = @"Action";
    content.album = @"Test Album";
    content.isrc = @"US-S1Z-14-04343";
    content.producer = producer;
    content.url = @"https://example.com/video";
    content.categories = @[@"IAB1-1"];
    content.productionQualityNumeric = @1;
    content.contextNumeric = @1;
    content.contentRating = @"TV-MA";
    content.userRating = @"5";
    content.qagMediaRatingNumeric = @1;
    content.keywords = @"movie,action";
    content.liveStreamNumeric = @0;
    content.sourceRelationshipNumeric = @1;
    content.lengthNumeric = @3600;
    content.language = @"en";
    content.embeddableNumeric = @1;
    content.data = @[targetingData];
    content.ext = @{@"content_ext_key": @"content_ext_value"};

    LLApp *app = [[LLApp alloc] init];
    app.id = @"app_123";
    app.name = @"Test App";
    app.bundle = @"com.test.app";
    app.domain = @"testapp.com";
    app.storeUrl = @"https://apps.apple.com/app/id123456789";
    app.categories = @[@"IAB9"];
    app.sectionCategories = @[@"IAB9-30"];
    app.pageCategories = @[@"IAB9-30"];
    app.version = @"1.0.0";
    app.privacyPolicyNumeric = @1;
    app.paidNumeric = @0;
    app.publisher = publisher;
    app.content = content;
    app.keywords = @"game,puzzle";
    app.ext = @{@"app_ext_key": @"app_ext_value"};
    return app;
}

+ (LLUser *)generateUser:(LLData *)targetingData {
    LLGeo *geo = [[LLGeo alloc] init];
    geo.latitudeNumeric = @40.7128;
    geo.longitudeNumeric = @-74.0060;
    geo.typeNumeric = @1;
    geo.accuracyNumeric = @10;
    geo.lastFixNumeric = @1630000000;
    geo.ipServiceNumeric = @1;
    geo.country = @"USA";
    geo.region = @"NY";
    geo.regionFips104 = @"US36";
    geo.metro = @"New York";
    geo.city = @"New York";
    geo.zip = @"10001";
    geo.utcOffsetNumeric = @-240;
    geo.ext = @{@"geo_ext_key": @"geo_ext_value"};

    LLUID *uid = [[LLUID alloc] init];
    uid.id = @"uid_1";
    uid.atypeNumeric = @1;
    uid.ext = @{@"uid_ext_key": @"uid_ext_value"};

    LLExtendedId *extendedId = [[LLExtendedId alloc] init];
    extendedId.source = @"test_source";
    extendedId.uids = @[uid];
    extendedId.ext = @{@"extended_id_ext_key": @"extended_id_ext_value"};

    LLUser *user = [[LLUser alloc] init];
    user.id = @"user_123";
    user.buyerUserId = @"buyer_123";
    user.yearOfBirthNumeric = @1990;
    user.gender = @"M";
    user.keywords = @"sports,tech";
    user.customData = @"user_custom_data";
    user.geo = geo;
    user.data = @[targetingData];
    user.extendedIds = @[extendedId];
    user.ext = @{@"user_ext_key": @"user_ext_value"};
    return user;
}

@end
