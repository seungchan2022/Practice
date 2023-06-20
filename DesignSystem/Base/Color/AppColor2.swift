import SwiftUI

public enum AppColor2 {}

extension AppColor2 {
  public enum Background {
    public static let base = Color("BgBase2", bundle: BundleToken2.bundle)
    public static let base2 = Color("BgBase3", bundle: BundleToken2.bundle)
  }
}

extension AppColor2 {
  public enum Label {
    public static let base = Color("LbBase2", bundle: BundleToken2.bundle)
  }
}

extension AppColor2 {
  public enum Tint {
    public static let primary = Color("TtPrimary2", bundle: BundleToken2.bundle)
    public static let secondary = Color("TtSecondary2", bundle: BundleToken2.bundle)
  }
}
