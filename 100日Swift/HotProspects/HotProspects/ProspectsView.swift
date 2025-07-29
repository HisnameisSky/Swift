//
//  ProspectsView.swift
//  HotProspects
//
//  Created by 澄界 on 2025/07/29.
//

import SwiftUI
import SwiftData
import UserNotifications
import CodeScanner

//[].()
struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    var filterType: FilterType
    var title: String {
        switch filterType {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }
    @Environment(\.modelContext) var modelContext
    @Query var prospects: [Prospect]
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State private var isShowingEditProspectView = false
    @State private var sortOrder = [SortDescriptor(\Prospect.name), SortDescriptor(\Prospect.emailAddress)]
    
    
    var body: some View {
        
        NavigationStack {
            List(prospects, selection: $selectedProspects) { prospect in
                NavigationLink(destination: EditProspectView(prospect: prospect, name: prospect.name, emailAdress: prospect.emailAddress, isContacted: prospect.isContacted)) {
                    HStack {
                        if filterType == .none {
                            if prospect.isContacted == true {
                                Image(systemName: "person.crop.circle.badge.checkmark")
                            } else {
                                Image(systemName: "person.crop.circle.badge.questionmark")
                            }
                        }
                        VStack(alignment: .leading) {                        Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                //スワイプ動作の機能
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospect)
                    }
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                    }
                    Button("Remind me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                //並び替えの機能
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\Prospect.name),
                                    SortDescriptor(\Prospect.emailAddress)
                                ])
                            Text("Sort by email")
                                .tag([
                                    SortDescriptor(\Prospect.emailAddress),
                                    SortDescriptor(\Prospect.name)
                                ])
                        }
                    }
                }
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: deleteProspects)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
        }
        //並び替えが変更された場合の通知
        .onChange(of: sortOrder) {
            print("sort order changed")
        }
    }
    init(filterType: FilterType) {
        print("init")
        self.filterType = filterType
        if filterType != .none {
            let isContatedOnly = filterType == .contacted
            _prospects = Query(filter: #Predicate<Prospect> {
                $0.isContacted == isContatedOnly
            }, sort: sortOrder)
        } else {
            _prospects = Query(sort: sortOrder)
        }
    }
    //スキャン機能の設定
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        //結果の種類とそれにての対応
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    //削除
    func deleteProspects() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    //通知
    func addNotification(for prospect: Prospect) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "It's time for contact to \(prospect.name)"
            content.sound = .default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            //            var dateComponents = DateComponents()
            //            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            notificationCenter.add(request)
        }
        
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filterType: .contacted)
}
