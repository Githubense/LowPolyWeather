//
//  GlobalFallbackLocations.swift
//  LowPolyWeather
//
//  Created by Angel Adrian Pimienta Flores on 29/05/25.
//

import Foundation
import CoreLocation

/// Global fallback locations for when priority searches fail
struct GlobalFallbackLocations {
    static let shared = GlobalFallbackLocations()
    
    private init() {}
    
    /// Global fallback locations for comprehensive weather search
    var fallbackLocations: [WeatherVibe: [GlobalWeatherLocation]] = [
        .sunny: [
            // Mediterranean Extended
            GlobalWeatherLocation(name: "Málaga, Spain", coordinate: CLLocationCoordinate2D(latitude: 36.7213, longitude: -4.4214), timeZoneIdentifier: "Europe/Madrid", country: "Spain", priority: 5),
            GlobalWeatherLocation(name: "Alicante, Spain", coordinate: CLLocationCoordinate2D(latitude: 38.3452, longitude: -0.4810), timeZoneIdentifier: "Europe/Madrid", country: "Spain", priority: 5),
            GlobalWeatherLocation(name: "Florence, Italy", coordinate: CLLocationCoordinate2D(latitude: 43.7696, longitude: 11.2558), timeZoneIdentifier: "Europe/Rome", country: "Italy", priority: 5),
            GlobalWeatherLocation(name: "Palermo, Italy", coordinate: CLLocationCoordinate2D(latitude: 38.1157, longitude: 13.3613), timeZoneIdentifier: "Europe/Rome", country: "Italy", priority: 5),
            // California Extended
            GlobalWeatherLocation(name: "Santa Barbara, California", coordinate: CLLocationCoordinate2D(latitude: 34.4208, longitude: -119.6982), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Monterey, California", coordinate: CLLocationCoordinate2D(latitude: 36.6002, longitude: -121.8947), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "San Luis Obispo, California", coordinate: CLLocationCoordinate2D(latitude: 35.2828, longitude: -120.6596), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            // Southern US
            GlobalWeatherLocation(name: "Tampa, Florida", coordinate: CLLocationCoordinate2D(latitude: 27.9506, longitude: -82.4572), timeZoneIdentifier: "America/New_York", country: "United States", priority: 4),
            GlobalWeatherLocation(name: "Orlando, Florida", coordinate: CLLocationCoordinate2D(latitude: 28.5383, longitude: -81.3792), timeZoneIdentifier: "America/New_York", country: "United States", priority: 4),
            GlobalWeatherLocation(name: "Tucson, Arizona", coordinate: CLLocationCoordinate2D(latitude: 32.2217, longitude: -110.9265), timeZoneIdentifier: "America/Phoenix", country: "United States", priority: 4),
            // Australia
            GlobalWeatherLocation(name: "Perth, Australia", coordinate: CLLocationCoordinate2D(latitude: -31.9505, longitude: 115.8605), timeZoneIdentifier: "Australia/Perth", country: "Australia", priority: 3),
            GlobalWeatherLocation(name: "Adelaide, Australia", coordinate: CLLocationCoordinate2D(latitude: -34.9285, longitude: 138.6007), timeZoneIdentifier: "Australia/Adelaide", country: "Australia", priority: 3),
            // Africa
            GlobalWeatherLocation(name: "Marrakech, Morocco", coordinate: CLLocationCoordinate2D(latitude: 31.6295, longitude: -7.9811), timeZoneIdentifier: "Africa/Casablanca", country: "Morocco", priority: 3),
            GlobalWeatherLocation(
                name: "Alice Springs, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -23.6980, longitude: 133.8807),
                timeZoneIdentifier: "Australia/Darwin",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Broome, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -17.9644, longitude: 122.2304),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Kalgoorlie, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -30.7493, longitude: 121.4656),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Geraldton, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -28.7774, longitude: 114.6230),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Townsville, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -19.2590, longitude: 146.8169),
                timeZoneIdentifier: "Australia/Brisbane",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Cairns, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -16.9186, longitude: 145.7781),
                timeZoneIdentifier: "Australia/Brisbane",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "La Serena, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -29.9027, longitude: -71.2519),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Antofagasta, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -23.6509, longitude: -70.3975),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Iquique, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -20.2208, longitude: -70.1431),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Arica, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -18.4783, longitude: -70.3126),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Calama, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -22.4667, longitude: -68.9333),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Hurghada, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 27.2574, longitude: 33.8129),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Sharm el-Sheikh, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 27.9158, longitude: 34.3300),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Marsa Alam, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 25.0657, longitude: 34.8837),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Siwa Oasis, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 29.2030, longitude: 25.5197),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Ouarzazate, Morocco",
                coordinate: CLLocationCoordinate2D(latitude: 30.9335, longitude: -6.9370),
                timeZoneIdentifier: "Africa/Casablanca",
                country: "Morocco",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Erfoud, Morocco",
                coordinate: CLLocationCoordinate2D(latitude: 31.4294, longitude: -4.2294),
                timeZoneIdentifier: "Africa/Casablanca",
                country: "Morocco",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Zagora, Morocco",
                coordinate: CLLocationCoordinate2D(latitude: 30.3314, longitude: -5.8372),
                timeZoneIdentifier: "Africa/Casablanca",
                country: "Morocco",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Tozeur, Tunisia",
                coordinate: CLLocationCoordinate2D(latitude: 33.9197, longitude: 8.1335),
                timeZoneIdentifier: "Africa/Tunis",
                country: "Tunisia",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Douz, Tunisia",
                coordinate: CLLocationCoordinate2D(latitude: 33.4667, longitude: 9.0167),
                timeZoneIdentifier: "Africa/Tunis",
                country: "Tunisia",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Ghardaïa, Algeria",
                coordinate: CLLocationCoordinate2D(latitude: 32.4911, longitude: 3.6736),
                timeZoneIdentifier: "Africa/Algiers",
                country: "Algeria",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Tamanrasset, Algeria",
                coordinate: CLLocationCoordinate2D(latitude: 22.7851, longitude: 5.5228),
                timeZoneIdentifier: "Africa/Algiers",
                country: "Algeria",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Eilat Mountains, Israel",
                coordinate: CLLocationCoordinate2D(latitude: 29.5019, longitude: 34.9633),
                timeZoneIdentifier: "Asia/Jerusalem",
                country: "Israel",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Aqaba, Jordan",
                coordinate: CLLocationCoordinate2D(latitude: 29.5321, longitude: 35.0061),
                timeZoneIdentifier: "Asia/Amman",
                country: "Jordan",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Wadi Rum, Jordan",
                coordinate: CLLocationCoordinate2D(latitude: 29.5833, longitude: 35.4167),
                timeZoneIdentifier: "Asia/Amman",
                country: "Jordan",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Dahab, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 28.4942, longitude: 34.5136),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Bahariya Oasis, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 28.3489, longitude: 28.8642),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Farafra Oasis, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 27.0583, longitude: 27.9706),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Bend, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 44.0582, longitude: -121.3153),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Redding, California",
                coordinate: CLLocationCoordinate2D(latitude: 40.5865, longitude: -122.3917),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Bakersfield, California",
                coordinate: CLLocationCoordinate2D(latitude: 35.3733, longitude: -119.0187),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Fresno, California",
                coordinate: CLLocationCoordinate2D(latitude: 36.7378, longitude: -119.7871),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "El Paso, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 31.7619, longitude: -106.4850),
                timeZoneIdentifier: "America/Denver",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Albuquerque, New Mexico",
                coordinate: CLLocationCoordinate2D(latitude: 35.0844, longitude: -106.6504),
                timeZoneIdentifier: "America/Denver",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Santa Fe, New Mexico",
                coordinate: CLLocationCoordinate2D(latitude: 35.6870, longitude: -105.9378),
                timeZoneIdentifier: "America/Denver",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Flagstaff, Arizona",
                coordinate: CLLocationCoordinate2D(latitude: 35.1983, longitude: -111.6513),
                timeZoneIdentifier: "America/Phoenix",
                country: "United States",
                priority: 2
            )
        ],
        
        .rainy: [
            // Pacific Northwest Extended
            GlobalWeatherLocation(name: "Tacoma, Washington", coordinate: CLLocationCoordinate2D(latitude: 47.2529, longitude: -122.4443), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Olympia, Washington", coordinate: CLLocationCoordinate2D(latitude: 47.0379, longitude: -122.9015), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Eugene, Oregon", coordinate: CLLocationCoordinate2D(latitude: 44.0521, longitude: -123.0868), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            // British Isles Extended
            GlobalWeatherLocation(name: "Inverness, Scotland", coordinate: CLLocationCoordinate2D(latitude: 57.4778, longitude: -4.2247), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 5),
            GlobalWeatherLocation(name: "Limerick, Ireland", coordinate: CLLocationCoordinate2D(latitude: 52.6638, longitude: -8.6267), timeZoneIdentifier: "Europe/Dublin", country: "Ireland", priority: 5),
            GlobalWeatherLocation(name: "Waterford, Ireland", coordinate: CLLocationCoordinate2D(latitude: 52.2593, longitude: -7.1101), timeZoneIdentifier: "Europe/Dublin", country: "Ireland", priority: 5),
            // Northern European Coastal
            GlobalWeatherLocation(name: "Gothenburg, Sweden", coordinate: CLLocationCoordinate2D(latitude: 57.7089, longitude: 11.9746), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 4),
            GlobalWeatherLocation(name: "Trondheim, Norway", coordinate: CLLocationCoordinate2D(latitude: 63.4305, longitude: 10.3951), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 4),
            GlobalWeatherLocation(name: "Stavanger, Norway", coordinate: CLLocationCoordinate2D(latitude: 58.9700, longitude: 5.7331), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 4),
            // Eastern European
            GlobalWeatherLocation(name: "Gdansk, Poland", coordinate: CLLocationCoordinate2D(latitude: 54.3520, longitude: 18.6466), timeZoneIdentifier: "Europe/Warsaw", country: "Poland", priority: 3),
            // Asia Pacific
            GlobalWeatherLocation(name: "Kuala Lumpur, Malaysia", coordinate: CLLocationCoordinate2D(latitude: 3.1390, longitude: 101.6869), timeZoneIdentifier: "Asia/Kuala_Lumpur", country: "Malaysia", priority: 3),
            GlobalWeatherLocation(name: "Singapore", coordinate: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198), timeZoneIdentifier: "Asia/Singapore", country: "Singapore", priority: 3),
            
            // NEW FALLBACK RAINY LOCATIONS (Priority 2-4) - Remote wet regions & seasonal zones
            GlobalWeatherLocation(
                name: "Mount Waialeale, Hawaii",
                coordinate: CLLocationCoordinate2D(latitude: 22.0751, longitude: -159.4984),
                timeZoneIdentifier: "Pacific/Honolulu",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Tutendo, Colombia",
                coordinate: CLLocationCoordinate2D(latitude: 5.6964, longitude: -76.5322),
                timeZoneIdentifier: "America/Bogota",
                country: "Colombia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Lloró, Colombia",
                coordinate: CLLocationCoordinate2D(latitude: 5.5000, longitude: -76.5333),
                timeZoneIdentifier: "America/Bogota",
                country: "Colombia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Buenaventura, Colombia",
                coordinate: CLLocationCoordinate2D(latitude: 3.8801, longitude: -77.0313),
                timeZoneIdentifier: "America/Bogota",
                country: "Colombia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Quibdó, Colombia",
                coordinate: CLLocationCoordinate2D(latitude: 5.6945, longitude: -76.6581),
                timeZoneIdentifier: "America/Bogota",
                country: "Colombia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Puerto López, Colombia",
                coordinate: CLLocationCoordinate2D(latitude: 4.0833, longitude: -73.4667),
                timeZoneIdentifier: "America/Bogota",
                country: "Colombia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Debundscha, Cameroon",
                coordinate: CLLocationCoordinate2D(latitude: 4.1547, longitude: 9.0081),
                timeZoneIdentifier: "Africa/Douala",
                country: "Cameroon",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Big Bog, Hawaii",
                coordinate: CLLocationCoordinate2D(latitude: 20.8047, longitude: -156.2639),
                timeZoneIdentifier: "Pacific/Honolulu",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Crkvice, Montenegro",
                coordinate: CLLocationCoordinate2D(latitude: 42.6667, longitude: 18.6167),
                timeZoneIdentifier: "Europe/Podgorica",
                country: "Montenegro",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Milford Sound, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -44.6667, longitude: 167.9167),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Franz Josef, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -43.3869, longitude: 170.1881),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Greymouth, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -42.4500, longitude: 171.2167),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Hokitika, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -42.7167, longitude: 170.9667),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Tofino, Canada",
                coordinate: CLLocationCoordinate2D(latitude: 49.1533, longitude: -125.9069),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Prince Rupert, Canada",
                coordinate: CLLocationCoordinate2D(latitude: 54.3150, longitude: -130.3209),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Ketchikan, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 55.3422, longitude: -131.6461),
                timeZoneIdentifier: "America/Metlakatla",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Juneau, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 58.3019, longitude: -134.4197),
                timeZoneIdentifier: "America/Juneau",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Sitka, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 57.0531, longitude: -135.3300),
                timeZoneIdentifier: "America/Sitka",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Yakutat, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 59.5467, longitude: -139.7271),
                timeZoneIdentifier: "America/Yakutat",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Valdez, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 61.1308, longitude: -146.3483),
                timeZoneIdentifier: "America/Anchorage",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Seward, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 60.1042, longitude: -149.4422),
                timeZoneIdentifier: "America/Anchorage",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Haines, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 59.2358, longitude: -135.4419),
                timeZoneIdentifier: "America/Juneau",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Petersburg, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 56.8125, longitude: -132.9453),
                timeZoneIdentifier: "America/Sitka",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Wrangell, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 56.4708, longitude: -132.3769),
                timeZoneIdentifier: "America/Sitka",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Cordova, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 60.5422, longitude: -145.7581),
                timeZoneIdentifier: "America/Anchorage",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Whittier, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 60.7744, longitude: -148.6850),
                timeZoneIdentifier: "America/Anchorage",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Grytviken, South Georgia",
                coordinate: CLLocationCoordinate2D(latitude: -54.2814, longitude: -36.5089),
                timeZoneIdentifier: "Atlantic/South_Georgia",
                country: "South Georgia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Ushuaia, Argentina",
                coordinate: CLLocationCoordinate2D(latitude: -54.8019, longitude: -68.3030),
                timeZoneIdentifier: "America/Argentina/Ushuaia",
                country: "Argentina",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Punta Arenas, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -53.1638, longitude: -70.9171),
                timeZoneIdentifier: "America/Punta_Arenas",
                country: "Chile",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Puerto Williams, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -54.9333, longitude: -67.6167),
                timeZoneIdentifier: "America/Punta_Arenas",
                country: "Chile",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "King Edward Point, South Georgia",
                coordinate: CLLocationCoordinate2D(latitude: -54.2833, longitude: -36.5000),
                timeZoneIdentifier: "Atlantic/South_Georgia",
                country: "South Georgia",
                priority: 2
            )
        ],
        
        .stormy: [
            // Northern Atlantic Extended
            GlobalWeatherLocation(name: "Lerwick, Shetland", coordinate: CLLocationCoordinate2D(latitude: 60.1547, longitude: -1.1494), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 5),
            GlobalWeatherLocation(name: "Stornoway, Scotland", coordinate: CLLocationCoordinate2D(latitude: 58.2090, longitude: -6.3890), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 5),
            GlobalWeatherLocation(name: "Kirkwall, Orkney", coordinate: CLLocationCoordinate2D(latitude: 58.9814, longitude: -2.9597), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 5),
            // North Sea Coastal
            GlobalWeatherLocation(name: "Esbjerg, Denmark", coordinate: CLLocationCoordinate2D(latitude: 55.4761, longitude: 8.4560), timeZoneIdentifier: "Europe/Copenhagen", country: "Denmark", priority: 4),
            GlobalWeatherLocation(name: "Groningen, Netherlands", coordinate: CLLocationCoordinate2D(latitude: 53.2194, longitude: 6.5665), timeZoneIdentifier: "Europe/Amsterdam", country: "Netherlands", priority: 4),
            GlobalWeatherLocation(name: "Lübeck, Germany", coordinate: CLLocationCoordinate2D(latitude: 53.8655, longitude: 10.6866), timeZoneIdentifier: "Europe/Berlin", country: "Germany", priority: 4),
            // US Great Lakes & Tornado Alley
            GlobalWeatherLocation(name: "Oklahoma City, Oklahoma", coordinate: CLLocationCoordinate2D(latitude: 35.4676, longitude: -97.5164), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 4),
            GlobalWeatherLocation(name: "Kansas City, Missouri", coordinate: CLLocationCoordinate2D(latitude: 39.0997, longitude: -94.5786), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 4),
            GlobalWeatherLocation(name: "Milwaukee, Wisconsin", coordinate: CLLocationCoordinate2D(latitude: 43.0389, longitude: -87.9065), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 4),
            // Canadian Maritime
            GlobalWeatherLocation(name: "Sydney, Nova Scotia", coordinate: CLLocationCoordinate2D(latitude: 46.1368, longitude: -60.1942), timeZoneIdentifier: "America/Halifax", country: "Canada", priority: 3),
            GlobalWeatherLocation(name: "Charlottetown, PEI", coordinate: CLLocationCoordinate2D(latitude: 46.2382, longitude: -63.1311), timeZoneIdentifier: "America/Halifax", country: "Canada", priority: 3),
            GlobalWeatherLocation(
                name: "Lightning Ridge, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -29.4239, longitude: 147.9783),
                timeZoneIdentifier: "Australia/Sydney",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Katherine, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -14.4656, longitude: 132.2623),
                timeZoneIdentifier: "Australia/Darwin",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Tennant Creek, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -19.6544, longitude: 134.1894),
                timeZoneIdentifier: "Australia/Darwin",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Cairns, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -16.9186, longitude: 145.7781),
                timeZoneIdentifier: "Australia/Brisbane",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Broome, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -17.9644, longitude: 122.2304),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Port Hedland, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -20.3086, longitude: 118.6219),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Catatumbo River, Venezuela",
                coordinate: CLLocationCoordinate2D(latitude: 9.0000, longitude: -71.0000),
                timeZoneIdentifier: "America/Caracas",
                country: "Venezuela",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Zulia, Venezuela",
                coordinate: CLLocationCoordinate2D(latitude: 10.0000, longitude: -72.0000),
                timeZoneIdentifier: "America/Caracas",
                country: "Venezuela",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Bogor, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -6.5950, longitude: 106.7160),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Ciwidey, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -7.1431, longitude: 107.4694),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Tororo, Uganda",
                coordinate: CLLocationCoordinate2D(latitude: 0.6928, longitude: 34.1806),
                timeZoneIdentifier: "Africa/Kampala",
                country: "Uganda",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Gulu, Uganda",
                coordinate: CLLocationCoordinate2D(latitude: 2.7796, longitude: 32.2993),
                timeZoneIdentifier: "Africa/Kampala",
                country: "Uganda",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Gitega, Burundi",
                coordinate: CLLocationCoordinate2D(latitude: -3.4264, longitude: 29.9306),
                timeZoneIdentifier: "Africa/Bujumbura",
                country: "Burundi",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Bukavu, Democratic Republic of Congo",
                coordinate: CLLocationCoordinate2D(latitude: -2.5067, longitude: 28.8489),
                timeZoneIdentifier: "Africa/Lubumbashi",
                country: "Democratic Republic of Congo",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Goma, Democratic Republic of Congo",
                coordinate: CLLocationCoordinate2D(latitude: -1.6792, longitude: 29.2280),
                timeZoneIdentifier: "Africa/Lubumbashi",
                country: "Democratic Republic of Congo",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Kigali, Rwanda",
                coordinate: CLLocationCoordinate2D(latitude: -1.9441, longitude: 30.0619),
                timeZoneIdentifier: "Africa/Kigali",
                country: "Rwanda",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Mombasa, Kenya",
                coordinate: CLLocationCoordinate2D(latitude: -4.0435, longitude: 39.6682),
                timeZoneIdentifier: "Africa/Nairobi",
                country: "Kenya",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Nairobi, Kenya",
                coordinate: CLLocationCoordinate2D(latitude: -1.2921, longitude: 36.8219),
                timeZoneIdentifier: "Africa/Nairobi",
                country: "Kenya",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Dar es Salaam, Tanzania",
                coordinate: CLLocationCoordinate2D(latitude: -6.7924, longitude: 39.2083),
                timeZoneIdentifier: "Africa/Dar_es_Salaam",
                country: "Tanzania",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Mwanza, Tanzania",
                coordinate: CLLocationCoordinate2D(latitude: -2.5164, longitude: 32.9175),
                timeZoneIdentifier: "Africa/Dar_es_Salaam",
                country: "Tanzania",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Entebbe, Uganda",
                coordinate: CLLocationCoordinate2D(latitude: 0.0647, longitude: 32.4432),
                timeZoneIdentifier: "Africa/Kampala",
                country: "Uganda",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Kisumu, Kenya",
                coordinate: CLLocationCoordinate2D(latitude: -0.0917, longitude: 34.7680),
                timeZoneIdentifier: "Africa/Nairobi",
                country: "Kenya",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Akureyri, Iceland",
                coordinate: CLLocationCoordinate2D(latitude: 65.6835, longitude: -18.1262),
                timeZoneIdentifier: "Atlantic/Reykjavik",
                country: "Iceland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Westman Islands, Iceland",
                coordinate: CLLocationCoordinate2D(latitude: 63.4500, longitude: -20.2833),
                timeZoneIdentifier: "Atlantic/Reykjavik",
                country: "Iceland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Jan Mayen, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 70.9667, longitude: -8.6667),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Bear Island, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 74.5000, longitude: 19.0000),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "South Georgia Island",
                coordinate: CLLocationCoordinate2D(latitude: -54.2814, longitude: -36.5089),
                timeZoneIdentifier: "Atlantic/South_Georgia",
                country: "South Georgia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Macquarie Island, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -54.6200, longitude: 158.8600),
                timeZoneIdentifier: "Antarctica/Macquarie",
                country: "Australia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Kerguelen Islands, France",
                coordinate: CLLocationCoordinate2D(latitude: -49.3500, longitude: 69.2167),
                timeZoneIdentifier: "Indian/Kerguelen",
                country: "France",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Heard Island, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -53.1000, longitude: 73.5167),
                timeZoneIdentifier: "Indian/Kerguelen",
                country: "Australia",
                priority: 2
            )
        ],
        
        .snowy: [
                // Northern Hemisphere Winter Strongholds (November-March)
    GlobalWeatherLocation(name: "Fairbanks, Alaska", coordinate: CLLocationCoordinate2D(latitude: 64.8378, longitude: -147.7164), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 10),
    GlobalWeatherLocation(name: "Yellowknife, Canada", coordinate: CLLocationCoordinate2D(latitude: 62.4540, longitude: -114.3718), timeZoneIdentifier: "America/Yellowknife", country: "Canada", priority: 10),
    GlobalWeatherLocation(name: "Murmansk, Russia", coordinate: CLLocationCoordinate2D(latitude: 68.9585, longitude: 33.0827), timeZoneIdentifier: "Europe/Moscow", country: "Russia", priority: 10),
    GlobalWeatherLocation(name: "Rovaniemi, Finland", coordinate: CLLocationCoordinate2D(latitude: 66.5039, longitude: 25.7294), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 10),
    
    // Southern Hemisphere Winter Strongholds (June-September)
    GlobalWeatherLocation(name: "McMurdo Station, Antarctica", coordinate: CLLocationCoordinate2D(latitude: -77.8419, longitude: 166.6863), timeZoneIdentifier: "Antarctica/McMurdo", country: "Antarctica", priority: 10),
    GlobalWeatherLocation(name: "Ushuaia, Argentina", coordinate: CLLocationCoordinate2D(latitude: -54.8019, longitude: -68.3030), timeZoneIdentifier: "America/Argentina/Ushuaia", country: "Argentina", priority: 9),
    GlobalWeatherLocation(name: "Queenstown, New Zealand", coordinate: CLLocationCoordinate2D(latitude: -45.0312, longitude: 168.6626), timeZoneIdentifier: "Pacific/Auckland", country: "New Zealand", priority: 8),
    
    // Year-Round High Altitude Snow
    GlobalWeatherLocation(name: "Mount Washington, New Hampshire", coordinate: CLLocationCoordinate2D(latitude: 44.2706, longitude: -71.3033), timeZoneIdentifier: "America/New_York", country: "United States", priority: 9),
    GlobalWeatherLocation(name: "Denali, Alaska", coordinate: CLLocationCoordinate2D(latitude: 63.0692, longitude: -151.0070), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 9),
    GlobalWeatherLocation(name: "Mount Rainier, Washington", coordinate: CLLocationCoordinate2D(latitude: 46.8523, longitude: -121.7603), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 8),
    
    // Siberian Snow Belt
    GlobalWeatherLocation(name: "Yakutsk, Russia", coordinate: CLLocationCoordinate2D(latitude: 62.0355, longitude: 129.6755), timeZoneIdentifier: "Asia/Yakutsk", country: "Russia", priority: 9),
    GlobalWeatherLocation(name: "Norilsk, Russia", coordinate: CLLocationCoordinate2D(latitude: 69.3558, longitude: 88.1893), timeZoneIdentifier: "Asia/Krasnoyarsk", country: "Russia", priority: 9),
    
    // Canadian Arctic
    GlobalWeatherLocation(name: "Iqaluit, Nunavut", coordinate: CLLocationCoordinate2D(latitude: 63.7467, longitude: -68.5170), timeZoneIdentifier: "America/Iqaluit", country: "Canada", priority: 8),
    GlobalWeatherLocation(name: "Churchill, Manitoba", coordinate: CLLocationCoordinate2D(latitude: 58.7684, longitude: -94.1647), timeZoneIdentifier: "America/Winnipeg", country: "Canada", priority: 8),
            // Canadian Rockies Extended
            GlobalWeatherLocation(name: "Jasper, Canada", coordinate: CLLocationCoordinate2D(latitude: 52.8737, longitude: -118.0814), timeZoneIdentifier: "America/Edmonton", country: "Canada", priority: 5),
            GlobalWeatherLocation(name: "Lake Louise, Canada", coordinate: CLLocationCoordinate2D(latitude: 51.4254, longitude: -116.1773), timeZoneIdentifier: "America/Edmonton", country: "Canada", priority: 5),
            GlobalWeatherLocation(name: "Canmore, Canada", coordinate: CLLocationCoordinate2D(latitude: 51.0918, longitude: -115.3456), timeZoneIdentifier: "America/Edmonton", country: "Canada", priority: 5),
            // US Rockies Extended
            GlobalWeatherLocation(name: "Steamboat Springs, Colorado", coordinate: CLLocationCoordinate2D(latitude: 40.4850, longitude: -106.8317), timeZoneIdentifier: "America/Denver", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Telluride, Colorado", coordinate: CLLocationCoordinate2D(latitude: 37.9375, longitude: -107.8123), timeZoneIdentifier: "America/Denver", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Big Sky, Montana", coordinate: CLLocationCoordinate2D(latitude: 45.2845, longitude: -111.3015), timeZoneIdentifier: "America/Denver", country: "United States", priority: 4),
            // European Alps Extended
            GlobalWeatherLocation(name: "Interlaken, Switzerland", coordinate: CLLocationCoordinate2D(latitude: 46.6863, longitude: 7.8632), timeZoneIdentifier: "Europe/Zurich", country: "Switzerland", priority: 4),
            GlobalWeatherLocation(name: "Grindelwald, Switzerland", coordinate: CLLocationCoordinate2D(latitude: 46.6244, longitude: 8.0381), timeZoneIdentifier: "Europe/Zurich", country: "Switzerland", priority: 4),
            GlobalWeatherLocation(name: "Meribel, France", coordinate: CLLocationCoordinate2D(latitude: 45.4006, longitude: 6.5669), timeZoneIdentifier: "Europe/Paris", country: "France", priority: 4),
            // Scandinavian Arctic
            GlobalWeatherLocation(name: "Luleå, Sweden", coordinate: CLLocationCoordinate2D(latitude: 65.5848, longitude: 22.1547), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 3),
            GlobalWeatherLocation(name: "Oulu, Finland", coordinate: CLLocationCoordinate2D(latitude: 65.0121, longitude: 25.4651), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 3),
            GlobalWeatherLocation(
                name: "Ny-Ålesund, Svalbard",
                coordinate: CLLocationCoordinate2D(latitude: 78.9259, longitude: 11.9300),
                timeZoneIdentifier: "Arctic/Longyearbyen",
                country: "Norway",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Barentsburg, Svalbard",
                coordinate: CLLocationCoordinate2D(latitude: 78.0648, longitude: 14.2335),
                timeZoneIdentifier: "Arctic/Longyearbyen",
                country: "Norway",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Eureka, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 79.9833, longitude: -85.9333),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Ellesmere Island, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 81.0000, longitude: -82.0000),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Tuktoyaktuk, Northwest Territories",
                coordinate: CLLocationCoordinate2D(latitude: 69.4541, longitude: -133.0374),
                timeZoneIdentifier: "America/Inuvik",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Cambridge Bay, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 69.1181, longitude: -105.0581),
                timeZoneIdentifier: "America/Cambridge_Bay",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Rankin Inlet, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 62.8097, longitude: -92.0890),
                timeZoneIdentifier: "America/Rankin_Inlet",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Baker Lake, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 64.3190, longitude: -96.0768),
                timeZoneIdentifier: "America/Rankin_Inlet",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Pangnirtung, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 66.1451, longitude: -65.7125),
                timeZoneIdentifier: "America/Iqaluit",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Clyde River, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 70.4692, longitude: -68.5914),
                timeZoneIdentifier: "America/Iqaluit",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Arctic Bay, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 73.0333, longitude: -85.1500),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Igloolik, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 69.3747, longitude: -81.7967),
                timeZoneIdentifier: "America/Iqaluit",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Hall Beach, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 68.7761, longitude: -81.2436),
                timeZoneIdentifier: "America/Iqaluit",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Kugluktuk, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 67.8282, longitude: -115.0975),
                timeZoneIdentifier: "America/Cambridge_Bay",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Gjøa Haven, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 68.6364, longitude: -95.8794),
                timeZoneIdentifier: "America/Cambridge_Bay",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Taloyoak, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 69.5378, longitude: -93.5267),
                timeZoneIdentifier: "America/Cambridge_Bay",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Kugaaruk, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 68.5347, longitude: -89.8081),
                timeZoneIdentifier: "America/Cambridge_Bay",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Qaanaaq, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 77.4840, longitude: -69.3632),
                timeZoneIdentifier: "America/Thule",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Ittoqqortoormiit, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 70.4864, longitude: -21.9694),
                timeZoneIdentifier: "America/Scoresbysund",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Kangerlussuaq, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 67.0126, longitude: -50.6882),
                timeZoneIdentifier: "America/Nuuk",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Nuuk, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 64.1836, longitude: -51.7214),
                timeZoneIdentifier: "America/Nuuk",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Tasiilaq, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 65.6145, longitude: -37.6368),
                timeZoneIdentifier: "America/Scoresbysund",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Ilulissat, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 69.2197, longitude: -51.0986),
                timeZoneIdentifier: "America/Nuuk",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Upernavik, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 72.7864, longitude: -56.1549),
                timeZoneIdentifier: "America/Nuuk",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Vorkuta, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 67.4981, longitude: 64.0522),
                timeZoneIdentifier: "Europe/Moscow",
                country: "Russia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Salekhard, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 66.5297, longitude: 66.6014),
                timeZoneIdentifier: "Asia/Yekaterinburg",
                country: "Russia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Norilsk, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 69.3558, longitude: 88.1893),
                timeZoneIdentifier: "Asia/Krasnoyarsk",
                country: "Russia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Tiksi, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 71.6872, longitude: 128.8697),
                timeZoneIdentifier: "Asia/Yakutsk",
                country: "Russia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Chukotka, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 66.0000, longitude: 170.0000),
                timeZoneIdentifier: "Asia/Anadyr",
                country: "Russia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Pevek, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 69.7008, longitude: 170.3133),
                timeZoneIdentifier: "Asia/Anadyr",
                country: "Russia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Anadyr, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 64.7353, longitude: 177.5169),
                timeZoneIdentifier: "Asia/Anadyr",
                country: "Russia",
                priority: 2
            )
        ],
        
        .breezy: [
            // Additional Coastal Cities
            GlobalWeatherLocation(name: "Galveston, Texas", coordinate: CLLocationCoordinate2D(latitude: 29.3013, longitude: -94.7977), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Virginia Beach, Virginia", coordinate: CLLocationCoordinate2D(latitude: 36.8529, longitude: -75.9780), timeZoneIdentifier: "America/New_York", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Myrtle Beach, South Carolina", coordinate: CLLocationCoordinate2D(latitude: 33.6891, longitude: -78.8867), timeZoneIdentifier: "America/New_York", country: "United States", priority: 4),
            GlobalWeatherLocation(name: "Outer Banks, North Carolina", coordinate: CLLocationCoordinate2D(latitude: 35.5582, longitude: -75.4665), timeZoneIdentifier: "America/New_York", country: "United States", priority: 4),
            // Mediterranean Coastal
            GlobalWeatherLocation(name: "Santorini, Greece", coordinate: CLLocationCoordinate2D(latitude: 36.3932, longitude: 25.4615), timeZoneIdentifier: "Europe/Athens", country: "Greece", priority: 4),
            GlobalWeatherLocation(name: "Mykonos, Greece", coordinate: CLLocationCoordinate2D(latitude: 37.4467, longitude: 25.3289), timeZoneIdentifier: "Europe/Athens", country: "Greece", priority: 4),
            GlobalWeatherLocation(
                name: "Ushuaia, Argentina",
                coordinate: CLLocationCoordinate2D(latitude: -54.8000, longitude: -68.3000),
                timeZoneIdentifier: "America/Argentina/Ushuaia",
                country: "Argentina",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Punta Arenas, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -53.1638, longitude: -70.9171),
                timeZoneIdentifier: "America/Punta_Arenas",
                country: "Chile",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Stanley, Falkland Islands",
                coordinate: CLLocationCoordinate2D(latitude: -51.6970, longitude: -57.8570),
                timeZoneIdentifier: "Atlantic/Stanley",
                country: "Falkland Islands",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Tristan da Cunha",
                coordinate: CLLocationCoordinate2D(latitude: -37.0681, longitude: -12.2784),
                timeZoneIdentifier: "Atlantic/St_Helena",
                country: "United Kingdom",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "St. Helena Island",
                coordinate: CLLocationCoordinate2D(latitude: -15.9650, longitude: -5.7089),
                timeZoneIdentifier: "Atlantic/St_Helena",
                country: "United Kingdom",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Ascension Island",
                coordinate: CLLocationCoordinate2D(latitude: -7.9467, longitude: -14.3559),
                timeZoneIdentifier: "Atlantic/St_Helena",
                country: "United Kingdom",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Azores, Portugal",
                coordinate: CLLocationCoordinate2D(latitude: 37.7412, longitude: -25.6756),
                timeZoneIdentifier: "Atlantic/Azores",
                country: "Portugal",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Madeira, Portugal",
                coordinate: CLLocationCoordinate2D(latitude: 32.7607, longitude: -16.9595),
                timeZoneIdentifier: "Atlantic/Madeira",
                country: "Portugal",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Canary Islands, Spain",
                coordinate: CLLocationCoordinate2D(latitude: 28.2916, longitude: -16.6291),
                timeZoneIdentifier: "Atlantic/Canary",
                country: "Spain",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Cape Verde Islands",
                coordinate: CLLocationCoordinate2D(latitude: 16.5388, longitude: -24.0132),
                timeZoneIdentifier: "Atlantic/Cape_Verde",
                country: "Cape Verde",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Bermuda",
                coordinate: CLLocationCoordinate2D(latitude: 32.3078, longitude: -64.7505),
                timeZoneIdentifier: "Atlantic/Bermuda",
                country: "Bermuda",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Barbados",
                coordinate: CLLocationCoordinate2D(latitude: 13.1939, longitude: -59.5432),
                timeZoneIdentifier: "America/Barbados",
                country: "Barbados",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Martinique, France",
                coordinate: CLLocationCoordinate2D(latitude: 14.6415, longitude: -61.0242),
                timeZoneIdentifier: "America/Martinique",
                country: "France",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Guadeloupe, France",
                coordinate: CLLocationCoordinate2D(latitude: 16.2650, longitude: -61.5510),
                timeZoneIdentifier: "America/Guadeloupe",
                country: "France",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Aruba",
                coordinate: CLLocationCoordinate2D(latitude: 12.5211, longitude: -69.9683),
                timeZoneIdentifier: "America/Aruba",
                country: "Aruba",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Curaçao",
                coordinate: CLLocationCoordinate2D(latitude: 12.1696, longitude: -68.9900),
                timeZoneIdentifier: "America/Curacao",
                country: "Curaçao",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Hawaiian Trade Winds, Hawaii",
                coordinate: CLLocationCoordinate2D(latitude: 20.0000, longitude: -156.0000),
                timeZoneIdentifier: "Pacific/Honolulu",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Maui, Hawaii",
                coordinate: CLLocationCoordinate2D(latitude: 20.7984, longitude: -156.3319),
                timeZoneIdentifier: "Pacific/Honolulu",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Kauai, Hawaii",
                coordinate: CLLocationCoordinate2D(latitude: 22.0964, longitude: -159.5261),
                timeZoneIdentifier: "Pacific/Honolulu",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Big Island, Hawaii",
                coordinate: CLLocationCoordinate2D(latitude: 19.8968, longitude: -155.5828),
                timeZoneIdentifier: "Pacific/Honolulu",
                country: "United States",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Fiji Islands",
                coordinate: CLLocationCoordinate2D(latitude: -17.7134, longitude: 178.0650),
                timeZoneIdentifier: "Pacific/Fiji",
                country: "Fiji",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Vanuatu",
                coordinate: CLLocationCoordinate2D(latitude: -15.3767, longitude: 166.9592),
                timeZoneIdentifier: "Pacific/Efate",
                country: "Vanuatu",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "New Caledonia, France",
                coordinate: CLLocationCoordinate2D(latitude: -20.9043, longitude: 165.6180),
                timeZoneIdentifier: "Pacific/Noumea",
                country: "France",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Lord Howe Island, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -31.5554, longitude: 159.0804),
                timeZoneIdentifier: "Australia/Lord_Howe",
                country: "Australia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Norfolk Island, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -29.0408, longitude: 167.9547),
                timeZoneIdentifier: "Pacific/Norfolk",
                country: "Australia",
                priority: 2
            )
        ],
        
        .misty: [
            // Pacific Coast Extended
            GlobalWeatherLocation(name: "Eureka, California", coordinate: CLLocationCoordinate2D(latitude: 40.8021, longitude: -124.1637), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Crescent City, California", coordinate: CLLocationCoordinate2D(latitude: 41.7558, longitude: -124.2026), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Astoria, Oregon", coordinate: CLLocationCoordinate2D(latitude: 46.1879, longitude: -123.8313), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            // Atlantic Maritime
            GlobalWeatherLocation(name: "Bar Harbor, Maine", coordinate: CLLocationCoordinate2D(latitude: 44.3876, longitude: -68.2039), timeZoneIdentifier: "America/New_York", country: "United States", priority: 4),
            GlobalWeatherLocation(name: "Digby, Nova Scotia", coordinate: CLLocationCoordinate2D(latitude: 44.6215, longitude: -65.7580), timeZoneIdentifier: "America/Halifax", country: "Canada", priority: 4),
            GlobalWeatherLocation(
                name: "Great Dividing Range, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -37.0000, longitude: 146.0000),
                timeZoneIdentifier: "Australia/Melbourne",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Blue Mountains, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -33.7000, longitude: 150.3000),
                timeZoneIdentifier: "Australia/Sydney",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Grampians, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -37.2500, longitude: 142.5000),
                timeZoneIdentifier: "Australia/Melbourne",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Snowy Mountains, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -36.4000, longitude: 148.3000),
                timeZoneIdentifier: "Australia/Sydney",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Daintree Rainforest, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -16.1700, longitude: 145.4000),
                timeZoneIdentifier: "Australia/Brisbane",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Lamington National Park, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -28.2000, longitude: 153.1000),
                timeZoneIdentifier: "Australia/Brisbane",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Monteverde Cloud Forest, Costa Rica",
                coordinate: CLLocationCoordinate2D(latitude: 10.3000, longitude: -84.8000),
                timeZoneIdentifier: "America/Costa_Rica",
                country: "Costa Rica",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Chirripó National Park, Costa Rica",
                coordinate: CLLocationCoordinate2D(latitude: 9.4800, longitude: -83.4900),
                timeZoneIdentifier: "America/Costa_Rica",
                country: "Costa Rica",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Colombian Coffee Region",
                coordinate: CLLocationCoordinate2D(latitude: 4.8000, longitude: -75.7000),
                timeZoneIdentifier: "America/Bogota",
                country: "Colombia",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Cocora Valley, Colombia",
                coordinate: CLLocationCoordinate2D(latitude: 4.6400, longitude: -75.4700),
                timeZoneIdentifier: "America/Bogota",
                country: "Colombia",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Andean Highlands, Ecuador",
                coordinate: CLLocationCoordinate2D(latitude: -1.0000, longitude: -78.5000),
                timeZoneIdentifier: "America/Guayaquil",
                country: "Ecuador",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Mindo Cloud Forest, Ecuador",
                coordinate: CLLocationCoordinate2D(latitude: -0.0500, longitude: -78.7700),
                timeZoneIdentifier: "America/Guayaquil",
                country: "Ecuador",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Manu National Park, Peru",
                coordinate: CLLocationCoordinate2D(latitude: -12.0000, longitude: -71.5000),
                timeZoneIdentifier: "America/Lima",
                country: "Peru",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Sacred Valley, Peru",
                coordinate: CLLocationCoordinate2D(latitude: -13.3000, longitude: -72.0000),
                timeZoneIdentifier: "America/Lima",
                country: "Peru",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Atlantic Forest, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -22.0000, longitude: -42.0000),
                timeZoneIdentifier: "America/Sao_Paulo",
                country: "Brazil",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Serra da Mantiqueira, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -22.4000, longitude: -45.0000),
                timeZoneIdentifier: "America/Sao_Paulo",
                country: "Brazil",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Cameron Highlands, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 4.4700, longitude: 101.3800),
                timeZoneIdentifier: "Asia/Kuala_Lumpur",
                country: "Malaysia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Fraser's Hill, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 3.7200, longitude: 101.7400),
                timeZoneIdentifier: "Asia/Kuala_Lumpur",
                country: "Malaysia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Mount Kinabalu, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 6.0800, longitude: 116.5600),
                timeZoneIdentifier: "Asia/Kuching",
                country: "Malaysia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Bandung Highlands, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -6.9000, longitude: 107.6000),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Bromo Tengger, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -7.9400, longitude: 112.9500),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Bali Highlands, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -8.2000, longitude: 115.1900),
                timeZoneIdentifier: "Asia/Makassar",
                country: "Indonesia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Lembang, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -6.8100, longitude: 107.6200),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Tea Country, Sri Lanka",
                coordinate: CLLocationCoordinate2D(latitude: 6.9700, longitude: 80.7800),
                timeZoneIdentifier: "Asia/Colombo",
                country: "Sri Lanka",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Kandy Hills, Sri Lanka",
                coordinate: CLLocationCoordinate2D(latitude: 7.2900, longitude: 80.6300),
                timeZoneIdentifier: "Asia/Colombo",
                country: "Sri Lanka",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Horton Plains, Sri Lanka",
                coordinate: CLLocationCoordinate2D(latitude: 6.8000, longitude: 80.8000),
                timeZoneIdentifier: "Asia/Colombo",
                country: "Sri Lanka",
                priority: 2
            )
        ],
        
        .foggy: [
            // California Coast Extended
            GlobalWeatherLocation(name: "Half Moon Bay, California", coordinate: CLLocationCoordinate2D(latitude: 37.4636, longitude: -122.4286), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Pacifica, California", coordinate: CLLocationCoordinate2D(latitude: 37.6138, longitude: -122.4869), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Point Reyes, California", coordinate: CLLocationCoordinate2D(latitude: 38.0733, longitude: -122.9494), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 5),
            // Global Fog Zones
            GlobalWeatherLocation(name: "Tenerife, Spain", coordinate: CLLocationCoordinate2D(latitude: 28.2916, longitude: -16.6291), timeZoneIdentifier: "Atlantic/Canary", country: "Spain", priority: 4),
            GlobalWeatherLocation(name: "Valparaíso, Chile", coordinate: CLLocationCoordinate2D(latitude: -33.0458, longitude: -71.6197), timeZoneIdentifier: "America/Santiago", country: "Chile", priority: 3),
            GlobalWeatherLocation(
                name: "Central Valley, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.5000, longitude: -121.0000),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Modesto, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.6391, longitude: -120.9969),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Stockton, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.9577, longitude: -121.2908),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Fresno, California",
                coordinate: CLLocationCoordinate2D(latitude: 36.7378, longitude: -119.7871),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Merced, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.3022, longitude: -120.4829),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Bakersfield, California",
                coordinate: CLLocationCoordinate2D(latitude: 35.3733, longitude: -119.0187),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Portsmouth, England",
                coordinate: CLLocationCoordinate2D(latitude: 50.8198, longitude: -1.0880),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Plymouth, England",
                coordinate: CLLocationCoordinate2D(latitude: 50.3755, longitude: -4.1427),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Brighton, England",
                coordinate: CLLocationCoordinate2D(latitude: 50.8225, longitude: -0.1372),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Dover, England",
                coordinate: CLLocationCoordinate2D(latitude: 51.1279, longitude: 1.3134),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Aberdeen, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 57.1497, longitude: -2.0943),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Inverness, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 57.4778, longitude: -4.2247),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Cork, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 51.8985, longitude: -8.4756),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Galway, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 53.2707, longitude: -9.0568),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Limerick, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 52.6638, longitude: -8.6267),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Waterford, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 52.2593, longitude: -7.1101),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland", priority: 4
            ),
            GlobalWeatherLocation(
                name: "Valparaíso, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -33.0472, longitude: -71.6127),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Viña del Mar, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -33.0153, longitude: -71.5500),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Concepción, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -36.8201, longitude: -73.0444),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Puerto Montt, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -41.4693, longitude: -72.9424),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Punta Arenas, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -53.1638, longitude: -70.9171),
                timeZoneIdentifier: "America/Punta_Arenas",
                country: "Chile",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Cape Town, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -33.9249, longitude: 18.4241),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Port Elizabeth, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -33.9608, longitude: 25.6022),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "George, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -33.9608, longitude: 22.4614),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Hermanus, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -34.4187, longitude: 19.2345),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Great Barrier Island, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -36.2000, longitude: 175.4167),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Stewart Island, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -46.9000, longitude: 168.1167),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Chatham Islands, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -43.9500, longitude: -176.5667),
                timeZoneIdentifier: "Pacific/Chatham",
                country: "New Zealand",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Auckland Islands, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -50.7333, longitude: 166.1000),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 2
            )
        ],
        
        .cloudy: [
            // EXISTING FALLBACK LOCATIONS (keep all current ones)
            GlobalWeatherLocation(name: "Malmö, Sweden", coordinate: CLLocationCoordinate2D(latitude: 55.6059, longitude: 13.0007), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 5),
            GlobalWeatherLocation(name: "Aarhus, Denmark", coordinate: CLLocationCoordinate2D(latitude: 56.1629, longitude: 10.2039), timeZoneIdentifier: "Europe/Copenhagen", country: "Denmark", priority: 5),
            GlobalWeatherLocation(name: "Turku, Finland", coordinate: CLLocationCoordinate2D(latitude: 60.4518, longitude: 22.2666), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 4),
            GlobalWeatherLocation(name: "Tampere, Finland", coordinate: CLLocationCoordinate2D(latitude: 61.4991, longitude: 23.7871), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 4),
            // German Northern Plains
            GlobalWeatherLocation(name: "Bremen, Germany", coordinate: CLLocationCoordinate2D(latitude: 53.0793, longitude: 8.8017), timeZoneIdentifier: "Europe/Berlin", country: "Germany", priority: 4),
            GlobalWeatherLocation(name: "Hannover, Germany", coordinate: CLLocationCoordinate2D(latitude: 52.3759, longitude: 9.7320), timeZoneIdentifier: "Europe/Berlin", country: "Germany", priority: 4),
            
            // NEW FALLBACK CLOUDY LOCATIONS (Priority 2-4)
            GlobalWeatherLocation(
                name: "Faroe Islands, Tórshavn",
                coordinate: CLLocationCoordinate2D(latitude: 62.0079, longitude: -6.7719),
                timeZoneIdentifier: "Atlantic/Faroe",
                country: "Faroe Islands",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Ushuaia, Argentina",
                coordinate: CLLocationCoordinate2D(latitude: -54.8019, longitude: -68.3030),
                timeZoneIdentifier: "America/Argentina/Ushuaia",
                country: "Argentina",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Puerto Natales, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -51.7236, longitude: -72.5064),
                timeZoneIdentifier: "America/Punta_Arenas",
                country: "Chile",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Hobart, Tasmania",
                coordinate: CLLocationCoordinate2D(latitude: -42.8821, longitude: 147.3272),
                timeZoneIdentifier: "Australia/Hobart",
                country: "Australia",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Wellington, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -41.2865, longitude: 174.7762),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Prince Rupert, BC",
                coordinate: CLLocationCoordinate2D(latitude: 54.3150, longitude: -130.3209),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Dunedin, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -45.8788, longitude: 170.5028),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Anchorage, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 61.2181, longitude: -149.9003),
                timeZoneIdentifier: "America/Anchorage",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Juneau, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 58.3019, longitude: -134.4197),
                timeZoneIdentifier: "America/Juneau",
                country: "United States",
                priority: 4
            ),
            GlobalWeatherLocation(
                name: "Stanley, Falkland Islands",
                coordinate: CLLocationCoordinate2D(latitude: -51.6929, longitude: -57.8569),
                timeZoneIdentifier: "Atlantic/Stanley",
                country: "Falkland Islands",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Tromsø, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 69.6496, longitude: 18.9553),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Murmansk, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 68.9585, longitude: 33.0827),
                timeZoneIdentifier: "Europe/Moscow",
                country: "Russia",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Nuuk, Greenland",
                coordinate: CLLocationCoordinate2D(latitude: 64.1836, longitude: -51.7214),
                timeZoneIdentifier: "America/Nuuk",
                country: "Greenland",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Thunder Bay, Ontario",
                coordinate: CLLocationCoordinate2D(latitude: 48.3809, longitude: -89.2477),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Iqaluit, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 63.7467, longitude: -68.5170),
                timeZoneIdentifier: "America/Iqaluit",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Yellowknife, NWT",
                coordinate: CLLocationCoordinate2D(latitude: 62.4540, longitude: -114.3718),
                timeZoneIdentifier: "America/Yellowknife",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Churchill, Manitoba",
                coordinate: CLLocationCoordinate2D(latitude: 58.7684, longitude: -94.1647),
                timeZoneIdentifier: "America/Winnipeg",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Gander, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 48.9564, longitude: -54.6087),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Sitka, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 57.0531, longitude: -135.3300),
                timeZoneIdentifier: "America/Sitka",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Ketchikan, Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 55.3422, longitude: -131.6461),
                timeZoneIdentifier: "America/Metlakatla",
                country: "United States",
                priority: 3
            ),
            GlobalWeatherLocation(
                name: "Longyearbyen, Svalbard",
                coordinate: CLLocationCoordinate2D(latitude: 78.2232, longitude: 15.6267),
                timeZoneIdentifier: "Arctic/Longyearbyen",
                country: "Norway",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Alert, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 82.5018, longitude: -62.3481),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Whitehorse, Yukon",
                coordinate: CLLocationCoordinate2D(latitude: 60.7212, longitude: -135.0568),
                timeZoneIdentifier: "America/Whitehorse",
                country: "Canada",
                priority: 2
            ),
            GlobalWeatherLocation(
                name: "Inuvik, NWT",
                coordinate: CLLocationCoordinate2D(latitude: 68.3607, longitude: -133.7230),
                timeZoneIdentifier: "America/Inuvik",
                country: "Canada",
                priority: 2
            )
        ]
    ]
}