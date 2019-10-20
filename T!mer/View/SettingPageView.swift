import SwiftUI

struct settingRow: View {
    
    var title: String
    
    var body: some View {
        Text("\(title)")
    }
}

struct settingRowWithToggle: View {
    
    @State private var showGreeting = true
    
    var body: some View {
        
        VStack {
            Toggle(isOn: $showGreeting) {
                Text("Alert when timer is done")
            }
        }
    }
}

struct SettingPageView: View {
    var body: some View {
        VStack {
            List {
                Section {
                    settingRowWithToggle()
                    NavigationLink(destination: Text("Hello, World!")) {
                        settingRow(title: "playing sound when timer is done")
                        
                    }
                }
            }.listStyle(GroupedListStyle())
        }.navigationBarTitle(Text("Settings"), displayMode: .inline)
    }
}

struct SettingPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingPageView()
    }
}
