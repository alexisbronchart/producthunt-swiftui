import SwiftUI

private enum WindowBoundsKey: EnvironmentKey {
#if os(iOS)
    static var defaultValue = UIApplication.shared.topWindow?.bounds.size ?? .zero
#else
    static var defaultValue = NSApplication.shared.mainWindow?.contentView?.bounds.size ?? .zero
#endif
}

extension EnvironmentValues {
    public var windowBounds: CGSize {
        get { self[WindowBoundsKey.self] }
        set { self[WindowBoundsKey.self] = newValue }
    }
}

extension View {
    public func provideScreenBounds() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let insets = proxy.safeAreaInsets
            environment(\.windowBounds, .init(
                width: size.width + insets.leading + insets.trailing,
                height: size.height + insets.top + insets.bottom
            ))
        }
    }
}

#if os(iOS)
extension UIApplication {
    public var topWindow: UIWindow? {
        guard let scene = connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = scene.windows.first(where: \.isKeyWindow) else {
            return nil
        }

        return window
    }
}
#endif
