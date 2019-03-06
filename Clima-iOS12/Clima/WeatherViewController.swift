import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    @IBOutlet weak var faren: UISwitch!
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    var APP_ID : String {
        
        var resourceFileDirectory: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") {
            resourceFileDirectory = NSDictionary(contentsOfFile: path)
        }
        
        guard let resource = resourceFileDirectory else {
            fatalError("There is no resource in Secrets.plist")
        }
        
        let apiID = resource.object(forKey: "APP_ID") as! String
        
        return apiID
        
    }
    
    var service_KEY : String {
        
        var resourceFileDirectory : NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") {
            resourceFileDirectory = NSDictionary(contentsOfFile: path)
        }
        
        guard let resource = resourceFileDirectory else {
            fatalError("There is no resource in Secrets.plist")
        }
        
        let serviceKey = resource.object(forKey: "ServiceKey") as! String
        
        return serviceKey
        
    }
    
    lazy var measuringPlace_URL = "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList?&ServiceKey=\(service_KEY)"
    
    lazy var fineDust_URL = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?&ServiceKey=\(service_KEY)&ver=1.3"
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if sender.isOn {
            
        }
    }
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var fineDustStatusLabel: UILabel!
    @IBOutlet var fineDustEmojiLabel: UILabel!
    @IBOutlet var fineDustConLabel: UILabel!
    
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                //                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                
                //                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    
    func getMeasuringPlaceData(url: String, parameters: [String:String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                //                print("Sucess! Got the measuring data")
                
                let measuringPlaceData: JSON = JSON(response.result.value!)
                
                //                print(measuringPlaceData)
                
                if let stationName = measuringPlaceData["list"][0]["stationName"].string {
                    
                    
                    let params : [String: String] = [
                        "stationName" : stationName,
                        "dataTerm": "month",
                        "pageNo": "1",
                        "numOfRows": "10",
                        "_returnType": "json"
                    ]
                    
                    self.getFindDustData(url: self.fineDust_URL, parameters: params)
                }
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
        
    }
    
    
    func getFindDustData(url: String, parameters: [String: String]) {
        
        Alamofire.request(fineDust_URL, method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                print("Success! Got the fine dust data!")
                let fineDustData: JSON = JSON(response.result.value!)
                
                print(fineDustData)
                
                self.updateFineDustUI(with: fineDustData)
                
            }
            
        }
        
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    
    
    //Write the updateWeatherData method here:
    
    
    func updateWeatherData(json : JSON) {
        
        let tempResult = json["main"]["temp"].doubleValue
        
        weatherDataModel.temperature = Int(tempResult - 273.15)
        
        weatherDataModel.city = json["name"].stringValue
        
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        
        updateUIWithWeatherData()
    }
    
    
    //        else {
    //            cityLabel.text = "Weather Unavailable"
    //        }
    //    }
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    func updateFineDustUI(with fineDustData: JSON) {
        
        let pm10Grade1h = fineDustData["list"][0]["pm10Grade1h"].stringValue
        
        switch pm10Grade1h {
        case "1":
            fineDustStatusLabel.text = "좋음"
            fineDustEmojiLabel.text = "😍"
        case "2":
            fineDustStatusLabel.text = "보통"
            fineDustEmojiLabel.text = "😀"
        case "3":
            fineDustStatusLabel.text = "나쁨"
            fineDustEmojiLabel.text = "😡"
        case "4":
            fineDustStatusLabel.text = "매우 나쁨"
            fineDustEmojiLabel.text = "☠️"
        default:
            fineDustStatusLabel.text = "정보 없음"
            fineDustEmojiLabel.text = ""
        }
        
        let pm10Value = fineDustData["list"][0]["pm10Value"].stringValue
        
        fineDustConLabel.text = "\(pm10Value)㎍/㎥"
        
    }
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil
            
            //            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            coordinationToTM(longitude: Double(longitude)!, latitude: Double(latitude)!)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    
    func userEnteredANewCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
        
    }
    
    
    //Write the PrepareForSegue Method here
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            
            destinationVC.delegate = self
            
        }
        
    }
    
    //MARK: - GeoConverter Method
    
    func coordinationToTM(longitude: Double, latitude: Double) {
        
        let converter = GeoConverter()
        let geoPoint = GeographicPoint(longitude: longitude, latitude: latitude)
        
        if let tmPoint = converter.convert(sourceType: .WGS_84, destinationType: .TM, geoPoint: geoPoint) {
            
            let tmX = String(tmPoint.x)
            let tmY = String(tmPoint.y)
            
            let params : [String: String] = [
                "tmX": tmX,
                "tmY": tmY,
                "_returnType": "json"
                
            ]
            
            getMeasuringPlaceData(url: measuringPlace_URL, parameters: params)
            
        }
    }
    
    //MARK: -
    
    
    
    
    
    
    
    
}











