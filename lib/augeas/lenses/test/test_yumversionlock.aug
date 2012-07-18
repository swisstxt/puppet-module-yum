module Test_yumversionlock =

let conf = "1:package-1-1
"

test YumVersionlock.lns get conf =
  { "package"
    { "epoch" = "1" }
    { "version" = "1-1" }
  }
