module Test_yumversionlock =

let conf = "1:package-1-1.*
package2-1-1.*
0:java-1.6.0-oracle-1.6.0.33-puzzle.5.el5.centos.*
0:java-1.6.0-oracle-devel-1.6.0.33-puzzle.6.el6.*
"

test YumVersionlock.lns get conf =
  { "package"
    { "epoch" = "1" }
    { "version" = "1-1" } }
  { "package2"
    { "version" = "1-1" } }
  { "java-1.6.0-oracle"
    { "epoch" = "0" }
    { "version" = "1.6.0.33-puzzle.5.el5.centos" } }
  { "java-1.6.0-oracle-devel"
    { "epoch" = "0" }
    { "version" = "1.6.0.33-puzzle.6.el6" } }
