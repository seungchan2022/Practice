import SwiftUI

public enum AppColor {}


extension AppColor {
  public enum Background {
    public static let base = Color("BgBase", bundle: BundleToken.bundle)
  }
}

extension AppColor {
  public enum Label {
    public static let base = Color("LbBase", bundle: BundleToken.bundle)
  }
}

extension AppColor {
  public enum Tint {
    public static let primary = Color("TtPrimary", bundle: BundleToken.bundle)
    public static let secondary = Color("TtSecondary", bundle: BundleToken.bundle)
  }
}
