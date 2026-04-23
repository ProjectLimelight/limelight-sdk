//
//  Targeting.swift
//  DemoSwift
//
// © 2026 Limelight Inc. All Rights Reserved.
//

import Foundation
import LimelightSDK

/*
 Debug/test data generator for the Limelight ad targeting system.

 Creates a fully populated LimelightTargeting object with mock data covering:
     - App info: bundle ID, store URL, categories, publisher, and content metadata (title, series, genre, etc.)
     - User info: demographics, geo-location, extended IDs, and custom segments
     - Shared targeting data: reusable segments with IDs, names, values, and extension dictionaries

 Intended purely for testing/debugging — simulates a real targeting payload without a live data source.

 */
extension LimelightTargeting {
    static func demo() -> LimelightTargeting {
        let targetingData = LimelightData(
            id: "data_1",
            name: "Test Data",
            segment: [
                LimelightSegment(id: "seg_1", name: "Test Segment Name 1", value: "Test Segment Value 1", ext: ["segment1_ext_key": "segment1_ext_value"]),
                LimelightSegment(id: "seg_2", name: "Test Segment Name 2", value: "Test Segment Value 2", ext: ["segment2_ext_key": "segment2_ext_value"]),
            ],
            ext: ["data_ext_key": "data_ext_value"]
        )

        return LimelightTargeting(
            app: generateApp(targetingData),
            user: generateUser(targetingData)
        )
    }

    private static func generateApp(_ targetingData: LimelightData) -> LimelightApp {
        return LimelightApp(
            id: "app_123",
            name: "Test App",
            bundle: "com.test.app",
            domain: "testapp.com",
            storeUrl: "https://apps.apple.com/app/id123456789",
            categories: ["IAB9"],
            sectionCategories: ["IAB9-30"],
            pageCategories: ["IAB9-30"],
            version: "1.0.0",
            privacyPolicy: true,
            paid: false,
            publisher: LimelightPublisher(
                id: "pub_1",
                name: "Test Publisher",
                categories: ["IAB1"],
                domain: "publisher.com",
                ext: ["publisher_ext_key": "publisher_ext_value"]
            ),
            content: LimelightContent(
                id: "content_1",
                episode: 1,
                title: "Test Video",
                series: "Test Series",
                season: "Season 1",
                artist: "Test Artist",
                genre: "Action",
                album: "Test Album",
                isrc: "US-S1Z-14-04343",
                producer: LimelightProducer(
                    id: "prod_1",
                    name: "Test Producer",
                    categories: ["IAB1", "IAB2"],
                    domain: "producer.com",
                    ext: ["producer_ext_key": "producer_ext_value"]
                ),
                url: "https://example.com/video",
                categories: ["IAB1-1"],
                productionQuality: 1,
                context: 1,
                contentRating: "TV-MA",
                userRating: "5",
                qagMediaRating: 1,
                keywords: "movie,action",
                liveStream: false,
                sourceRelationship: 1,
                length: 3600,
                language: "en",
                embeddable: true,
                data: [targetingData],
                ext: ["content_ext_key": "content_ext_value"]
            ),
            keywords: "game,puzzle",
            ext: ["app_ext_key": "app_ext_value"]
        )
    }

    private static func generateUser(_ targetingData: LimelightData) -> LimelightUser {
        return LimelightUser(
            id: "user_123",
            buyerUserId: "buyer_123",
            yearOfBirth: 1990,
            gender: "M",
            keywords: "sports,tech",
            customData: "user_custom_data",
            geo: LimelightGeo(
                latitude: 40.7128,
                longitude: -74.0060,
                type: 1,
                accuracy: 10,
                lastFix: 1_630_000_000,
                ipService: 1,
                country: "USA",
                region: "NY",
                regionFips104: "US36",
                metro: "New York",
                city: "New York",
                zip: "10001",
                utcOffset: -240,
                ext: ["geo_ext_key": "geo_ext_value"]
            ),
            data: [targetingData],
            extendedIds: [
                LimelightExtendedId(
                    source: "test_source",
                    uids: [
                        LimelightUID(
                            id: "uid_1",
                            atype: 1,
                            ext: ["uid_ext_key": "uid_ext_value"]
                        ),
                    ],
                    ext: ["extended_id_ext_key": "extended_id_ext_value"]
                ),
            ],
            ext: ["user_ext_key": "user_ext_value"]
        )
    }
}
