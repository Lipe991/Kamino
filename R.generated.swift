//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `HeaderColor`.
    static let headerColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "HeaderColor")
    
    /// `UIColor(named: "HeaderColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func headerColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.headerColor, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `back`.
    static let back = Rswift.ImageResource(bundle: R.hostingBundle, name: "back")
    /// Image `close-ico`.
    static let closeIco = Rswift.ImageResource(bundle: R.hostingBundle, name: "close-ico")
    /// Image `error`.
    static let error = Rswift.ImageResource(bundle: R.hostingBundle, name: "error")
    /// Image `user-avatar`.
    static let userAvatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "user-avatar")
    
    /// `UIImage(named: "back", bundle: ..., traitCollection: ...)`
    static func back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.back, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "close-ico", bundle: ..., traitCollection: ...)`
    static func closeIco(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.closeIco, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "error", bundle: ..., traitCollection: ...)`
    static func error(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.error, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "user-avatar", bundle: ..., traitCollection: ...)`
    static func userAvatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.userAvatar, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 23 localization keys.
    struct localizable {
      /// Value: Birth year
      static let resident_birth_year_localization = Rswift.StringResource(key: "resident_birth_year_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Climate
      static let home_climate_localization = Rswift.StringResource(key: "home_climate_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Diameter
      static let home_diameter_localization = Rswift.StringResource(key: "home_diameter_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Eye color
      static let resident_eye_color_localization = Rswift.StringResource(key: "resident_eye_color_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Gender
      static let resident_gender_localization = Rswift.StringResource(key: "resident_gender_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Gravity
      static let home_gravity_localization = Rswift.StringResource(key: "home_gravity_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Hair color
      static let resident_hair_color_localization = Rswift.StringResource(key: "resident_hair_color_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Height
      static let resident_height_localization = Rswift.StringResource(key: "resident_height_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Homeworld
      static let home_homeworld_localization = Rswift.StringResource(key: "home_homeworld_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Image can not be shown
      static let image_error = Rswift.StringResource(key: "image_error", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Like failed
      static let home_like_error_title = Rswift.StringResource(key: "home_like_error_title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Likes: %d
      static let home_like_count = Rswift.StringResource(key: "home_like_count", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Mass
      static let resident_mass_localization = Rswift.StringResource(key: "resident_mass_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Name
      static let resident_name_localization = Rswift.StringResource(key: "resident_name_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Orbital period
      static let home_orbital_period_localization = Rswift.StringResource(key: "home_orbital_period_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Please try again in a few moments!
      static let home_like_error_text = Rswift.StringResource(key: "home_like_error_text", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Population
      static let home_population_localization = Rswift.StringResource(key: "home_population_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Residents: %d
      static let home_residents_count = Rswift.StringResource(key: "home_residents_count", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Rotation period
      static let home_rotation_period_localization = Rswift.StringResource(key: "home_rotation_period_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Skin color
      static let resident_skin_color_localization = Rswift.StringResource(key: "resident_skin_color_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Something went wrong...
      static let error_text = Rswift.StringResource(key: "error_text", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Surface water
      static let home_surface_water_localization = Rswift.StringResource(key: "home_surface_water_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Terrain
      static let home_terrain_localization = Rswift.StringResource(key: "home_terrain_localization", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: Birth year
      static func resident_birth_year_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_birth_year_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Climate
      static func home_climate_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_climate_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Diameter
      static func home_diameter_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_diameter_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Eye color
      static func resident_eye_color_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_eye_color_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Gender
      static func resident_gender_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_gender_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Gravity
      static func home_gravity_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_gravity_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Hair color
      static func resident_hair_color_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_hair_color_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Height
      static func resident_height_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_height_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Homeworld
      static func home_homeworld_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_homeworld_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Image can not be shown
      static func image_error(_: Void = ()) -> String {
        return NSLocalizedString("image_error", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Like failed
      static func home_like_error_title(_: Void = ()) -> String {
        return NSLocalizedString("home_like_error_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Likes: %d
      static func home_like_count(_ value1: Int) -> String {
        return String(format: NSLocalizedString("home_like_count", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Mass
      static func resident_mass_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_mass_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Name
      static func resident_name_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_name_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Orbital period
      static func home_orbital_period_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_orbital_period_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Please try again in a few moments!
      static func home_like_error_text(_: Void = ()) -> String {
        return NSLocalizedString("home_like_error_text", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Population
      static func home_population_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_population_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Residents: %d
      static func home_residents_count(_ value1: Int) -> String {
        return String(format: NSLocalizedString("home_residents_count", bundle: R.hostingBundle, comment: ""), locale: R.applicationLocale, value1)
      }
      
      /// Value: Rotation period
      static func home_rotation_period_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_rotation_period_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Skin color
      static func resident_skin_color_localization(_: Void = ()) -> String {
        return NSLocalizedString("resident_skin_color_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Something went wrong...
      static func error_text(_: Void = ()) -> String {
        return NSLocalizedString("error_text", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Surface water
      static func home_surface_water_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_surface_water_localization", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Terrain
      static func home_terrain_localization(_: Void = ()) -> String {
        return NSLocalizedString("home_terrain_localization", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
