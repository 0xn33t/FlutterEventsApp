//
//  EventWidget.swift
//  EventWidget
//
//  Created by Mustafa on 03/11/1442 AH.
//  Github:: https://github.com/0xn33t
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> EventDataEntry {
        EventDataEntry(date: Date(), eventData: nil, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (EventDataEntry) -> ()) {
        let eventData = EventData(title: "Meeting with Mustafa", start: Date())
        let entry = EventDataEntry(date: Date(), eventData: eventData, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [EventDataEntry] = []
                
        let sharedDefaults = UserDefaults.init(suiteName: "group.com.events")
        var eventData: EventData? = nil
        
        if(sharedDefaults != nil) {
            do {
              let shared = sharedDefaults?.string(forKey: "eventData")
                
              if(shared != nil){
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let events = try decoder.decode([EventData].self, from: shared!.data(using: .utf8)!)
                
                if !events.isEmpty{
                    print(events)
                    let sortedEvents = events.sorted(by: {$0.start.compare($1.start) == .orderedAscending})
                    let now = Date().getLocalDate(timezone: TimeZone(secondsFromGMT: 0))
                    let filteredEvents = sortedEvents.filter {
                        return $0.start >= now
                    }
                    if !filteredEvents.isEmpty{
                        eventData = filteredEvents.first
                    }
                }
              }
            } catch {
              print(error)
            }
        }
                
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        let entry = EventDataEntry(date: entryDate, eventData: eventData, configuration: configuration)
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct EventData: Decodable, Hashable {
    let title: String
    let start: Date
    
    func getEventDate() -> String {
        return start.getFormattedDate(format: "MMM dd,yyyy", timezone: TimeZone(secondsFromGMT: 0))
    }
    
    func getEventTime() -> String {
        return start.getFormattedDate(format: "hh:mm a", timezone: TimeZone(secondsFromGMT: 0))
    }
}

struct EventDataEntry: TimelineEntry {
    let date: Date
    let eventData: EventData?
    let configuration: ConfigurationIntent
}

struct EventWidgetEntryView : View {
    var entry: Provider.Entry

    private var eventResultsView: some View {
        VStack(alignment: .leading, spacing: 0){
            VStack(alignment: .leading){
                Text("Upcoming").font(.caption)
                Text("Event").font(.largeTitle).fontWeight(.semibold)
            }.frame(maxWidth: .infinity, alignment: .topLeading).padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15)).background(Color.yellow.opacity(0.6))
            VStack(alignment: .leading){
                Text(entry.eventData!.title).font(.system(size: 12)).lineLimit(2).fixedSize(horizontal: false, vertical: true)
                Spacer().frame(height: 6)
                Text(entry.eventData!.getEventDate()).fontWeight(.bold).font(.system(size: 15))
                Text(entry.eventData!.getEventTime()).fontWeight(.regular).font(.system(size: 12))
            }.padding(EdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 15))
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private var noResultsView: some View {
        Text("There is no upcoming events").multilineTextAlignment(.center).font(.system(size: 12)).padding()
    }
    
    var body: some View {
        if(entry.eventData != nil){
            eventResultsView
        }else{
            noResultsView
        }
    }
}

@main
struct EventWidget: Widget {
    let kind: String = "EventWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            EventWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Events Widget")
        .description("Display your upcoming event")
        .supportedFamilies([.systemSmall])
    }
}

struct EventWidget_Previews: PreviewProvider {
    static var previews: some View {
        let demoEvent: EventData = EventData(title: "Meeting with Mustafa", start: Date())
        return EventWidgetEntryView(entry: EventDataEntry(date: Date(), eventData: demoEvent, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


extension Date {
    func getFormattedDate(format: String, timezone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        if((timezone) != nil){
            dateFormatter.timeZone = timezone
        }
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getLocalDate(timezone: TimeZone? = nil) -> Date {
        let dateString = self.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if((timezone) != nil){
            dateFormatter.timeZone = timezone
        }
        return dateFormatter.date(from: dateString) ?? self
    }
}
