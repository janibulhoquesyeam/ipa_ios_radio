import Foundation
import Flutter
import AVKit

class AirPlayViewFactory: NSObject, FlutterPlatformViewFactory {
  private var messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func create(
    withFrame frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    return AirPlayView(frame: frame)
  }
}

class AirPlayView: NSObject, FlutterPlatformView {
  private let _view: AVRoutePickerView

  init(frame: CGRect) {
    _view = AVRoutePickerView(frame: frame)
    _view.activeTintColor = .systemBlue
    _view.tintColor = .darkGray
    _view.prioritizesVideoDevices = false
    super.init()
  }

  func view() -> UIView {
    return _view
  }
}
