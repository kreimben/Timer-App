import SwiftUI

struct TodoContentView: View {
    
    @State var title: String
    @State var date: Date
    @State var memo: String?
    
    var convertedDate: String {
        
        let format = DateFormatter()
        format.timeStyle = .medium
        format.dateStyle = .long
        
        return format.string(from: self.date)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(self.title).font(.system(size: 24))
            Text(convertedDate).foregroundColor(.gray)
            Text(self.memo ?? "").foregroundColor(.gray)
        }
    }
}

//class DisplayDate {
//
//    var year: String
//    var month: String
//    var day: String
//    var hour: String
//    var minute: String
//    var second: String
//
//    init(
//        year: String,
//        month: String,
//        day: String,
//        hour: String,
//        minute: String,
//        second: String
//    ) {
//
//        self.year = year
//        self.month = month
//        self.day = day
//        self.hour = hour
//        self.minute = minute
//        self.second = second
//    }
//
//    func print() -> String {
//
//        return "\(year)-\(month)-\(day) \(hour):\(minute):\(second)"
//    }
//}

//struct TodoContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoContentView()
//    }
//}

//
//  TodoContentView.swift
//  T!mer
//
//  Created by Aksidion Kreimben on 7/16/20.
//  Copyright © 2020 Aksidion Kreimben. All rights reserved.
//
