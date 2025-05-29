import Foundation
import CoreLocation

/// Enhanced global weather database with priority-based location search
class EnhancedGlobalWeatherDatabase {
    static let shared = EnhancedGlobalWeatherDatabase()
    
    private init() {}
    
    private var fallbackLocations: [WeatherVibe: [GlobalWeatherLocation]] = [:]

    /// Primary locations with high confidence for specific weather vibes
    private var priorityLocations: [WeatherVibe: [GlobalWeatherLocation]] = [
        .sunny: [
            GlobalWeatherLocation(name: "San Diego, California", coordinate: CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Los Angeles, California", coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Phoenix, Arizona", coordinate: CLLocationCoordinate2D(latitude: 33.4484, longitude: -112.0740), timeZoneIdentifier: "America/Phoenix", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "Nice, France", coordinate: CLLocationCoordinate2D(latitude: 43.7102, longitude: 7.2620), timeZoneIdentifier: "Europe/Paris", country: "France", priority: 7),
            GlobalWeatherLocation(name: "Barcelona, Spain", coordinate: CLLocationCoordinate2D(latitude: 41.3851, longitude: 2.1734), timeZoneIdentifier: "Europe/Madrid", country: "Spain", priority: 6),
            GlobalWeatherLocation(name: "Athens, Greece", coordinate: CLLocationCoordinate2D(latitude: 37.9838, longitude: 23.7275), timeZoneIdentifier: "Europe/Athens", country: "Greece", priority: 5),            
            GlobalWeatherLocation(name: "Las Vegas, Nevada", coordinate: CLLocationCoordinate2D(latitude: 36.1699, longitude: -115.1398), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Miami, Florida", coordinate: CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918), timeZoneIdentifier: "America/New_York", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "Honolulu, Hawaii", coordinate: CLLocationCoordinate2D(latitude: 21.3099, longitude: -157.8581), timeZoneIdentifier: "Pacific/Honolulu", country: "United States", priority: 5),
            GlobalWeatherLocation(
                name: "Yuma, Arizona",
                coordinate: CLLocationCoordinate2D(latitude: 32.6927, longitude: -114.6277),
                timeZoneIdentifier: "America/Phoenix",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Aswan, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 24.0889, longitude: 32.8998),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Luxor, Egypt",
                coordinate: CLLocationCoordinate2D(latitude: 25.6872, longitude: 32.6396),
                timeZoneIdentifier: "Africa/Cairo",
                country: "Egypt",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Atacama Desert, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -24.5000, longitude: -69.2500),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Las Vegas, Nevada",
                coordinate: CLLocationCoordinate2D(latitude: 36.1699, longitude: -115.1398),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Tucson, Arizona",
                coordinate: CLLocationCoordinate2D(latitude: 32.2226, longitude: -110.9747),
                timeZoneIdentifier: "America/Phoenix",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Palm Springs, California",
                coordinate: CLLocationCoordinate2D(latitude: 33.8303, longitude: -116.5453),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Seville, Spain",
                coordinate: CLLocationCoordinate2D(latitude: 37.3886, longitude: -5.9823),
                timeZoneIdentifier: "Europe/Madrid",
                country: "Spain",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Valencia, Spain",
                coordinate: CLLocationCoordinate2D(latitude: 39.4699, longitude: -0.3763),
                timeZoneIdentifier: "Europe/Madrid",
                country: "Spain",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Palermo, Italy",
                coordinate: CLLocationCoordinate2D(latitude: 38.1157, longitude: 13.3615),
                timeZoneIdentifier: "Europe/Rome",
                country: "Italy",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Catania, Italy",
                coordinate: CLLocationCoordinate2D(latitude: 37.5079, longitude: 15.0830),
                timeZoneIdentifier: "Europe/Rome",
                country: "Italy",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Heraklion, Greece",
                coordinate: CLLocationCoordinate2D(latitude: 35.3387, longitude: 25.1442),
                timeZoneIdentifier: "Europe/Athens",
                country: "Greece",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Rhodes, Greece",
                coordinate: CLLocationCoordinate2D(latitude: 36.4341, longitude: 28.2176),
                timeZoneIdentifier: "Europe/Athens",
                country: "Greece",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Larnaca, Cyprus",
                coordinate: CLLocationCoordinate2D(latitude: 34.9167, longitude: 33.6333),
                timeZoneIdentifier: "Asia/Nicosia",
                country: "Cyprus",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Tel Aviv, Israel",
                coordinate: CLLocationCoordinate2D(latitude: 32.0853, longitude: 34.7818),
                timeZoneIdentifier: "Asia/Jerusalem",
                country: "Israel",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Antalya, Turkey",
                coordinate: CLLocationCoordinate2D(latitude: 36.8969, longitude: 30.7133),
                timeZoneIdentifier: "Europe/Istanbul",
                country: "Turkey",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Perth, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -31.9505, longitude: 115.8605),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Adelaide, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -34.9285, longitude: 138.6007),
                timeZoneIdentifier: "Australia/Adelaide",
                country: "Australia",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Cape Town, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -33.9249, longitude: 18.4241),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Marrakech, Morocco",
                coordinate: CLLocationCoordinate2D(latitude: 31.6295, longitude: -7.9811),
                timeZoneIdentifier: "Africa/Casablanca",
                country: "Morocco",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Agadir, Morocco",
                coordinate: CLLocationCoordinate2D(latitude: 30.4278, longitude: -9.5981),
                timeZoneIdentifier: "Africa/Casablanca",
                country: "Morocco",
                priority: 8
            )
        ],
        
        .rainy: [
            GlobalWeatherLocation(name: "Bergen, Norway", coordinate: CLLocationCoordinate2D(latitude: 60.3913, longitude: 5.3221), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 10),
            GlobalWeatherLocation(name: "Edinburgh, Scotland", coordinate: CLLocationCoordinate2D(latitude: 55.9533, longitude: -3.1883), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 9),
            GlobalWeatherLocation(name: "Dublin, Ireland", coordinate: CLLocationCoordinate2D(latitude: 53.3498, longitude: -6.2603), timeZoneIdentifier: "Europe/Dublin", country: "Ireland", priority: 8),
            GlobalWeatherLocation(name: "Portland, Oregon", coordinate: CLLocationCoordinate2D(latitude: 45.5152, longitude: -122.6784), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 7),
            GlobalWeatherLocation(name: "Seattle, Washington", coordinate: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 6),
            GlobalWeatherLocation(name: "Vancouver, Canada", coordinate: CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207), timeZoneIdentifier: "America/Vancouver", country: "Canada", priority: 5),
            GlobalWeatherLocation(name: "Cork, Ireland", coordinate: CLLocationCoordinate2D(latitude: 51.8985, longitude: -8.4756), timeZoneIdentifier: "Europe/Dublin", country: "Ireland", priority: 4),
            GlobalWeatherLocation(name: "Glasgow, Scotland", coordinate: CLLocationCoordinate2D(latitude: 55.8642, longitude: -4.2518), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 3),
            GlobalWeatherLocation(name: "Seattle, Washington", coordinate: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Portland, Oregon", coordinate: CLLocationCoordinate2D(latitude: 45.5152, longitude: -122.6784), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Vancouver, Canada", coordinate: CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207), timeZoneIdentifier: "America/Vancouver", country: "Canada", priority: 8),
            GlobalWeatherLocation(name: "London, England", coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 7),GlobalWeatherLocation(
                name: "Mumbai, India",
                coordinate: CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Cherrapunji, India",
                coordinate: CLLocationCoordinate2D(latitude: 25.3000, longitude: 91.7000),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Hilo, Hawaii",
                coordinate: CLLocationCoordinate2D(latitude: 19.7297, longitude: -155.0900),
                timeZoneIdentifier: "Pacific/Honolulu",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Mawsynram, India",
                coordinate: CLLocationCoordinate2D(latitude: 25.2972, longitude: 91.5833),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Kuala Lumpur, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 3.1390, longitude: 101.6869),
                timeZoneIdentifier: "Asia/Kuala_Lumpur",
                country: "Malaysia",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Singapore",
                coordinate: CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198),
                timeZoneIdentifier: "Asia/Singapore",
                country: "Singapore",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Manaus, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -3.1190, longitude: -60.0217),
                timeZoneIdentifier: "America/Manaus",
                country: "Brazil",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Belém, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -1.4558, longitude: -48.4902),
                timeZoneIdentifier: "America/Belem",
                country: "Brazil",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Dhaka, Bangladesh",
                coordinate: CLLocationCoordinate2D(latitude: 23.8103, longitude: 90.4125),
                timeZoneIdentifier: "Asia/Dhaka",
                country: "Bangladesh",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Yangon, Myanmar",
                coordinate: CLLocationCoordinate2D(latitude: 16.8661, longitude: 96.1951),
                timeZoneIdentifier: "Asia/Yangon",
                country: "Myanmar",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Ho Chi Minh City, Vietnam",
                coordinate: CLLocationCoordinate2D(latitude: 10.8231, longitude: 106.6297),
                timeZoneIdentifier: "Asia/Ho_Chi_Minh",
                country: "Vietnam",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Chennai, India",
                coordinate: CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Kochi, India",
                coordinate: CLLocationCoordinate2D(latitude: 9.9312, longitude: 76.2673),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Colombo, Sri Lanka",
                coordinate: CLLocationCoordinate2D(latitude: 6.9271, longitude: 79.8612),
                timeZoneIdentifier: "Asia/Colombo",
                country: "Sri Lanka",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Bangkok, Thailand",
                coordinate: CLLocationCoordinate2D(latitude: 13.7563, longitude: 100.5018),
                timeZoneIdentifier: "Asia/Bangkok",
                country: "Thailand",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Chittagong, Bangladesh",
                coordinate: CLLocationCoordinate2D(latitude: 22.3569, longitude: 91.7832),
                timeZoneIdentifier: "Asia/Dhaka",
                country: "Bangladesh",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Quito, Ecuador",
                coordinate: CLLocationCoordinate2D(latitude: -0.1807, longitude: -78.4678),
                timeZoneIdentifier: "America/Guayaquil",
                country: "Ecuador",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Valdivia, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -39.8142, longitude: -73.2459),
                timeZoneIdentifier: "America/Santiago",
                country: "Chile",
                priority: 8
            )
        ],
        
        .cloudy: [
    GlobalWeatherLocation(
        name: "Bergen, Norway",
        coordinate: CLLocationCoordinate2D(latitude: 60.3913, longitude: 5.3221),
        timeZoneIdentifier: "Europe/Oslo",
        country: "Norway",
        priority: 10
    ),
    GlobalWeatherLocation(
        name: "Reykjavik, Iceland",
        coordinate: CLLocationCoordinate2D(latitude: 64.1466, longitude: -21.9426),
        timeZoneIdentifier: "Atlantic/Reykjavik",
        country: "Iceland",
        priority: 10
    ),
    GlobalWeatherLocation(
        name: "Galway, Ireland",
        coordinate: CLLocationCoordinate2D(latitude: 53.2707, longitude: -9.0568),
        timeZoneIdentifier: "Europe/Dublin",
        country: "Ireland",
        priority: 9
    ),
    GlobalWeatherLocation(
        name: "Aberdeen, Scotland",
        coordinate: CLLocationCoordinate2D(latitude: 57.1497, longitude: -2.0943),
        timeZoneIdentifier: "Europe/London",
        country: "United Kingdom",
        priority: 9
    ),
    GlobalWeatherLocation(
        name: "Trondheim, Norway",
        coordinate: CLLocationCoordinate2D(latitude: 63.4305, longitude: 10.3951),
        timeZoneIdentifier: "Europe/Oslo",
        country: "Norway",
        priority: 9
    ),
    GlobalWeatherLocation(
        name: "Halifax, Nova Scotia",
        coordinate: CLLocationCoordinate2D(latitude: 44.6488, longitude: -63.5752),
        timeZoneIdentifier: "America/Halifax",
        country: "Canada",
        priority: 9
    ),
    GlobalWeatherLocation(
        name: "Gothenburg, Sweden",
        coordinate: CLLocationCoordinate2D(latitude: 57.7089, longitude: 11.9746),
        timeZoneIdentifier: "Europe/Stockholm",
        country: "Sweden",
        priority: 9
    ),
    GlobalWeatherLocation(
        name: "Amsterdam, Netherlands",
        coordinate: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041),
        timeZoneIdentifier: "Europe/Amsterdam",
        country: "Netherlands",
        priority: 8
    ),
    GlobalWeatherLocation(
        name: "Copenhagen, Denmark",
        coordinate: CLLocationCoordinate2D(latitude: 55.6761, longitude: 12.5683),
        timeZoneIdentifier: "Europe/Copenhagen",
        country: "Denmark",
        priority: 8
    ),
    GlobalWeatherLocation(
        name: "Akureyri, Iceland",
        coordinate: CLLocationCoordinate2D(latitude: 65.6835, longitude: -18.1262),
        timeZoneIdentifier: "Atlantic/Reykjavik",
        country: "Iceland",
        priority: 8
    ),
    GlobalWeatherLocation(
        name: "Cork, Ireland",
        coordinate: CLLocationCoordinate2D(latitude: 51.8985, longitude: -8.4756),
        timeZoneIdentifier: "Europe/Dublin",
        country: "Ireland",
        priority: 8
    ),
    GlobalWeatherLocation(
        name: "Newcastle, England",
        coordinate: CLLocationCoordinate2D(latitude: 54.9783, longitude: -1.6178),
        timeZoneIdentifier: "Europe/London",
        country: "United Kingdom",
        priority: 8
    ),
    GlobalWeatherLocation(
        name: "Bellingham, Washington",
        coordinate: CLLocationCoordinate2D(latitude: 48.7519, longitude: -122.4787),
        timeZoneIdentifier: "America/Los_Angeles",
        country: "United States",
        priority: 8
    ),
    GlobalWeatherLocation(
        name: "Olympia, Washington",
        coordinate: CLLocationCoordinate2D(latitude: 47.0379, longitude: -122.9015),
        timeZoneIdentifier: "America/Los_Angeles",
        country: "United States",
        priority: 8
    ),
    // ...existing cloudy locations...
],        
        
        .stormy: [
GlobalWeatherLocation(name: "Kansas City, Missouri", coordinate: CLLocationCoordinate2D(latitude: 39.0997, longitude: -94.5786), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Oklahoma City, Oklahoma", coordinate: CLLocationCoordinate2D(latitude: 35.4676, longitude: -97.5164), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Wichita, Kansas", coordinate: CLLocationCoordinate2D(latitude: 37.6872, longitude: -97.3301), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "Aberdeen, Scotland", coordinate: CLLocationCoordinate2D(latitude: 57.1497, longitude: -2.0943), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 7),
            GlobalWeatherLocation(name: "Bergen, Norway", coordinate: CLLocationCoordinate2D(latitude: 60.3913, longitude: 5.3221), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 6),            GlobalWeatherLocation(name: "Miami, Florida", coordinate: CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918), timeZoneIdentifier: "America/New_York", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "New Orleans, Louisiana", coordinate: CLLocationCoordinate2D(latitude: 29.9511, longitude: -90.0715), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Houston, Texas", coordinate: CLLocationCoordinate2D(latitude: 29.7604, longitude: -95.3698), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "Tampa, Florida", coordinate: CLLocationCoordinate2D(latitude: 27.9506, longitude: -82.4572), timeZoneIdentifier: "America/New_York", country: "United States", priority: 7),
            GlobalWeatherLocation(name: "Charleston, South Carolina", coordinate: CLLocationCoordinate2D(latitude: 32.7767, longitude: -79.9311), timeZoneIdentifier: "America/New_York", country: "United States", priority: 6),
            GlobalWeatherLocation(name: "Savannah, Georgia", coordinate: CLLocationCoordinate2D(latitude: 32.0835, longitude: -81.0998), timeZoneIdentifier: "America/New_York", country: "United States", priority: 5),
            GlobalWeatherLocation(
                name: "Moore, Oklahoma",
                coordinate: CLLocationCoordinate2D(latitude: 35.3395, longitude: -97.4864),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Joplin, Missouri",
                coordinate: CLLocationCoordinate2D(latitude: 37.0842, longitude: -94.5133),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Tornado Alley Center, Kansas",
                coordinate: CLLocationCoordinate2D(latitude: 37.5000, longitude: -98.0000),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Lake Maracaibo, Venezuela",
                coordinate: CLLocationCoordinate2D(latitude: 9.7489, longitude: -71.2070),
                timeZoneIdentifier: "America/Caracas",
                country: "Venezuela",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Kampala, Uganda",
                coordinate: CLLocationCoordinate2D(latitude: 0.3476, longitude: 32.5825),
                timeZoneIdentifier: "Africa/Kampala",
                country: "Uganda",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Darwin, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -12.4634, longitude: 130.8456),
                timeZoneIdentifier: "Australia/Darwin",
                country: "Australia",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Tampa, Florida",
                coordinate: CLLocationCoordinate2D(latitude: 27.9506, longitude: -82.4572),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Miami, Florida",
                coordinate: CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Stornoway, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 58.2090, longitude: -6.3890),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Faroe Islands, Tórshavn",
                coordinate: CLLocationCoordinate2D(latitude: 62.0079, longitude: -6.7719),
                timeZoneIdentifier: "Atlantic/Faroe",
                country: "Faroe Islands",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Reykjavik, Iceland",
                coordinate: CLLocationCoordinate2D(latitude: 64.1466, longitude: -21.9426),
                timeZoneIdentifier: "Atlantic/Reykjavik",
                country: "Iceland",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Stavanger, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 58.9700, longitude: 5.7331),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Trondheim, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 63.4305, longitude: 10.3951),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Tulsa, Oklahoma",
                coordinate: CLLocationCoordinate2D(latitude: 36.1539, longitude: -95.9928),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Topeka, Kansas",
                coordinate: CLLocationCoordinate2D(latitude: 39.0473, longitude: -95.6890),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Amarillo, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 35.2220, longitude: -101.8313),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Dallas, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 32.7767, longitude: -96.7970),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Fort Worth, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 32.7555, longitude: -97.3308),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 8
            )
        ],
        
        .snowy: [
                        // Arctic Strongholds
            GlobalWeatherLocation(name: "Fairbanks, Alaska", coordinate: CLLocationCoordinate2D(latitude: 64.8378, longitude: -147.7164), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Anchorage, Alaska", coordinate: CLLocationCoordinate2D(latitude: 61.2181, longitude: -149.9003), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Reykjavik, Iceland", coordinate: CLLocationCoordinate2D(latitude: 64.1466, longitude: -21.9426), timeZoneIdentifier: "Atlantic/Reykjavik", country: "Iceland", priority: 9),
            GlobalWeatherLocation(name: "Tromsø, Norway", coordinate: CLLocationCoordinate2D(latitude: 69.6496, longitude: 18.9553), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 9),
            GlobalWeatherLocation(name: "Murmansk, Russia", coordinate: CLLocationCoordinate2D(latitude: 68.9585, longitude: 33.0827), timeZoneIdentifier: "Europe/Moscow", country: "Russia", priority: 9),
            GlobalWeatherLocation(name: "Yellowknife, Canada", coordinate: CLLocationCoordinate2D(latitude: 62.4540, longitude: -114.3718), timeZoneIdentifier: "America/Yellowknife", country: "Canada", priority: 9),
            
            // Nordic Countries
            GlobalWeatherLocation(name: "Rovaniemi, Finland", coordinate: CLLocationCoordinate2D(latitude: 66.5039, longitude: 25.7294), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 8),
            GlobalWeatherLocation(name: "Oslo, Norway", coordinate: CLLocationCoordinate2D(latitude: 59.9139, longitude: 10.7522), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 8),
            GlobalWeatherLocation(name: "Stockholm, Sweden", coordinate: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 7),
            GlobalWeatherLocation(name: "Helsinki, Finland", coordinate: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 7),
            
            // Canadian Cities
            GlobalWeatherLocation(name: "Montreal, Canada", coordinate: CLLocationCoordinate2D(latitude: 45.5017, longitude: -73.5673), timeZoneIdentifier: "America/Toronto", country: "Canada", priority: 6),
            GlobalWeatherLocation(name: "Calgary, Canada", coordinate: CLLocationCoordinate2D(latitude: 51.0447, longitude: -114.0719), timeZoneIdentifier: "America/Edmonton", country: "Canada", priority: 6),
            GlobalWeatherLocation(name: "Edmonton, Canada", coordinate: CLLocationCoordinate2D(latitude: 53.5461, longitude: -113.4938), timeZoneIdentifier: "America/Edmonton", country: "Canada", priority: 6),
            
            // High Altitude US Locations
            GlobalWeatherLocation(name: "Denver, Colorado", coordinate: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903), timeZoneIdentifier: "America/Denver", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Salt Lake City, Utah", coordinate: CLLocationCoordinate2D(latitude: 40.7608, longitude: -111.8910), timeZoneIdentifier: "America/Denver", country: "United States", priority: 5),
GlobalWeatherLocation(name: "Anchorage, Alaska", coordinate: CLLocationCoordinate2D(latitude: 61.2181, longitude: -149.9003), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Fairbanks, Alaska", coordinate: CLLocationCoordinate2D(latitude: 64.8378, longitude: -147.7164), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Reykjavik, Iceland", coordinate: CLLocationCoordinate2D(latitude: 64.1466, longitude: -21.9426), timeZoneIdentifier: "Atlantic/Reykjavik", country: "Iceland", priority: 8),
            GlobalWeatherLocation(name: "Oslo, Norway", coordinate: CLLocationCoordinate2D(latitude: 59.9139, longitude: 10.7522), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 7),
            GlobalWeatherLocation(name: "Stockholm, Sweden", coordinate: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 6),
            GlobalWeatherLocation(name: "Helsinki, Finland", coordinate: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 5),
                        GlobalWeatherLocation(name: "Anchorage, Alaska", coordinate: CLLocationCoordinate2D(latitude: 61.2181, longitude: -149.9003), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Fairbanks, Alaska", coordinate: CLLocationCoordinate2D(latitude: 64.8378, longitude: -147.7164), timeZoneIdentifier: "America/Anchorage", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Reykjavik, Iceland", coordinate: CLLocationCoordinate2D(latitude: 64.1466, longitude: -21.9426), timeZoneIdentifier: "Atlantic/Reykjavik", country: "Iceland", priority: 8),
            GlobalWeatherLocation(name: "Oslo, Norway", coordinate: CLLocationCoordinate2D(latitude: 59.9139, longitude: 10.7522), timeZoneIdentifier: "Europe/Oslo", country: "Norway", priority: 7),
            GlobalWeatherLocation(name: "Stockholm, Sweden", coordinate: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 6),
            GlobalWeatherLocation(name: "Helsinki, Finland", coordinate: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 5),
             GlobalWeatherLocation(
                name: "Barrow (Utqiagvik), Alaska",
                coordinate: CLLocationCoordinate2D(latitude: 71.2906, longitude: -156.7886),
                timeZoneIdentifier: "America/Anchorage",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Alert, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 82.5018, longitude: -62.3481),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Longyearbyen, Svalbard",
                coordinate: CLLocationCoordinate2D(latitude: 78.2232, longitude: 15.6267),
                timeZoneIdentifier: "Arctic/Longyearbyen",
                country: "Norway",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Kiruna, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 67.8558, longitude: 20.2253),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Tromsø, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 69.6496, longitude: 18.9553),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Murmansk, Russia",
                coordinate: CLLocationCoordinate2D(latitude: 68.9585, longitude: 33.0827),
                timeZoneIdentifier: "Europe/Moscow",
                country: "Russia",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Rovaniemi, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 66.5039, longitude: 25.7294),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Inuvik, Northwest Territories",
                coordinate: CLLocationCoordinate2D(latitude: 68.3607, longitude: -133.7230),
                timeZoneIdentifier: "America/Inuvik",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Yellowknife, Northwest Territories",
                coordinate: CLLocationCoordinate2D(latitude: 62.4540, longitude: -114.3718),
                timeZoneIdentifier: "America/Yellowknife",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Iqaluit, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 63.7467, longitude: -68.5170),
                timeZoneIdentifier: "America/Iqaluit",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Whitehorse, Yukon",
                coordinate: CLLocationCoordinate2D(latitude: 60.7212, longitude: -135.0568),
                timeZoneIdentifier: "America/Whitehorse",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Zermatt, Switzerland",
                coordinate: CLLocationCoordinate2D(latitude: 46.0207, longitude: 7.7491),
                timeZoneIdentifier: "Europe/Zurich",
                country: "Switzerland",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "St. Moritz, Switzerland",
                coordinate: CLLocationCoordinate2D(latitude: 46.4908, longitude: 9.8355),
                timeZoneIdentifier: "Europe/Zurich",
                country: "Switzerland",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Chamonix, France",
                coordinate: CLLocationCoordinate2D(latitude: 45.9237, longitude: 6.8694),
                timeZoneIdentifier: "Europe/Paris",
                country: "France",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Innsbruck, Austria",
                coordinate: CLLocationCoordinate2D(latitude: 47.2692, longitude: 11.4041),
                timeZoneIdentifier: "Europe/Vienna",
                country: "Austria",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Garmisch-Partenkirchen, Germany",
                coordinate: CLLocationCoordinate2D(latitude: 47.4917, longitude: 11.0954),
                timeZoneIdentifier: "Europe/Berlin",
                country: "Germany",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Banff, Alberta",
                coordinate: CLLocationCoordinate2D(latitude: 51.1784, longitude: -115.5708),
                timeZoneIdentifier: "America/Edmonton",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Jasper, Alberta",
                coordinate: CLLocationCoordinate2D(latitude: 52.8737, longitude: -118.0814),
                timeZoneIdentifier: "America/Edmonton",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Lake Louise, Alberta",
                coordinate: CLLocationCoordinate2D(latitude: 51.4254, longitude: -116.1773),
                timeZoneIdentifier: "America/Edmonton",
                country: "Canada",
                priority: 8
            )
        ],
        
        .foggy: [
            // Existing foggy locations from Part 6
            GlobalWeatherLocation(name: "San Francisco, California", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "London, England", coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 9),
            GlobalWeatherLocation(name: "Seattle, Washington", coordinate: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "Halifax, Nova Scotia", coordinate: CLLocationCoordinate2D(latitude: 44.6488, longitude: -63.5752), timeZoneIdentifier: "America/Halifax", country: "Canada", priority: 7),
             GlobalWeatherLocation(
                name: "Grand Banks, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 44.5000, longitude: -50.0000),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Argentia, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 47.2967, longitude: -53.9769),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Point Reyes, California",
                coordinate: CLLocationCoordinate2D(latitude: 38.0370, longitude: -122.9581),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Half Moon Bay, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.4636, longitude: -122.4286),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Mendocino, California",
                coordinate: CLLocationCoordinate2D(latitude: 39.3074, longitude: -123.7991),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Eureka, California",
                coordinate: CLLocationCoordinate2D(latitude: 40.8021, longitude: -124.1637),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Pacifica, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.6138, longitude: -122.4869),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Monterey, California",
                coordinate: CLLocationCoordinate2D(latitude: 36.6002, longitude: -121.8947),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "St. John's, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 47.5615, longitude: -52.7126),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Gander, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 48.9564, longitude: -54.6044),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Sable Island, Nova Scotia",
                coordinate: CLLocationCoordinate2D(latitude: 43.9340, longitude: -59.9149),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Sydney, Nova Scotia",
                coordinate: CLLocationCoordinate2D(latitude: 46.1351, longitude: -60.1831),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Yarmouth, Nova Scotia",
                coordinate: CLLocationCoordinate2D(latitude: 43.8374, longitude: -66.1175),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Charlottetown, Prince Edward Island",
                coordinate: CLLocationCoordinate2D(latitude: 46.2382, longitude: -63.1311),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Saint John, New Brunswick",
                coordinate: CLLocationCoordinate2D(latitude: 45.2733, longitude: -66.0633),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Tofino, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 49.1533, longitude: -125.9069),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Prince Rupert, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 54.3150, longitude: -130.3209),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 8
            )
        ],
        
        .misty: [
 GlobalWeatherLocation(name: "Great Smoky Mountains, Tennessee", coordinate: CLLocationCoordinate2D(latitude: 35.6532, longitude: -83.5070), timeZoneIdentifier: "America/New_York", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "Pacific Northwest, Washington", coordinate: CLLocationCoordinate2D(latitude: 47.7511, longitude: -120.7401), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Scottish Highlands", coordinate: CLLocationCoordinate2D(latitude: 57.0000, longitude: -4.0000), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 8),
            GlobalWeatherLocation(name: "Lake District, England", coordinate: CLLocationCoordinate2D(latitude: 54.4609, longitude: -3.0886), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 7),
            GlobalWeatherLocation(
                name: "Blue Ridge Mountains, Virginia",
                coordinate: CLLocationCoordinate2D(latitude: 38.5000, longitude: -78.5000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Shenandoah Valley, Virginia",
                coordinate: CLLocationCoordinate2D(latitude: 38.7184, longitude: -78.1694),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Appalachian Mountains, North Carolina",
                coordinate: CLLocationCoordinate2D(latitude: 35.7596, longitude: -82.2644),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Olympic Peninsula, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 47.8021, longitude: -123.6044),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Hoh Rainforest, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 47.8606, longitude: -123.9348),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Mount Rainier, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 46.8523, longitude: -121.7603),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Cascade Mountains, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 44.0000, longitude: -121.7000),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Canadian Rockies, Alberta",
                coordinate: CLLocationCoordinate2D(latitude: 52.0000, longitude: -117.0000),
                timeZoneIdentifier: "America/Edmonton",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Coast Mountains, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 51.0000, longitude: -125.0000),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Isle of Skye, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 57.2730, longitude: -6.2159),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Ben Nevis, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 56.7969, longitude: -5.0037),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Cairngorms, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 57.0833, longitude: -3.6667),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Wicklow Mountains, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 53.0000, longitude: -6.4000),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Ring of Kerry, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 51.8661, longitude: -9.9297),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Dingle Peninsula, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 52.1400, longitude: -10.2700),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Black Forest, Germany",
                coordinate: CLLocationCoordinate2D(latitude: 48.0000, longitude: 8.2000),
                timeZoneIdentifier: "Europe/Berlin",
                country: "Germany",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Vosges Mountains, France",
                coordinate: CLLocationCoordinate2D(latitude: 48.0000, longitude: 7.0000),
                timeZoneIdentifier: "Europe/Paris",
                country: "France",
                priority: 8
            )
        ],
        
        .breezy: [
            GlobalWeatherLocation(name: "Chicago, Illinois", coordinate: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 10),
            GlobalWeatherLocation(name: "San Francisco, California", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 9),
            GlobalWeatherLocation(name: "Wellington, New Zealand", coordinate: CLLocationCoordinate2D(latitude: -41.2924, longitude: 174.7787), timeZoneIdentifier: "Pacific/Auckland", country: "New Zealand", priority: 8),
            GlobalWeatherLocation(name: "Amsterdam, Netherlands", coordinate: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041), timeZoneIdentifier: "Europe/Amsterdam", country: "Netherlands", priority: 7),
            GlobalWeatherLocation(
                name: "Cape Horn, Chile",
                coordinate: CLLocationCoordinate2D(latitude: -55.9833, longitude: -67.2667),
                timeZoneIdentifier: "America/Punta_Arenas",
                country: "Chile",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Cape of Good Hope, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -34.3587, longitude: 18.4716),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Great Plains Wind Corridor, Kansas",
                coordinate: CLLocationCoordinate2D(latitude: 38.5000, longitude: -98.0000),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Dodge City, Kansas",
                coordinate: CLLocationCoordinate2D(latitude: 37.7528, longitude: -100.0171),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 10
            ),
            GlobalWeatherLocation(
                name: "Amarillo, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 35.2220, longitude: -101.8313),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Lubbock, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 33.5779, longitude: -101.8552),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Corpus Christi, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 27.8006, longitude: -97.3964),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Oklahoma City, Oklahoma",
                coordinate: CLLocationCoordinate2D(latitude: 35.4676, longitude: -97.5164),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Cheyenne, Wyoming",
                coordinate: CLLocationCoordinate2D(latitude: 41.1400, longitude: -104.8197),
                timeZoneIdentifier: "America/Denver",
                country: "United States",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Medicine Hat, Alberta",
                coordinate: CLLocationCoordinate2D(latitude: 50.0411, longitude: -110.6819),
                timeZoneIdentifier: "America/Edmonton",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Lethbridge, Alberta",
                coordinate: CLLocationCoordinate2D(latitude: 49.6934, longitude: -112.8414),
                timeZoneIdentifier: "America/Edmonton",
                country: "Canada",
                priority: 9
            ),
            GlobalWeatherLocation(
                name: "Cape Leeuwin, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -34.3708, longitude: 115.1350),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Roaring Forties Zone, Southern Ocean",
                coordinate: CLLocationCoordinate2D(latitude: -45.0000, longitude: 150.0000),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "International Waters",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Cook Strait, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -41.2000, longitude: 174.5000),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Foveaux Strait, New Zealand",
                coordinate: CLLocationCoordinate2D(latitude: -46.6000, longitude: 168.0000),
                timeZoneIdentifier: "Pacific/Auckland",
                country: "New Zealand",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Bass Strait, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -39.5000, longitude: 145.0000),
                timeZoneIdentifier: "Australia/Melbourne",
                country: "Australia",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Port Lincoln, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -34.7282, longitude: 135.8735),
                timeZoneIdentifier: "Australia/Adelaide",
                country: "Australia",
                priority: 8
            ),
            GlobalWeatherLocation(
                name: "Albany, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -35.0269, longitude: 117.8840),
                timeZoneIdentifier: "Australia/Perth",
                country: "Australia",
                priority: 8
            )
        ]
    ]
    
    /// Secondary locations with medium confidence
    private var secondaryLocations: [WeatherVibe: [GlobalWeatherLocation]] = [
        .sunny: [
            GlobalWeatherLocation(name: "Rome, Italy", coordinate: CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964), timeZoneIdentifier: "Europe/Rome", country: "Italy", priority: 8),
            GlobalWeatherLocation(name: "Madrid, Spain", coordinate: CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038), timeZoneIdentifier: "Europe/Madrid", country: "Spain", priority: 7),
            GlobalWeatherLocation(name: "Lisbon, Portugal", coordinate: CLLocationCoordinate2D(latitude: 38.7223, longitude: -9.1393), timeZoneIdentifier: "Europe/Lisbon", country: "Portugal", priority: 6),
            GlobalWeatherLocation(name: "Marseille, France", coordinate: CLLocationCoordinate2D(latitude: 43.2965, longitude: 5.3698), timeZoneIdentifier: "Europe/Paris", country: "France", priority: 5),
            GlobalWeatherLocation(name: "Denver, Colorado", coordinate: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903), timeZoneIdentifier: "America/Denver", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "Austin, Texas", coordinate: CLLocationCoordinate2D(latitude: 30.2672, longitude: -97.7431), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 7),
            GlobalWeatherLocation(name: "Sacramento, California", coordinate: CLLocationCoordinate2D(latitude: 38.5816, longitude: -121.4944), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 6),
            GlobalWeatherLocation(name: "Salt Lake City, Utah", coordinate: CLLocationCoordinate2D(latitude: 40.7608, longitude: -111.8910), timeZoneIdentifier: "America/Denver", country: "United States", priority: 5),
            GlobalWeatherLocation(name: "Málaga, Spain", coordinate: CLLocationCoordinate2D(latitude: 36.7213, longitude: -4.4214), timeZoneIdentifier: "Europe/Madrid", country: "Spain", priority: 7),
            GlobalWeatherLocation(name: "Alicante, Spain", coordinate: CLLocationCoordinate2D(latitude: 38.3452, longitude: -0.4810), timeZoneIdentifier: "Europe/Madrid", country: "Spain", priority: 7),
            GlobalWeatherLocation(name: "Murcia, Spain", coordinate: CLLocationCoordinate2D(latitude: 37.9922, longitude: -1.1307), timeZoneIdentifier: "Europe/Madrid", country: "Spain", priority: 7),
            GlobalWeatherLocation(
                name: "Córdoba, Spain",
                coordinate: CLLocationCoordinate2D(latitude: 37.8882, longitude: -4.7794),
                timeZoneIdentifier: "Europe/Madrid",
                country: "Spain",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Faro, Portugal",
                coordinate: CLLocationCoordinate2D(latitude: 37.0194, longitude: -7.9322),
                timeZoneIdentifier: "Europe/Lisbon",
                country: "Portugal",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Porto, Portugal",
                coordinate: CLLocationCoordinate2D(latitude: 41.1579, longitude: -8.6291),
                timeZoneIdentifier: "Europe/Lisbon",
                country: "Portugal",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Naples, Italy",
                coordinate: CLLocationCoordinate2D(latitude: 40.8518, longitude: 14.2681),
                timeZoneIdentifier: "Europe/Rome",
                country: "Italy",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Bari, Italy",
                coordinate: CLLocationCoordinate2D(latitude: 41.1171, longitude: 16.8719),
                timeZoneIdentifier: "Europe/Rome",
                country: "Italy",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Cagliari, Italy",
                coordinate: CLLocationCoordinate2D(latitude: 39.2238, longitude: 9.1217),
                timeZoneIdentifier: "Europe/Rome",
                country: "Italy",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Thessaloniki, Greece",
                coordinate: CLLocationCoordinate2D(latitude: 40.6401, longitude: 22.9444),
                timeZoneIdentifier: "Europe/Athens",
                country: "Greece",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Patras, Greece",
                coordinate: CLLocationCoordinate2D(latitude: 38.2466, longitude: 21.7346),
                timeZoneIdentifier: "Europe/Athens",
                country: "Greece",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Nicosia, Cyprus",
                coordinate: CLLocationCoordinate2D(latitude: 35.1856, longitude: 33.3823),
                timeZoneIdentifier: "Asia/Nicosia",
                country: "Cyprus",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Limassol, Cyprus",
                coordinate: CLLocationCoordinate2D(latitude: 34.6823, longitude: 33.0464),
                timeZoneIdentifier: "Asia/Nicosia",
                country: "Cyprus",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Split, Croatia",
                coordinate: CLLocationCoordinate2D(latitude: 43.5081, longitude: 16.4402),
                timeZoneIdentifier: "Europe/Zagreb",
                country: "Croatia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Dubrovnik, Croatia",
                coordinate: CLLocationCoordinate2D(latitude: 42.6507, longitude: 18.0944),
                timeZoneIdentifier: "Europe/Zagreb",
                country: "Croatia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Podgorica, Montenegro",
                coordinate: CLLocationCoordinate2D(latitude: 42.4411, longitude: 19.2636),
                timeZoneIdentifier: "Europe/Podgorica",
                country: "Montenegro",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Tirana, Albania",
                coordinate: CLLocationCoordinate2D(latitude: 41.3275, longitude: 19.8187),
                timeZoneIdentifier: "Europe/Tirane",
                country: "Albania",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Skopje, North Macedonia",
                coordinate: CLLocationCoordinate2D(latitude: 41.9973, longitude: 21.4280),
                timeZoneIdentifier: "Europe/Skopje",
                country: "North Macedonia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Valletta, Malta",
                coordinate: CLLocationCoordinate2D(latitude: 35.8989, longitude: 14.5146),
                timeZoneIdentifier: "Europe/Malta",
                country: "Malta",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Paphos, Cyprus",
                coordinate: CLLocationCoordinate2D(latitude: 34.7571, longitude: 32.4225),
                timeZoneIdentifier: "Asia/Nicosia",
                country: "Cyprus",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Bodrum, Turkey",
                coordinate: CLLocationCoordinate2D(latitude: 37.0344, longitude: 27.4305),
                timeZoneIdentifier: "Europe/Istanbul",
                country: "Turkey",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Izmir, Turkey",
                coordinate: CLLocationCoordinate2D(latitude: 38.4237, longitude: 27.1428),
                timeZoneIdentifier: "Europe/Istanbul",
                country: "Turkey",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Eilat, Israel",
                coordinate: CLLocationCoordinate2D(latitude: 29.5581, longitude: 34.9482),
                timeZoneIdentifier: "Asia/Jerusalem",
                country: "Israel",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Haifa, Israel",
                coordinate: CLLocationCoordinate2D(latitude: 32.7940, longitude: 34.9896),
                timeZoneIdentifier: "Asia/Jerusalem",
                country: "Israel",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Jerusalem, Israel",
                coordinate: CLLocationCoordinate2D(latitude: 31.7683, longitude: 35.2137),
                timeZoneIdentifier: "Asia/Jerusalem",
                country: "Israel",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Beirut, Lebanon",
                coordinate: CLLocationCoordinate2D(latitude: 33.8938, longitude: 35.5018),
                timeZoneIdentifier: "Asia/Beirut",
                country: "Lebanon",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Tunis, Tunisia",
                coordinate: CLLocationCoordinate2D(latitude: 36.8065, longitude: 10.1815),
                timeZoneIdentifier: "Africa/Tunis",
                country: "Tunisia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Algiers, Algeria",
                coordinate: CLLocationCoordinate2D(latitude: 36.7631, longitude: 3.0506),
                timeZoneIdentifier: "Africa/Algiers",
                country: "Algeria",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Rabat, Morocco",
                coordinate: CLLocationCoordinate2D(latitude: 34.0181, longitude: -6.8186),
                timeZoneIdentifier: "Africa/Casablanca",
                country: "Morocco",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Casablanca, Morocco",
                coordinate: CLLocationCoordinate2D(latitude: 33.5731, longitude: -7.5898),
                timeZoneIdentifier: "Africa/Casablanca",
                country: "Morocco",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Brisbane, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -27.4698, longitude: 153.0251),
                timeZoneIdentifier: "Australia/Brisbane",
                country: "Australia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Gold Coast, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -28.0167, longitude: 153.4000),
                timeZoneIdentifier: "Australia/Brisbane",
                country: "Australia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Darwin, Australia",
                coordinate: CLLocationCoordinate2D(latitude: -12.4634, longitude: 130.8456),
                timeZoneIdentifier: "Australia/Darwin",
                country: "Australia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Durban, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -29.8587, longitude: 31.0218),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Port Elizabeth, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -33.9608, longitude: 25.6022),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Stellenbosch, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -33.9321, longitude: 18.8602),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Hermanus, South Africa",
                coordinate: CLLocationCoordinate2D(latitude: -34.4187, longitude: 19.2345),
                timeZoneIdentifier: "Africa/Johannesburg",
                country: "South Africa",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Miami, Florida",
                coordinate: CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Tampa, Florida",
                coordinate: CLLocationCoordinate2D(latitude: 27.9506, longitude: -82.4572),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Orlando, Florida",
                coordinate: CLLocationCoordinate2D(latitude: 28.5383, longitude: -81.3792),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Austin, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 30.2672, longitude: -97.7431),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "San Antonio, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 29.4241, longitude: -98.4936),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 5
            )
        ],
        
        .rainy: [
             GlobalWeatherLocation(name: "Helsinki, Finland", coordinate: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384), timeZoneIdentifier: "Europe/Helsinki", country: "Finland", priority: 8),
        GlobalWeatherLocation(name: "Stockholm, Sweden", coordinate: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686), timeZoneIdentifier: "Europe/Stockholm", country: "Sweden", priority: 7),
        GlobalWeatherLocation(name: "Brussels, Belgium", coordinate: CLLocationCoordinate2D(latitude: 50.8503, longitude: 4.3517), timeZoneIdentifier: "Europe/Brussels", country: "Belgium", priority: 6),
        GlobalWeatherLocation(name: "Prague, Czech Republic", coordinate: CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378), timeZoneIdentifier: "Europe/Prague", country: "Czech Republic", priority: 5),
            GlobalWeatherLocation(name: "Boston, Massachusetts", coordinate: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589), timeZoneIdentifier: "America/New_York", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "New York, New York", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), timeZoneIdentifier: "America/New_York", country: "United States", priority: 7),
            GlobalWeatherLocation(name: "Atlanta, Georgia", coordinate: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880), timeZoneIdentifier: "America/New_York", country: "United States", priority: 6),
            GlobalWeatherLocation(name: "Montreal, Canada", coordinate: CLLocationCoordinate2D(latitude: 45.5017, longitude: -73.5673), timeZoneIdentifier: "America/Toronto", country: "Canada", priority: 5),GlobalWeatherLocation(
                name: "Guwahati, India",
                coordinate: CLLocationCoordinate2D(latitude: 26.1445, longitude: 91.7362),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Shillong, India",
                coordinate: CLLocationCoordinate2D(latitude: 25.5788, longitude: 91.8933),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Imphal, India",
                coordinate: CLLocationCoordinate2D(latitude: 24.8170, longitude: 93.9368),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Mangalore, India",
                coordinate: CLLocationCoordinate2D(latitude: 12.9141, longitude: 74.8560),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Udupi, India",
                coordinate: CLLocationCoordinate2D(latitude: 13.3409, longitude: 74.7421),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Goa, India",
                coordinate: CLLocationCoordinate2D(latitude: 15.2993, longitude: 74.1240),
                timeZoneIdentifier: "Asia/Kolkata",
                country: "India",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Kandy, Sri Lanka",
                coordinate: CLLocationCoordinate2D(latitude: 7.2906, longitude: 80.6337),
                timeZoneIdentifier: "Asia/Colombo",
                country: "Sri Lanka",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Chiang Mai, Thailand",
                coordinate: CLLocationCoordinate2D(latitude: 18.7883, longitude: 98.9853),
                timeZoneIdentifier: "Asia/Bangkok",
                country: "Thailand",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Phuket, Thailand",
                coordinate: CLLocationCoordinate2D(latitude: 7.8804, longitude: 98.3923),
                timeZoneIdentifier: "Asia/Bangkok",
                country: "Thailand",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Hanoi, Vietnam",
                coordinate: CLLocationCoordinate2D(latitude: 21.0285, longitude: 105.8542),
                timeZoneIdentifier: "Asia/Ho_Chi_Minh",
                country: "Vietnam",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Jakarta, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Medan, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: 3.5952, longitude: 98.6722),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Palembang, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -2.9761, longitude: 104.7754),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Padang, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -0.9471, longitude: 100.4172),
                timeZoneIdentifier: "Asia/Jakarta",
                country: "Indonesia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Pontianak, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -0.0263, longitude: 109.3425),
                timeZoneIdentifier: "Asia/Pontianak",
                country: "Indonesia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Banjarmasin, Indonesia",
                coordinate: CLLocationCoordinate2D(latitude: -3.3194, longitude: 114.5906),
                timeZoneIdentifier: "Asia/Pontianak",
                country: "Indonesia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Kuching, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 1.5535, longitude: 110.3593),
                timeZoneIdentifier: "Asia/Kuching",
                country: "Malaysia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Kota Kinabalu, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 5.9749, longitude: 116.0724),
                timeZoneIdentifier: "Asia/Kuching",
                country: "Malaysia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Ipoh, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 4.5975, longitude: 101.0901),
                timeZoneIdentifier: "Asia/Kuala_Lumpur",
                country: "Malaysia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Johor Bahru, Malaysia",
                coordinate: CLLocationCoordinate2D(latitude: 1.4655, longitude: 103.7578),
                timeZoneIdentifier: "Asia/Kuala_Lumpur",
                country: "Malaysia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Mandalay, Myanmar",
                coordinate: CLLocationCoordinate2D(latitude: 21.9588, longitude: 96.0891),
                timeZoneIdentifier: "Asia/Yangon",
                country: "Myanmar",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Manila, Philippines",
                coordinate: CLLocationCoordinate2D(latitude: 14.5995, longitude: 120.9842),
                timeZoneIdentifier: "Asia/Manila",
                country: "Philippines",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Cebu City, Philippines",
                coordinate: CLLocationCoordinate2D(latitude: 10.3157, longitude: 123.8854),
                timeZoneIdentifier: "Asia/Manila",
                country: "Philippines",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Davao, Philippines",
                coordinate: CLLocationCoordinate2D(latitude: 7.0731, longitude: 125.6128),
                timeZoneIdentifier: "Asia/Manila",
                country: "Philippines",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Cagayan de Oro, Philippines",
                coordinate: CLLocationCoordinate2D(latitude: 8.4542, longitude: 124.6319),
                timeZoneIdentifier: "Asia/Manila",
                country: "Philippines",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Iquitos, Peru",
                coordinate: CLLocationCoordinate2D(latitude: -3.7437, longitude: -73.2516),
                timeZoneIdentifier: "America/Lima",
                country: "Peru",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Puerto Maldonado, Peru",
                coordinate: CLLocationCoordinate2D(latitude: -12.5931, longitude: -69.1892),
                timeZoneIdentifier: "America/Lima",
                country: "Peru",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Santarém, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -2.4426, longitude: -54.7083),
                timeZoneIdentifier: "America/Santarem",
                country: "Brazil",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Macapá, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: 0.0349, longitude: -51.0694),
                timeZoneIdentifier: "America/Belem",
                country: "Brazil",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "São Luís, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -2.5307, longitude: -44.3068),
                timeZoneIdentifier: "America/Fortaleza",
                country: "Brazil",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Fortaleza, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -3.7319, longitude: -38.5267),
                timeZoneIdentifier: "America/Fortaleza",
                country: "Brazil",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Salvador, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -12.9714, longitude: -38.5014),
                timeZoneIdentifier: "America/Bahia",
                country: "Brazil",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Recife, Brazil",
                coordinate: CLLocationCoordinate2D(latitude: -8.0476, longitude: -34.8770),
                timeZoneIdentifier: "America/Recife",
                country: "Brazil",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Georgetown, Guyana",
                coordinate: CLLocationCoordinate2D(latitude: 6.8013, longitude: -58.1551),
                timeZoneIdentifier: "America/Guyana",
                country: "Guyana",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Paramaribo, Suriname",
                coordinate: CLLocationCoordinate2D(latitude: 5.8520, longitude: -55.2038),
                timeZoneIdentifier: "America/Paramaribo",
                country: "Suriname",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Cayenne, French Guiana",
                coordinate: CLLocationCoordinate2D(latitude: 4.9375, longitude: -52.3069),
                timeZoneIdentifier: "America/Cayenne",
                country: "French Guiana",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Guayaquil, Ecuador",
                coordinate: CLLocationCoordinate2D(latitude: -2.1894, longitude: -79.8890),
                timeZoneIdentifier: "America/Guayaquil",
                country: "Ecuador",
                priority: 5
            )
        ],
        
        .cloudy: [
GlobalWeatherLocation(
                name: "Lille, France",
                coordinate: CLLocationCoordinate2D(latitude: 50.6292, longitude: 3.0573),
                timeZoneIdentifier: "Europe/Paris",
                country: "France",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Antwerp, Belgium",
                coordinate: CLLocationCoordinate2D(latitude: 51.2194, longitude: 4.4025),
                timeZoneIdentifier: "Europe/Brussels",
                country: "Belgium",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Hamburg, Germany",
                coordinate: CLLocationCoordinate2D(latitude: 53.5511, longitude: 9.9937),
                timeZoneIdentifier: "Europe/Berlin",
                country: "Germany",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Düsseldorf, Germany",
                coordinate: CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735),
                timeZoneIdentifier: "Europe/Berlin",
                country: "Germany",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Cardiff, Wales",
                coordinate: CLLocationCoordinate2D(latitude: 51.4816, longitude: -3.1791),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Malmö, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 55.6050, longitude: 13.0038),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Aarhus, Denmark",
                coordinate: CLLocationCoordinate2D(latitude: 56.1629, longitude: 10.2039),
                timeZoneIdentifier: "Europe/Copenhagen",
                country: "Denmark",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "St. John's, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 47.5615, longitude: -52.7126),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Portland, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 45.5152, longitude: -122.6784),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Eugene, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 44.0521, longitude: -123.0868),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Inverness, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 57.4778, longitude: -4.2247),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Plymouth, England",
                coordinate: CLLocationCoordinate2D(latitude: 50.3755, longitude: -4.1427),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Kanazawa, Japan",
                coordinate: CLLocationCoordinate2D(latitude: 36.5944, longitude: 136.6256),
                timeZoneIdentifier: "Asia/Tokyo",
                country: "Japan",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Niigata, Japan",
                coordinate: CLLocationCoordinate2D(latitude: 37.9026, longitude: 139.0232),
                timeZoneIdentifier: "Asia/Tokyo",
                country: "Japan",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Sapporo, Japan",
                coordinate: CLLocationCoordinate2D(latitude: 43.0642, longitude: 141.3469),
                timeZoneIdentifier: "Asia/Tokyo",
                country: "Japan",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Rotterdam, Netherlands",
                coordinate: CLLocationCoordinate2D(latitude: 51.9244, longitude: 4.4777),
                timeZoneIdentifier: "Europe/Amsterdam",
                country: "Netherlands",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Tallinn, Estonia",
                coordinate: CLLocationCoordinate2D(latitude: 59.4370, longitude: 24.7536),
                timeZoneIdentifier: "Europe/Tallinn",
                country: "Estonia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Riga, Latvia",
                coordinate: CLLocationCoordinate2D(latitude: 56.9496, longitude: 24.1052),
                timeZoneIdentifier: "Europe/Riga",
                country: "Latvia",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Syracuse, New York",
                coordinate: CLLocationCoordinate2D(latitude: 43.0481, longitude: -76.1474),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Buffalo, New York",
                coordinate: CLLocationCoordinate2D(latitude: 42.8864, longitude: -78.8784),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Cleveland, Ohio",
                coordinate: CLLocationCoordinate2D(latitude: 41.4993, longitude: -81.6944),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Vilnius, Lithuania",
                coordinate: CLLocationCoordinate2D(latitude: 54.6872, longitude: 25.2797),
                timeZoneIdentifier: "Europe/Vilnius",
                country: "Lithuania",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Gdansk, Poland",
                coordinate: CLLocationCoordinate2D(latitude: 54.3520, longitude: 18.6466),
                timeZoneIdentifier: "Europe/Warsaw",
                country: "Poland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Tartu, Estonia",
                coordinate: CLLocationCoordinate2D(latitude: 58.3781, longitude: 26.7290),
                timeZoneIdentifier: "Europe/Tallinn",
                country: "Estonia",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Duluth, Minnesota",
                coordinate: CLLocationCoordinate2D(latitude: 46.7867, longitude: -92.1005),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Grand Rapids, Michigan",
                coordinate: CLLocationCoordinate2D(latitude: 42.9634, longitude: -85.6681),
                timeZoneIdentifier: "America/Detroit",
                country: "United States",
                priority: 5
            ),
            GlobalWeatherLocation(name: "Detroit, Michigan", coordinate: CLLocationCoordinate2D(latitude: 42.3314, longitude: -83.0458), timeZoneIdentifier: "America/New_York", country: "United States", priority: 8),
            GlobalWeatherLocation(name: "Buffalo, New York", coordinate: CLLocationCoordinate2D(latitude: 42.8864, longitude: -78.8784), timeZoneIdentifier: "America/New_York", country: "United States", priority: 7),
            GlobalWeatherLocation(name: "Milwaukee, Wisconsin", coordinate: CLLocationCoordinate2D(latitude: 43.0389, longitude: -87.9065), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 6),
            GlobalWeatherLocation(name: "Toronto, Canada", coordinate: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832), timeZoneIdentifier: "America/Toronto", country: "Canada", priority: 5)
        ],
        
        .stormy: [
GlobalWeatherLocation(name: "London, England", coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 8),
            GlobalWeatherLocation(name: "Amsterdam, Netherlands", coordinate: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041), timeZoneIdentifier: "Europe/Amsterdam", country: "Netherlands", priority: 7),
            GlobalWeatherLocation(name: "Dublin, Ireland", coordinate: CLLocationCoordinate2D(latitude: 53.3498, longitude: -6.2603), timeZoneIdentifier: "Europe/Dublin", country: "Ireland", priority: 6),
            GlobalWeatherLocation(name: "Copenhagen, Denmark", coordinate: CLLocationCoordinate2D(latitude: 55.6761, longitude: 12.5683), timeZoneIdentifier: "Europe/Copenhagen", country: "Denmark", priority: 5),
            GlobalWeatherLocation(name: "Oklahoma City, Oklahoma", coordinate: CLLocationCoordinate2D(latitude: 35.4676, longitude: -97.5164), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 8),
        GlobalWeatherLocation(name: "Kansas City, Missouri", coordinate: CLLocationCoordinate2D(latitude: 39.0997, longitude: -94.5786), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 7),
        GlobalWeatherLocation(name: "Dallas, Texas", coordinate: CLLocationCoordinate2D(latitude: 32.7767, longitude: -96.7970), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 6),
        GlobalWeatherLocation(name: "Nashville, Tennessee", coordinate: CLLocationCoordinate2D(latitude: 36.1627, longitude: -86.7816), timeZoneIdentifier: "America/Chicago", country: "United States", priority: 5),
            GlobalWeatherLocation(
                name: "Lincoln, Nebraska",
                coordinate: CLLocationCoordinate2D(latitude: 40.8136, longitude: -96.7026),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Omaha, Nebraska",
                coordinate: CLLocationCoordinate2D(latitude: 41.2565, longitude: -95.9345),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Des Moines, Iowa",
                coordinate: CLLocationCoordinate2D(latitude: 41.5868, longitude: -93.6250),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Little Rock, Arkansas",
                coordinate: CLLocationCoordinate2D(latitude: 34.7465, longitude: -92.2896),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Shreveport, Louisiana",
                coordinate: CLLocationCoordinate2D(latitude: 32.5252, longitude: -93.7502),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Lubbock, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 33.5779, longitude: -101.8552),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Abilene, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 32.4487, longitude: -99.7331),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Waco, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 31.5494, longitude: -97.1467),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Birmingham, Alabama",
                coordinate: CLLocationCoordinate2D(latitude: 33.5186, longitude: -86.8104),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Huntsville, Alabama",
                coordinate: CLLocationCoordinate2D(latitude: 34.7304, longitude: -86.5861),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Jackson, Mississippi",
                coordinate: CLLocationCoordinate2D(latitude: 32.2988, longitude: -90.1848),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Memphis, Tennessee",
                coordinate: CLLocationCoordinate2D(latitude: 35.1495, longitude: -90.0490),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Nashville, Tennessee",
                coordinate: CLLocationCoordinate2D(latitude: 36.1627, longitude: -86.7816),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Atlanta, Georgia",
                coordinate: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Inverness, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 57.4778, longitude: -4.2247),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Fort William, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 56.8198, longitude: -5.1052),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Glasgow, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 55.8642, longitude: -4.2518),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Edinburgh, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 55.9533, longitude: -3.1883),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Newcastle, England",
                coordinate: CLLocationCoordinate2D(latitude: 54.9783, longitude: -1.6178),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Liverpool, England",
                coordinate: CLLocationCoordinate2D(latitude: 53.4084, longitude: -2.9916),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Belfast, Northern Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 54.5973, longitude: -5.9301),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Cork, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 51.8985, longitude: -8.4756),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Galway, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 53.2707, longitude: -9.0568),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Hamburg, Germany",
                coordinate: CLLocationCoordinate2D(latitude: 53.5511, longitude: 9.9937),
                timeZoneIdentifier: "Europe/Berlin",
                country: "Germany",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Bremen, Germany",
                coordinate: CLLocationCoordinate2D(latitude: 53.0793, longitude: 8.8017),
                timeZoneIdentifier: "Europe/Berlin",
                country: "Germany",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Gothenburg, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 57.7089, longitude: 11.9746),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Malmö, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 55.6050, longitude: 13.0038),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Aarhus, Denmark",
                coordinate: CLLocationCoordinate2D(latitude: 56.1629, longitude: 10.2039),
                timeZoneIdentifier: "Europe/Copenhagen",
                country: "Denmark",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Esbjerg, Denmark",
                coordinate: CLLocationCoordinate2D(latitude: 55.4719, longitude: 8.4515),
                timeZoneIdentifier: "Europe/Copenhagen",
                country: "Denmark",
                priority: 5
            )
        ],
        
        .snowy: [
   GlobalWeatherLocation(name: "Montreal, Canada", coordinate: CLLocationCoordinate2D(latitude: 45.5017, longitude: -73.5673), timeZoneIdentifier: "America/Toronto", country: "Canada", priority: 8),
        GlobalWeatherLocation(name: "Toronto, Canada", coordinate: CLLocationCoordinate2D(latitude: 43.6532, longitude: -79.3832), timeZoneIdentifier: "America/Toronto", country: "Canada", priority: 7),
        GlobalWeatherLocation(name: "Vancouver, Canada", coordinate: CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207), timeZoneIdentifier: "America/Vancouver", country: "Canada", priority: 6),
        GlobalWeatherLocation(name: "Calgary, Canada", coordinate: CLLocationCoordinate2D(latitude: 51.0447, longitude: -114.0719), timeZoneIdentifier: "America/Edmonton", country: "Canada", priority: 5),
           GlobalWeatherLocation(
                name: "Churchill, Manitoba",
                coordinate: CLLocationCoordinate2D(latitude: 58.7684, longitude: -94.1647),
                timeZoneIdentifier: "America/Winnipeg",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Thompson, Manitoba",
                coordinate: CLLocationCoordinate2D(latitude: 55.7435, longitude: -97.8558),
                timeZoneIdentifier: "America/Winnipeg",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "The Pas, Manitoba",
                coordinate: CLLocationCoordinate2D(latitude: 53.8251, longitude: -101.2541),
                timeZoneIdentifier: "America/Winnipeg",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Fort McMurray, Alberta",
                coordinate: CLLocationCoordinate2D(latitude: 56.7267, longitude: -111.3790),
                timeZoneIdentifier: "America/Edmonton",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Prince George, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 53.9171, longitude: -122.7497),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Dawson City, Yukon",
                coordinate: CLLocationCoordinate2D(latitude: 64.0601, longitude: -139.4329),
                timeZoneIdentifier: "America/Dawson",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Resolute, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 74.6956, longitude: -94.8295),
                timeZoneIdentifier: "America/Resolute",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Grise Fiord, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 76.4219, longitude: -82.9019),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Pond Inlet, Nunavut",
                coordinate: CLLocationCoordinate2D(latitude: 72.6989, longitude: -77.9653),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Narvik, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 68.4384, longitude: 17.4272),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Alta, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 69.9689, longitude: 23.2717),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Hammerfest, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 70.6636, longitude: 23.6823),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Karasjok, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 69.4667, longitude: 25.5167),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Trondheim, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 63.4305, longitude: 10.3951),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Bergen, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 60.3913, longitude: 5.3221),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Lillehammer, Norway",
                coordinate: CLLocationCoordinate2D(latitude: 61.1153, longitude: 10.4662),
                timeZoneIdentifier: "Europe/Oslo",
                country: "Norway",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Luleå, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 65.5848, longitude: 22.1547),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Östersund, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 63.1792, longitude: 14.6357),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Umeå, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 63.8258, longitude: 20.2630),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Sundsvall, Sweden",
                coordinate: CLLocationCoordinate2D(latitude: 62.3908, longitude: 17.3069),
                timeZoneIdentifier: "Europe/Stockholm",
                country: "Sweden",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Ivalo, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 68.6564, longitude: 27.5461),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Sodankylä, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 67.4179, longitude: 26.6009),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Kemi, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 65.7367, longitude: 24.5658),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Oulu, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 65.0121, longitude: 25.4651),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Kuopio, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 62.8924, longitude: 27.6780),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Jyväskylä, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 62.2426, longitude: 25.7473),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Tampere, Finland",
                coordinate: CLLocationCoordinate2D(latitude: 61.4991, longitude: 23.7871),
                timeZoneIdentifier: "Europe/Helsinki",
                country: "Finland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Akureyri, Iceland",
                coordinate: CLLocationCoordinate2D(latitude: 65.6835, longitude: -18.1262),
                timeZoneIdentifier: "Atlantic/Reykjavik",
                country: "Iceland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Isafjordur, Iceland",
                coordinate: CLLocationCoordinate2D(latitude: 66.0749, longitude: -23.1339),
                timeZoneIdentifier: "Atlantic/Reykjavik",
                country: "Iceland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Egilsstadir, Iceland",
                coordinate: CLLocationCoordinate2D(latitude: 65.2637, longitude: -14.3944),
                timeZoneIdentifier: "Atlantic/Reykjavik",
                country: "Iceland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Interlaken, Switzerland",
                coordinate: CLLocationCoordinate2D(latitude: 46.6863, longitude: 7.8632),
                timeZoneIdentifier: "Europe/Zurich",
                country: "Switzerland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Grindelwald, Switzerland",
                coordinate: CLLocationCoordinate2D(latitude: 46.6244, longitude: 8.0411),
                timeZoneIdentifier: "Europe/Zurich",
                country: "Switzerland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Verbier, Switzerland",
                coordinate: CLLocationCoordinate2D(latitude: 46.0964, longitude: 7.2283),
                timeZoneIdentifier: "Europe/Zurich",
                country: "Switzerland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Salzburg, Austria",
                coordinate: CLLocationCoordinate2D(latitude: 47.8095, longitude: 13.0550),
                timeZoneIdentifier: "Europe/Vienna",
                country: "Austria",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Kitzbühel, Austria",
                coordinate: CLLocationCoordinate2D(latitude: 47.4467, longitude: 12.3928),
                timeZoneIdentifier: "Europe/Vienna",
                country: "Austria",
                priority: 5
            )
        ],
        
        .foggy: [
            // Secondary foggy locations from Part 6
            GlobalWeatherLocation(name: "Portland, Oregon", coordinate: CLLocationCoordinate2D(latitude: 45.5152, longitude: -122.6784), timeZoneIdentifier: "America/Los_Angeles", country: "United States", priority: 8),
        GlobalWeatherLocation(name: "Vancouver, Canada", coordinate: CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207), timeZoneIdentifier: "America/Vancouver", country: "Canada", priority: 7),
        GlobalWeatherLocation(name: "Dublin, Ireland", coordinate: CLLocationCoordinate2D(latitude: 53.3498, longitude: -6.2603), timeZoneIdentifier: "Europe/Dublin", country: "Ireland", priority: 6),
        GlobalWeatherLocation(name: "Edinburgh, Scotland", coordinate: CLLocationCoordinate2D(latitude: 55.9533, longitude: -3.1883), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 5),
            GlobalWeatherLocation(
                name: "Bodega Bay, California",
                coordinate: CLLocationCoordinate2D(latitude: 38.3330, longitude: -123.0469),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Sausalito, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.8590, longitude: -122.4852),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Mill Valley, California",
                coordinate: CLLocationCoordinate2D(latitude: 37.9061, longitude: -122.5450),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Santa Cruz, California",
                coordinate: CLLocationCoordinate2D(latitude: 36.9741, longitude: -122.0308),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Carmel-by-the-Sea, California",
                coordinate: CLLocationCoordinate2D(latitude: 36.5553, longitude: -121.9233),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Big Sur, California",
                coordinate: CLLocationCoordinate2D(latitude: 36.2704, longitude: -121.8081),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Crescent City, California",
                coordinate: CLLocationCoordinate2D(latitude: 41.7558, longitude: -124.2026),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Astoria, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 46.1879, longitude: -123.8313),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Cannon Beach, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 45.8918, longitude: -123.9615),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Newport, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 44.6365, longitude: -124.0533),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Florence, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 43.9829, longitude: -124.1045),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Bandon, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 43.1193, longitude: -124.4087),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Brookings, Oregon",
                coordinate: CLLocationCoordinate2D(latitude: 42.0526, longitude: -124.2837),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Bellingham, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 48.7519, longitude: -122.4787),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Olympia, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 47.0379, longitude: -122.9015),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Port Angeles, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 48.1181, longitude: -123.4307),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "La Push, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 47.9037, longitude: -124.6351),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Westport, Washington",
                coordinate: CLLocationCoordinate2D(latitude: 46.8812, longitude: -124.1051),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Ucluelet, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 48.9367, longitude: -125.5433),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Bamfield, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 48.8356, longitude: -125.1356),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Port Alberni, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 49.2342, longitude: -124.8054),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Nanaimo, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 49.1659, longitude: -123.9401),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Victoria, British Columbia",
                coordinate: CLLocationCoordinate2D(latitude: 48.4284, longitude: -123.3656),
                timeZoneIdentifier: "America/Vancouver",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Fredericton, New Brunswick",
                coordinate: CLLocationCoordinate2D(latitude: 45.9636, longitude: -66.6431),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Moncton, New Brunswick",
                coordinate: CLLocationCoordinate2D(latitude: 46.0878, longitude: -64.7782),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Bathurst, New Brunswick",
                coordinate: CLLocationCoordinate2D(latitude: 47.6187, longitude: -65.6506),
                timeZoneIdentifier: "America/Halifax",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Corner Brook, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 48.9500, longitude: -57.9522),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Port aux Basques, Newfoundland",
                coordinate: CLLocationCoordinate2D(latitude: 47.5703, longitude: -59.1378),
                timeZoneIdentifier: "America/St_Johns",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Happy Valley-Goose Bay, Labrador",
                coordinate: CLLocationCoordinate2D(latitude: 53.3168, longitude: -60.4259),
                timeZoneIdentifier: "America/Goose_Bay",
                country: "Canada",
                priority: 5
            )
        ],
        
        .misty: [
GlobalWeatherLocation(name: "Yorkshire Dales, England", coordinate: CLLocationCoordinate2D(latitude: 54.3000, longitude: -2.0000), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 8),
        GlobalWeatherLocation(name: "Peak District, England", coordinate: CLLocationCoordinate2D(latitude: 53.3000, longitude: -1.8000), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 7),
        GlobalWeatherLocation(name: "Dartmoor, England", coordinate: CLLocationCoordinate2D(latitude: 50.5700, longitude: -3.9300), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 6),
        GlobalWeatherLocation(name: "Brecon Beacons, Wales", coordinate: CLLocationCoordinate2D(latitude: 51.8833, longitude: -3.4333), timeZoneIdentifier: "Europe/London", country: "United Kingdom", priority: 5),
            GlobalWeatherLocation(
                name: "Adirondack Mountains, New York",
                coordinate: CLLocationCoordinate2D(latitude: 44.0000, longitude: -74.0000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Green Mountains, Vermont",
                coordinate: CLLocationCoordinate2D(latitude: 44.0000, longitude: -72.8000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "White Mountains, New Hampshire",
                coordinate: CLLocationCoordinate2D(latitude: 44.2700, longitude: -71.3000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Catskill Mountains, New York",
                coordinate: CLLocationCoordinate2D(latitude: 42.0000, longitude: -74.3000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Finger Lakes, New York",
                coordinate: CLLocationCoordinate2D(latitude: 42.6000, longitude: -76.8000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Pocono Mountains, Pennsylvania",
                coordinate: CLLocationCoordinate2D(latitude: 41.1000, longitude: -75.3000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Ozark Mountains, Arkansas",
                coordinate: CLLocationCoordinate2D(latitude: 36.0000, longitude: -92.5000),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Ouachita Mountains, Arkansas",
                coordinate: CLLocationCoordinate2D(latitude: 34.7000, longitude: -94.0000),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Laurentian Mountains, Quebec",
                coordinate: CLLocationCoordinate2D(latitude: 46.0000, longitude: -74.0000),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Algonquin Park, Ontario",
                coordinate: CLLocationCoordinate2D(latitude: 45.5000, longitude: -78.0000),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Muskoka Region, Ontario",
                coordinate: CLLocationCoordinate2D(latitude: 45.0000, longitude: -79.5000),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Georgian Bay, Ontario",
                coordinate: CLLocationCoordinate2D(latitude: 45.3000, longitude: -80.2000),
                timeZoneIdentifier: "America/Toronto",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Snowdonia, Wales",
                coordinate: CLLocationCoordinate2D(latitude: 53.0000, longitude: -3.9000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Pembrokeshire Coast, Wales",
                coordinate: CLLocationCoordinate2D(latitude: 51.7000, longitude: -5.0000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Northumberland National Park, England",
                coordinate: CLLocationCoordinate2D(latitude: 55.3000, longitude: -2.0000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Exmoor, England",
                coordinate: CLLocationCoordinate2D(latitude: 51.1000, longitude: -3.7000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Forest of Bowland, England",
                coordinate: CLLocationCoordinate2D(latitude: 53.9000, longitude: -2.5000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Pennines, England",
                coordinate: CLLocationCoordinate2D(latitude: 54.5000, longitude: -2.0000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Trossachs, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 56.2500, longitude: -4.3000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Loch Lomond, Scotland",
                coordinate: CLLocationCoordinate2D(latitude: 56.1000, longitude: -4.6000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Sperrin Mountains, Northern Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 54.7000, longitude: -7.0000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Mourne Mountains, Northern Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 54.1700, longitude: -6.0000),
                timeZoneIdentifier: "Europe/London",
                country: "United Kingdom",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Burren, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 53.0000, longitude: -9.0000),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Connemara, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 53.5000, longitude: -9.7000),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Donegal Highlands, Ireland",
                coordinate: CLLocationCoordinate2D(latitude: 54.8000, longitude: -8.0000),
                timeZoneIdentifier: "Europe/Dublin",
                country: "Ireland",
                priority: 5
            )
            
        ],
        
        .breezy: [
             GlobalWeatherLocation(name: "Boston, Massachusetts", coordinate: CLLocationCoordinate2D(latitude: 42.3601, longitude: -71.0589), timeZoneIdentifier: "America/New_York", country: "United States", priority: 8),
        GlobalWeatherLocation(name: "Miami, Florida", coordinate: CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918), timeZoneIdentifier: "America/New_York", country: "United States", priority: 7),
        GlobalWeatherLocation(name: "Copenhagen, Denmark", coordinate: CLLocationCoordinate2D(latitude: 55.6761, longitude: 12.5683), timeZoneIdentifier: "Europe/Copenhagen", country: "Denmark", priority: 6),
        GlobalWeatherLocation(name: "Dublin, Ireland", coordinate: CLLocationCoordinate2D(latitude: 53.3498, longitude: -6.2603), timeZoneIdentifier: "Europe/Dublin", country: "Ireland", priority: 5),
            GlobalWeatherLocation(
                name: "Galveston, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 29.3013, longitude: -94.7977),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "South Padre Island, Texas",
                coordinate: CLLocationCoordinate2D(latitude: 26.0739, longitude: -97.1631),
                timeZoneIdentifier: "America/Chicago",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Key West, Florida",
                coordinate: CLLocationCoordinate2D(latitude: 25.7617, longitude: -81.8018),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Cape Hatteras, North Carolina",
                coordinate: CLLocationCoordinate2D(latitude: 35.2079, longitude: -75.6274),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Outer Banks, North Carolina",
                coordinate: CLLocationCoordinate2D(latitude: 35.5000, longitude: -75.5000),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Nantucket, Massachusetts",
                coordinate: CLLocationCoordinate2D(latitude: 41.2835, longitude: -70.0995),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Martha's Vineyard, Massachusetts",
                coordinate: CLLocationCoordinate2D(latitude: 41.3811, longitude: -70.6109),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Block Island, Rhode Island",
                coordinate: CLLocationCoordinate2D(latitude: 41.1677, longitude: -71.5826),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Montauk Point, New York",
                coordinate: CLLocationCoordinate2D(latitude: 41.0717, longitude: -71.8571),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Cape Cod, Massachusetts",
                coordinate: CLLocationCoordinate2D(latitude: 41.6688, longitude: -70.2962),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 7
            ),
            GlobalWeatherLocation(
                name: "Myrtle Beach, South Carolina",
                coordinate: CLLocationCoordinate2D(latitude: 33.6891, longitude: -78.8867),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Virginia Beach, Virginia",
                coordinate: CLLocationCoordinate2D(latitude: 36.8529, longitude: -75.9780),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Ocean City, Maryland",
                coordinate: CLLocationCoordinate2D(latitude: 38.3365, longitude: -75.0849),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Atlantic City, New Jersey",
                coordinate: CLLocationCoordinate2D(latitude: 39.3643, longitude: -74.4229),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Long Beach Island, New Jersey",
                coordinate: CLLocationCoordinate2D(latitude: 39.6426, longitude: -74.1932),
                timeZoneIdentifier: "America/New_York",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Santa Barbara, California",
                coordinate: CLLocationCoordinate2D(latitude: 34.4208, longitude: -119.6982),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Ventura, California",
                coordinate: CLLocationCoordinate2D(latitude: 34.2747, longitude: -119.2287),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Morro Bay, California",
                coordinate: CLLocationCoordinate2D(latitude: 35.3658, longitude: -120.8493),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Pismo Beach, California",
                coordinate: CLLocationCoordinate2D(latitude: 35.1428, longitude: -120.6413),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "San Luis Obispo, California",
                coordinate: CLLocationCoordinate2D(latitude: 35.2828, longitude: -120.6596),
                timeZoneIdentifier: "America/Los_Angeles",
                country: "United States",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Regina, Saskatchewan",
                coordinate: CLLocationCoordinate2D(latitude: 50.4452, longitude: -104.6189),
                timeZoneIdentifier: "America/Regina",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Saskatoon, Saskatchewan",
                coordinate: CLLocationCoordinate2D(latitude: 52.1332, longitude: -106.6700),
                timeZoneIdentifier: "America/Regina",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Swift Current, Saskatchewan",
                coordinate: CLLocationCoordinate2D(latitude: 50.2881, longitude: -107.7943),
                timeZoneIdentifier: "America/Regina",
                country: "Canada",
                priority: 6
            ),
            GlobalWeatherLocation(
                name: "Brandon, Manitoba",
                coordinate: CLLocationCoordinate2D(latitude: 49.8481, longitude: -99.9308),
                timeZoneIdentifier: "America/Winnipeg",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Portage la Prairie, Manitoba",
                coordinate: CLLocationCoordinate2D(latitude: 49.9731, longitude: -98.2914),
                timeZoneIdentifier: "America/Winnipeg",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "North Battleford, Saskatchewan",
                coordinate: CLLocationCoordinate2D(latitude: 52.7575, longitude: -108.2862),
                timeZoneIdentifier: "America/Regina",
                country: "Canada",
                priority: 5
            ),
            GlobalWeatherLocation(
                name: "Yorkton, Saskatchewan",
                coordinate: CLLocationCoordinate2D(latitude: 51.2139, longitude: -102.4628),
                timeZoneIdentifier: "America/Regina",
                country: "Canada",
                priority: 5
            )
        ]
    ]
    
    // MARK: - Location Search Types

    enum LocationTier {
        case primary
        case secondary
        case fallback
        case all
    }

    enum SearchStrategy {
        case priorityFirst
        case geographicSpread
        case comprehensive
    }

    // MARK: - Core Methods

    /// Get locations for a specific weather vibe with tier selection
    func getLocations(for vibe: WeatherVibe, tier: LocationTier = .all) -> [GlobalWeatherLocation] {
        switch tier {
        case .primary:
            return priorityLocations[vibe] ?? []
        case .secondary:
            return secondaryLocations[vibe] ?? []
        case .fallback:
            return fallbackLocations[vibe] ?? []
        case .all:
            let primary = priorityLocations[vibe] ?? []
            let secondary = secondaryLocations[vibe] ?? []
            return (primary + secondary).sorted { $0.priority > $1.priority }
        }
    }
    
    /// Gets priority locations for a specific weather vibe
    func getPriorityLocations(for vibe: WeatherVibe) -> [GlobalWeatherLocation] {
        return priorityLocations[vibe] ?? []
    }
    
    /// Gets secondary locations for a specific weather vibe
    func getSecondaryLocations(for vibe: WeatherVibe) -> [GlobalWeatherLocation] {
        return secondaryLocations[vibe] ?? []
    }
    
    /// Gets all locations for a specific weather vibe (priority + secondary)
    func getAllLocations(for vibe: WeatherVibe) -> [GlobalWeatherLocation] {
        let priority = getPriorityLocations(for: vibe)
        let secondary = getSecondaryLocations(for: vibe)
        return priority + secondary
    }
    
    /// Gets locations by search tier
    func getLocationsByTier(_ tier: SearchTier, for vibe: WeatherVibe) -> [GlobalWeatherLocation] {
        switch tier {
        case .primary:
            return getPriorityLocations(for: vibe)
        case .secondary:
            return getSecondaryLocations(for: vibe)
        }
    }
    
    /// Gets a random location for a specific weather vibe
    func getRandomLocation(for vibe: WeatherVibe) -> GlobalWeatherLocation? {
        let allLocations = getAllLocations(for: vibe)
        return allLocations.randomElement()
    }
}

/// Search tier enumeration for organized location searching
enum SearchTier: CaseIterable {
    case primary
    case secondary
    
    var displayName: String {
        switch self {
        case .primary:
            return "Primary"
        case .secondary:
            return "Secondary"
        }
    }
}
