//
//  LocationManager.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    // MARK: - Singleton Instance
    static let shared = LocationManager()
    
    // MARK: - Properties
    private var locationManager: CLLocationManager
    private var locationHandler: ((Result<CLLocation, Error>) -> Void)?
    private var addressHandler: ((Result<String, Error>) -> Void)?
    private let geocoder = CLGeocoder()
    
    // MARK: - Initializer
    private override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
    }
    
    // MARK: - Public Methods
    func requestLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        self.locationHandler = completion
        
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            completion(.failure(LocationError.accessDenied))
        @unknown default:
            completion(.failure(LocationError.unknown))
        }
    }
    
//    func requestAddress(completion: @escaping (Result<String, Error>) -> Void) {
//        self.requestLocation { [weak self] result in
//            switch result {
//            case .success(let location):
//                self?.reverseGeocode(location: location, completion: completion)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    // MARK: - Reverse Geocoding
     func reverseGeocode(location: CLLocation, completion: @escaping (Result<String, Error>) -> Void) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(.failure(LocationError.noAddressFound))
                return
            }
            
            // Construct the address
            let address = [
                placemark.name,
                placemark.locality,
                placemark.administrativeArea,
                placemark.country
            ].compactMap { $0 }.joined(separator: ", ")
            
            completion(.success(address))
        }
    }
    
    // MARK: - CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            locationHandler?(.failure(LocationError.noLocationFound))
            return
        }
        locationHandler?(.success(location))
        locationManager.stopUpdatingLocation()
        locationHandler = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationHandler?(.failure(error))
        locationHandler = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if let handler = locationHandler {
                requestLocation(completion: handler)
            }
        case .denied, .restricted:
            locationHandler?(.failure(LocationError.accessDenied))
            locationHandler = nil
        default:
            break
        }
    }
}

// MARK: - Custom Error Enum
enum LocationError: LocalizedError {
    case accessDenied
    case noLocationFound
    case noAddressFound
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return "Access was denied! Please enable location services in Settings."
        case .noLocationFound:
            return "Unable to find location."
        case .noAddressFound:
            return "Unable to find address."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
