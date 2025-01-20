//
//  DocumentDataProvider.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 14.12.2024.
//

import Foundation
import UIKit

struct DocumentDataProvider {
    static let countries: [Country] = [
        
        Country(
            name: "Afghanistan",
            flag: "🇦🇫",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Albania",
            flag: "🇦🇱",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 50, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 36, photoHeight: 47, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Algeria",
            flag: "🇩🇿",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Angola",
            flag: "🇦🇴",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 30, photoHeight: 40, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Argentina",
            flag: "🇦🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 40, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 40, photoHeight: 40, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Armenia",
            flag: "🇦🇲",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Australia",
            flag: "🇦🇺",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Austria",
            flag: "🇦🇹",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Bahrain",
            flag: "🇧🇭",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 60, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 40, photoHeight: 60, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Bangladesh",
            flag: "🇧🇩",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Belarus",
            flag: "🇧🇾",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 50, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Belgium",
            flag: "🇧🇪",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Bhutan",
            flag: "🇧🇹",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 30, photoHeight: 40, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Botswana",
            flag: "🇧🇼",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 30, photoHeight: 40, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Brazil",
            flag: "🇧🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Bulgaria",
            flag: "🇧🇬",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Cambodia",
            flag: "🇰🇭",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 40, photoHeight: 40, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Canada",
            flag: "🇨🇦",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "China",
            flag: "🇨🇳",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 40, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 40, photoHeight: 40, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Colombia",
            flag: "🇨🇴",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Congo",
            flag: "🇨🇬",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Costa Rica",
            flag: "🇨🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Croatia",
            flag: "🇭🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Cuba",
            flag: "🇨🇺",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Cyprus",
            flag: "🇨🇾",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 36, photoHeight: 47, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Czech",
            flag: "🇨🇿",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 36, photoHeight: 47, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Denmark",
            flag: "🇩🇰",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Egypt",
            flag: "🇪🇬",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 40, photoHeight: 60, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Finland",
            flag: "🇫🇮",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 60, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "France",
            flag: "🇫🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 51, photoHeight: 51, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Germany",
            flag: "🇩🇪",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 51, photoHeight: 51, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Greece",
            flag: "🇬🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "India",
            flag: "🇮🇳",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Italy",
            flag: "🇮🇹",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Japan",
            flag: "🇯🇵",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 60, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]),
        Country(
            name: "Kazakhstan",
            flag: "🇰🇿",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 50, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 50, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Kenya",
            flag: "🇰🇪",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Kyrgyzstan",
            flag: "🇰🇬",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Latvia",
            flag: "🇱🇻",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Lebanon",
            flag: "🇱🇧",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Lithuania",
            flag: "🇱🇹",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Luxembourg",
            flag: "🇱🇺",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Malaysia",
            flag: "🇲🇾",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 50, photoHeight: 60, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Maldives",
            flag: "🇲🇻",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Mexico",
            flag: "🇲🇽",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Moldova",
            flag: "🇲🇩",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Mongolia",
            flag: "🇲🇳",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Netherlands",
            flag: "🇳🇱",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "New Zealand",
            flag: "🇳🇿",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Norway",
            flag: "🇳🇴",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Pakistan",
            flag: "🇵🇰",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Peru",
            flag: "🇵🇪",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Philippines",
            flag: "🇵🇭",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Poland",
            flag: "🇵🇱",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Portugal",
            flag: "🇵🇹",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Romania",
            flag: "🇷🇴",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Russia",
            flag: "🇷🇺",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Saudi Arabia",
            flag: "🇸🇦",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 60, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 51, photoHeight: 51, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Singapore",
            flag: "🇸🇬",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Slovakia",
            flag: "🇸🇰",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Slovenia",
            flag: "🇸🇮",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "South Africa",
            flag: "🇿🇦",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "South Korea",
            flag: "🇰🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Spain",
            flag: "🇪🇸",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Sri Lanka",
            flag: "🇱🇰",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Sweden",
            flag: "🇸🇪",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Switzerland",
            flag: "🇨🇭",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Turkey",
            flag: "🇹🇷",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 50, photoHeight: 60, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 50, photoHeight: 60, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "UAE",
            flag: "🇦🇪",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "Ukraine",
            flag: "🇺🇦",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "United Kingdom",
            flag: "🇬🇧",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
            ]
        ),
        Country(
            name: "USA",
            flag: "🇺🇸",
            documentTypes: [
                DocumentType(type: .passport, details: DocumentDetails(photoWidth: 51, photoHeight: 51, backgroundColor: .white, dpi: 600)),
                DocumentType(type: .visa, details: DocumentDetails(photoWidth: 51, photoHeight: 51, backgroundColor: .white, dpi: 600))
            ]
        )
    ]
}
