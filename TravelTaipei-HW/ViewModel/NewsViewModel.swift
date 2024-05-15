//
//  NewsViewModel.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/11.
//

import Foundation
import UIKit

class NewsViewModel {
    
    private let eventsService: EventsAPIServiceProtocol
    
    var newsData: DynamicValue<[NewsModel]> = DynamicValue([])
    var activityData: DynamicValue<[EventActivityModel]> = DynamicValue([])
    var calendarData: DynamicValue<[EventCalendarModel]> = DynamicValue([])
    
    var errorMessage: DynamicValue<String?> = DynamicValue(nil)
    
    init(eventsService: EventsAPIServiceProtocol = EventsAPIService(apiServices: NetworkServices())) {
        self.eventsService = eventsService
    }
    
    func getNews(begin: String?, end: String?, page: Int?) {
        eventsService.fetchNewsData(begin: begin, end: end, page: page,
                                    modelType: BaseModel<NewsModel>.self) { [weak self] result in
            switch result {
            case .success(let baseModel):
                self?.newsData.value = baseModel.data
            case .failure(let error):
                print("Error fetching news: \(error.localizedDescription)")
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getActivity(begin: String?, end: String?, page: Int?) {
        eventsService.fetchActivityData(begin: begin, end: end, page: page,
                                        modelType: BaseModel<EventActivityModel>.self) { [weak self] result in
            switch result {
            case .success(let baseModel):
                self?.activityData.value = baseModel.data
            case .failure(let error):
                print("Error fetching news: \(error.localizedDescription)")
                self?.errorMessage.value = "Error fetching news: \(error.localizedDescription)"
            }
        }
    }
    
    func getCalendar(categoryId: Int?, begin: String?, end: String?, page: Int?) {
        eventsService.fetchCalendarData(categoryId: categoryId, begin: begin, end: end, page: page,
                                        modelType: BaseModel<EventCalendarModel>.self) { [weak self] result in
            switch result {
            case .success(let baseModel):
                self?.calendarData.value = baseModel.data
                print("calendarData", baseModel.data)
            case .failure(let error):
                print("Error fetching news: \(error.localizedDescription)")
                self?.errorMessage.value = "Error fetching news: \(error.localizedDescription)"
            }
        }
    }
}
