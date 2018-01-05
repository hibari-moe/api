# Package

version       = "0.1.0"
author        = "James Harris"
description   = "Backend for the Hibari client for Kitsu.io"
license       = "MIT"
bin           = @["hibari"]

# Deps
requires "nim >= 0.17.2"
requires "jester >= 0.2.0"
requires "sam >= 0.1.4"

task run, "Compiles and runs debug version":
  exec "nim c -r hibari"
