import AVKit
import Flutter
import UIKit

final class AudioRoutePickerFactory: NSObject, FlutterPlatformViewFactory {
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        AudioRoutePickerPlatformView(frame: frame)
    }
}

final class AudioRoutePickerPlatformView: NSObject, FlutterPlatformView {
    private let picker: AVRoutePickerView

    init(frame: CGRect) {
        picker = AVRoutePickerView(frame: frame)
        picker.tintColor = .white
        picker.activeTintColor = .systemBlue
        picker.prioritizesVideoDevices = false
        super.init()
    }

    func view() -> UIView {
        picker
    }
}
