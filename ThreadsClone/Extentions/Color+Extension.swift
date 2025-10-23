import SwiftUI

// Define a struct for the color theme to make it more organized and scalable.
struct ColorTheme {
    let accent = Color("AppAccent")
    let background = Color("AppBackground")
    let primaryText = Color("AppPrimaryText")
    let secondaryText = Color("AppSecondaryText")
}

// Create a static extension on Color to easily access the theme throughout the app.
extension Color {
    static let theme = ColorTheme()
}