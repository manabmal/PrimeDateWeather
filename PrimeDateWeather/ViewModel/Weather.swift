//
//  Weather.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 19/07/21.
//

import Foundation

class Weather{
    
    func getHistoryWeather(latLon: String, date: Date, returnResult: @escaping ((Day) -> Void)){
        let strDate = date.toString(format: "yyyy-MM-dd")
        let url = BaseUrl.apiURL + APIEndpoints.history + "?key=" + Token.apiToken + "&q=" + latLon + "&dt=" + strDate
        print("URL called: ",url)
        guard let urlToSend = URL(string: url) else{return}
        URLSession.shared.dataTask(with: urlToSend) { data, response, error in
          guard let data = data, error == nil else { return }
            do{
                let decoder = JSONDecoder()
                let historyWeather = try decoder.decode(HistoryWeather.self, from: data)
                //dump(historyWeather)
                //historyWeather.forecast.forecastday[0].day
                guard let forecast = historyWeather.forecast, let day = forecast.forecastday, let index0 = day[0].day else {return}
                returnResult(index0)
            }
            catch
            {
                //Need handle error properly
                print(error)
            }
        }.resume()
    }
    
    func getForeCastWeather(latLon: String, date: Date, returnResult: @escaping ((Day) -> Void)){
        
        let strDate = date.toString(format: "yyyy-MM-dd")
        let url = BaseUrl.apiURL + APIEndpoints.forecast + "?key=" + Token.apiToken + "&q=" + latLon + "&days=10&aqi=no&alerts=no"
        print("URL called: ",url)
        guard let urlToSend = URL(string: url) else{return}
        URLSession.shared.dataTask(with: urlToSend) { data, response, error in
          guard let data = data, error == nil else { return }
            do{
                let decoder = JSONDecoder()
                let futureWeather = try decoder.decode(ForecastWeather.self, from: data)
                //dump(futureWeather)
                //print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))

                guard let forecast = futureWeather.forecast, let forecastDays = forecast.forecastday else {return}
                for forecastOneDay in forecastDays
                {
                    if forecastOneDay.date == strDate, let totalDay = forecastOneDay.day
                    {
                        returnResult(totalDay)
                        break
                    }
                }
            }
            catch
            {
                //Need handle error properly
                print(error)
            }
            
        }.resume()
    }
    
    
}
