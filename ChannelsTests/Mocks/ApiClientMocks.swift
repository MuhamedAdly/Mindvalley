//
//  ApiClientMocks.swift
//  ChannelsTests
//
//  Created by Mohamed Adly on 5/22/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
@testable import Channels

class ApiClientMocks {
    static var episodesJSONMock: [String: Any] {
        return ["data": [
            "media": [
                [
                    "type": "course",
                    "title": "Conscious Parenting",
                    "coverAsset": [
                        "url": "https://assets.mindvalley.com/api/v1/assets/5bdbdd0e-3bd3-432b-b8cb-3d3556c58c94.jpg?transform=w_1080"
                    ],
                    "channel": [
                        "title": "Little Humans"
                    ]
                ]
            ]
            ]
        ]
    }
    static var channelsCoursesJSONMock: [String: Any] {
        return [
            "data": [
                "channels": [
                    [
                        "title": "Mindvalley Mentoring",
                        "series": [],
                        "mediaCount": 98,
                        "latestMedia": [
                            [
                                "type": "course",
                                "title": "How Journaling Helped Create a $500M Company",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/a90653b8-8475-41a9-925a-3a1bf0e7cd5f.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "The Truth About Water",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/c3b924a1-7e33-4175-9647-95d011b986ba.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "Vishen's Optimized Morning Routine",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/953f74d2-52a9-4769-9369-04849e786bb4.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "What To Eat For A Genius Brain",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/bff42af7-5a7e-46fb-bcda-7eb7dc3fb342.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "How to invest like a Buffett",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/8eb890f6-4d88-48cc-9af5-a207dd90913e.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "How to Nurture Greatness In Your Kids",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/eaa7aad0-3036-43fd-b446-3128b78aaef1.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "A Framework For Spiritual Activism",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/841c723f-2a56-47d3-a96b-3cc6747ffc56.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "How to Live to Be 180",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/1265e870-86e4-45ed-bea3-c09cd6ee8932.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "How to Optimize Your Nutrition",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/9de12ffd-d357-4306-9c58-dbe764849f3d.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "From Suffering to Manifesting",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/abd4378b-7714-488c-a234-29c7e27b0a73.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "How to Live in Awe",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/fc2992cf-bf78-470a-afb8-de444e42c25f.jpg"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "The Cure for Loneliness",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/830808f0-e488-49a5-8ac6-960c7b38aa2f.jpg"
                                ]
                            ]
                        ],
                        "id": "11",
                        "iconAsset": [
                            "thumbnailUrl": "https://edgecastcdn.net/80EC13/public/overmind2/asset/11914f01-ba4a-4d68-9c33-efb34c43ed23/channel-icon-mentoring_thumbnail.png"
                        ],
                        "coverAsset": [
                            "url": "https://assets.mindvalley.com/api/v1/assets/8fd5837a-539c-4367-b1af-8579a3e3d461.jpg?transform=w_1080"
                        ]
                    ]
                ]]]
    }
    static var channelsSeriesJSONMock: [String: Any] {
        return [
            "data": [
                "channels": [
                    [
                        "title": "Lifebook Accountability System",
                        "series": [
                            [
                                "title": "Getting Started with the Lifebook Accountability System",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/4d960fc3-836a-4536-8ba7-062911943477.jpg?transform=w_1080"
                                ]
                            ]
                        ],
                        "mediaCount": 6,
                        "latestMedia": [
                            [
                                "type": "course",
                                "title": "Welcome to the Lifebook Accountability System!",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/03acac58-af60-484a-8b8f-696b171eeb26.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "The Accountability Year",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/fa053bfb-fdc4-4ab1-a93e-0709d9171f54.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "Your Life Vision, Refined",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/d78cbc7f-4d43-414a-b83a-62f8137cfbb5.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "Your Goal Tracking Approach",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/09ca9c67-acfe-4d0d-ac31-1588053a0596.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "Completing Your Accountability Profile",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/4eb672a9-540d-4143-82b3-ef01dc9d37ec.jpg?transform=w_1080"
                                ]
                            ],
                            [
                                "type": "course",
                                "title": "The Lifeline Exercise",
                                "coverAsset": [
                                    "url": "https://assets.mindvalley.com/api/v1/assets/7f55fbbd-bf6b-4810-b605-2177b9fc6db4.jpg?transform=w_1080"
                                ]
                            ]
                        ],
                        "iconAsset": [
                            "thumbnailUrl": "https://edgecastcdn.net/80EC13/public/overmind2/asset/ae4b0861-b54c-4e56-b573-107466e0e384/channel-icon-lifebook_thumbnail.png"
                        ],
                        "coverAsset": [
                            "url": "https://assets.mindvalley.com/api/v1/assets/46a6f2aa-e645-4473-92cb-0c6add8bd039.jpg?transform=w_1080"
                        ]
                    ]
                ]]]
    }
    static var categoriesMock: [String: Any] {
        return [
            "data": [
                "categories": [
                    [
                        "name": "Career"
                    ],
                    [
                        "name": "Character"
                    ],
                    [
                        "name": "Emotional"
                    ],
                    [
                        "name": "Financial"
                    ],
                    [
                        "name": "Health & Fitness"
                    ],
                    [
                        "name": "Intellectual"
                    ],
                    [
                        "name": "Life Vision"
                    ],
                    [
                        "name": "Love Relationship"
                    ],
                    [
                        "name": "Parenting"
                    ],
                    [
                        "name": "Quality of Life"
                    ],
                    [
                        "name": "Social Life"
                    ],
                    [
                        "name": "Spiritual"
                    ]
                ]
            ]
        ]
    }
}
