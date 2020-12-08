//
//  ChangesViewModel.swift
//  ScreensPart2
//
//  Created by Xiongwei Zheng on 08.12.20.
//

import Foundation

class ChangesViewModel: ObservableObject {
    @Published var allChanges: [changeModel] = [
        changeModel(label: "Architektur mobiler Anwendung", docent: "Prof. Dr. Stöhr", reason: "", group: "", originalTime: "14:00 - 15:00", originalDate: "13.10.2020", originalRoom: "FB004B", alternativeTime: "14:00 - 15:30", alternativeDate: "20.10.2020", alternativeRoom: "FB004B"),
        changeModel(label: "Robotik", docent: "Prof. Dr. Groth", reason: "entfällt", group: "", originalTime: "14:00 - 15:30", originalDate: "14.10.2020", originalRoom: "virt.cgroth", alternativeTime: "", alternativeDate: "", alternativeRoom: "")
    ]
    
    func fetchData(){
    }
}
