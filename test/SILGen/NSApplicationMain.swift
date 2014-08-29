// RUN: rm -rf %t/clang-module-cache
// RUN: %swift -emit-NSApplicationMain -emit-silgen -parse-as-library -module-cache-path %t/clang-module-cache -target x86_64-apple-macosx10.9 -sdk %S/Inputs -I %S/Inputs -enable-source-import %s | FileCheck %s
// RUN: %swift -emit-NSApplicationMain -emit-ir -parse-as-library -module-cache-path %t/clang-module-cache -target x86_64-apple-macosx10.9 -sdk %S/Inputs -I %S/Inputs -enable-source-import %s | FileCheck %s -check-prefix=IR

import Foundation
import AppKit

// CHECK-LABEL: sil private @top_level_code
// CHECK:         function_ref @NSApplicationMain
// IR-LABEL: define internal void @top_level_code
// IR:            call i32 @NSApplicationMain

// Ensure that we coexist with normal references to the functions we
// implicitly reference in the synthesized main.
func bar() {
  NSApplicationMain(C_ARGC, C_ARGV)
}
