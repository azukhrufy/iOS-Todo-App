//
//  ThemeSettings.swift
//  ToDo App
//
//  Created by mac on 08/04/22.
//

import SwiftUI

//MARK: - THEME SETTING

final public class ThemeSettings : ObservableObject {
    @Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme"){
        didSet{
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    
    private init() {}
    public static let shared = ThemeSettings()
}
