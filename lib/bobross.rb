require "bobross/version"
require "forgery"
require "models/account"
require "models/assignment_grade"
require "models/assignment_group"
require "models/assignment_submission"
require "models/assignment"
require "models/course"
require "models/group_in_account"
require "models/group_in_course"
require "models/section"
require "models/user"
require "active_support/time"

module Bobross
  class Error < StandardError; end

puts %q{###zznnnnnnnnnnnnnnnnnnznznxxnnxnnnnnnnxxnxxxznxnz:,,,,,,,,,,,,,:::::::::;;;;;::,,,:;:;;;;;::,,,,,,..................................`````````````````
znnnnnnnnnnnnnnnnnxxxxxxnxxMMxxxxxxMxxxxxxMxMxMMxn:,,,,,,,,,::;;;;ii;ii**+*******i;ii***+++*i;::::,,,..................................```````````````
xxxxxxxxxxxxxxxxxxxxMMxMxMMMMMxxxxxxxxxxxxxnnnzzz#;::;;:;::;;;i:i*ii*+*+###+#+#++*+*+#++*+++***i;;;;::,,.............................`````````````````
nnnzzzzzzzz############+++#####+*++##+#+++++*i*i**#+++******i*ii****+###########+++######++##+#*iiii*;::,,,.........................``````````````````
ii*ii*i*ii*ii*iii****ii**+zzzzz+**++++++++++++++++++***++++++*+**++#zz####zzz#++++++z###########++**++**i;::,,......................``````````````````
i***+++#####++++*++************************+++++++++**+##+++*+##*+#zzzz#znz####+#zzzzzzzzz####z#+##z##++**i;i:,,..................````````````````````
;;;;;ii********+++++++++******************+++++++++*+##zz####+++##zzzzzzznnzzzzz#znnnnnnnnnnznnzzzzz#z#++#++**;:,:..............``````````````````````
;;;;;ii***++++####+++++++++**************++++++****+#zzzzzzz##+##znnzzzzznzzzznnnnnnxxnxxxxnnnnzzznnz####++*i*iii;:............`.`````````````````````
:;;;;i**+++#########+++++++**************++++*****#zznznnnzzzzzzzzznzzzzzzzznnnnxnnxxxxxxxxxnnnnnnnnnzzzz##*i*ii*;;::,.........`..````````````````````
:;;;i***+#############+++++*********************+#zznnnnnnnzzzznzznzznnnnnnnnnxnxnxxxxxMMxxxxxnnnxnnnnnzzz##+**i*i*ii;:,.......`..````````````````````
;;;;i***+##############++++*****************ii*++zznnnxnnnznnnnnnznnnxxnnnnnnnxxxxxxxxMMMMMMMxxxxxxxxnnznnnz#z#++****i;;,,.....``.````````````````````
;;;iii**+###############+++*******ii******+*+##zznnnnnnxnnnxnnnnnnnnnxxxxxnxxxxxMxMMMMWWMWMMMxxxxxxxxxnznnxxnnzz+**+**i*i;,.....``````````````````````
;;;;ii*+###############+++*****iiiiii***+++#zzznnnnnnnxxxxxxnnxxxxnxxxxMxxxxxxMMMMMWMMMMWWWMMxMxxxxxMMxxnnxxxnnnzzz###**i;;;,...`.````````````````````
;;;;i**++############++++*****iiiiiii***###zzzznnxnxxxxxMMMxMxMMxxxxMMxMxxMMMMWWMMWWWWWWWMMWWMxxxMxMMMMxnnxxxxxxnzzzz#+*ii:;;:....````````````````````
;;;ii*+++###########++++*****iiiiiii**++znnnzzznnnxxxxxxMxMMWWMMxMMMMMMMMMWW@W@@@@@MMWMWWWWWWWMMMMMMMMMMMxxxxxxxnnnzzzz+++i;;::...````````````````````
;;ii**++###########+++++****iiiiiiii*+#zznnnnnnxxxxMxxMxxMMMMMMMMMWWMWWWWW@W@@@@@@@@W@WWMW@@WWMWWWWMWWWMMxxxxxxnxnnnzz#z##++;::,.`.```````````````````
;;i**++############++++****iiiiiii**##z#nznnxnnxxMMMMMMMMMWWMMMWWWWWWWW@@@@@@@###@W@W@WWWW@@@WWWWWWMMMMMMMMMMMMxxxxnzzzz#++*i::,..````````````````````
;ii**++#########++++++****iiiiiii*+#zzzznxxxxnxxMMWWMMMWWWWWMWWMWW@W@@W@@@###@##@###@W@@WW@@@WWW@WWMMWMMWWWMMMMxxnnnnzzzzz#++*i::...``````````````````
iii**++#######++++++*****iiiiii**++#zznzxxxxxxxMMWWMWWM@WWW@MWMWMW@W@@WMW@@##########@WWW@#@WW@W@@WWWWWWWWWWWMxMxxnnnnnnnn###+*i;,,.``````````````````
iii***++######+++*******iiiiii*++++#zznnxxxxxxMMWWMWWWWWW@@WWWWWWW@@@@@WW@@#############W##WWW@@@@@WWWWWWWWWWMMMMxxxnnnnzzzzz++*;;:..`````````````````
i*****+++###+++******iiiiiiii*+###zzznnxxnxMMMWMMMWWMWW@@W@W@WW@@@##@@WW@@@####@########W##@W@@@@@@WWW@WWWWWWWWMMxxxxnnnnzz###+ii;:,.`````````````````
i*****+++++++**iiiiiiiiii;;i*zz#zznxnnnnxMMMMMMMMMMMWWW@@@@W#@@@@W@#@@@@@WW@##@#########@##@@@#@@@#@@@@@@WWWWWWMMMMMxnxnnnzz#++*i;::,..```````````````
ii***++++++**iiiii;;;;;;;;i*+zzzzznnnnxxxMMMMMMWMMxMW@@W@W@W@@@#@@@@@@@@@WW#@####@##########@@####@@@@#@@@@WWWWWMMMMxxxxxn##z#++**i:,...``````````````
ii***++++*****iiiiii;;;;;i**##zzznznnnnxMMMMMMMMMMxWW@@W@M@@W@#@@####@@@@W@@###@@@############@###@WWWW@@##@@WWWWMMMMxxxxnznzzz#++*;:,..``````````````
ii**++++++++****iiii;;;ii**#zzzznnnnxxxxMMxxMWMWMWWWWW@W@#@@@@#@@#@###@@@W@@####@@###@@###########@@@@W@#@#@@WWWWWWMMMMMMxxnnzzz##+i;:,.``````````````
i**++++++++*****iiiiiiiii*#zzzznnnnnnxxxMMMxMWWWWWWM@@W@@@@@@@@@##@@####@W@######@###@W@#####@#@##@#@#@@###@@@@WWWWMMMWMMMMxnnnzz#++*;:,.`````````````
i**+++++++++****iiiiiiii*#nnznnnxnnnnxMMxMMM@@WW@WMWW@@#@@#@WWWW@##@@#@#@W@#@@@@#@##@@@@@#@@#@W@#@###@@@###@@@@@WWWWWMMWMMMxxnnz#+++*;:;,`````````````
i**++++++++++***iiiii;i*+zzznxxnnnnnxxMMMMWW@@WW@WW@@W@@WW@@@@@@W@@@@@@@@@W@@@##@@#####@@####@@@#@###@@@##@@@@@@@@WWWWWWWMMxxxxzz##+*i:::.````````````
i**+++++++*****iiiiiiii+##znnnxxnnnxxxMMxMWWWW@W@@W@W@@#@@####@#@W@@@@@#@@@@#@##########@######@W@####@@#@@@@@W@#@@WWWWWWWMxxxxxnz##*ii;;,.```````````
i**+++++++*****iiiiiii*+##znnnxxxxnxxxxxMWWWW@@#@#@@#############@@#@W#@@#@W@###############@##@@@####@@@W@@@@WW@@WWWWWWWWMMxxxxnzzzz+*i;,..``````````
i**+++++++****iiiiiii*#+#zznnxxxxxnxxMMMW@W@@@@@##################@##@#@@##@@###################@@##@W#@WWW@W@@@@@@@@@W@WWMMMxxxxnz##++ii;,.``````````
i***+++++++***iiiiiii+###znnnxxxxxxMMWMWW@@@##@@#################@@@##@@####@@#########@##@@@@##@@@##@@@#@W@@@W@@@@@@@@@WWMMMMxxxnnz#++ii;,.``````````
i***++++++****iiiiii+##z#znznnxxxMMxMMMW@@#############@@#############@####@#@##############@W@@@#@#@@W@##@#@@WW@@@@@@@@@WWMMMxxnnzz#+**;:,,..````````
i***++++++****iiiii**+#zzznnnnxnxxxMMWMW@@###@@@########@#########@####@###@@@@##@########@@#@##@@W#@#@@#@@#@@WW@@#@##@@WWWWMMMnnnnzz#+*;:,:,.````````
****++++++****iiiii****zznnnnznxxxxMMMM@@@@@@@#@###@####@@#######@@####@#####@@@###########@@@####@#######@@@WWW@@@@###@W@WWWMMxxxnnzzz#*:;::,.```````
***++++++****iiiiii*++#zznnnxnnxxMMMxxMW@##@@@####@@@###@@#####@#@###@#@###@@@@##############W@#########@W@@#W@W@@@@@@##@@WWMWMMxxxnnnzz+***;:.```````
****+++*****iiiiiii*#zzzznxxxxxxMMMxMxMW@@@W#############@###@@@@@@#@W@###############@#@###############@W@@@@@W@@@@@@##@WWWWWMMxxxxxnzz++*ii;,.``````
i****+*******iiiii*+##nnnnxxxxxxMMxxMMMW@@#@@@#####@##@##@####@@@@@@@W@@##@####@####@##@#@@###############@@@@@@W@@@@@@#@@@WWWMMMMxxnznz#***;::.``````
************iiiiii*++znnnnnxxxxxMxxMMM@@@WWWM@####@W#@@#######@@##@@#@W@#@@#@@@@@########@W@###############@@@@@W@W@##@#@@@@WWWWMMMxxnzz#*++;::,.`````
i**********iiiiiii*++zznnxnxxMMMMWxMWW#@@@WW@###@@@W@W@#######@@@@WW@@W@@WW@@W@@@@######@@W@@@#######@#####@@##@@@@@##@##@@@WWWWMMMMxxnn###*i;;;,`````
ii******iiiiiii*ii*++zznnnxMxMMMxxxM@W@##@W@@#####@W@W@@#@#@@@W#@@WM@@WWWWWWWW@W@@@#####@W@@@##@@@##@@#####@W@@@@#@######@@@WWWWWWMMxxxnzzz+i;;::`````
ii******iiiiiiiiii*+#zzznnxMMWWMWxxMWM@@@W@@#####W@WWW@@@W@@@MWW@WMMWWWWWMMWWWWWW@@@####@W@@@@@@@@#@@@@@##@@@@@##########@@@@W@WWWWMMxxxnnn++i;;,.````
iiiiiiiiiiiiiiiii**zzznnnxMMWWWMWMMMWW@@@W@#@@#@@@WMWW@@MWW@@WMMWMMMMMMMMMMMMxWW@@@@#@@#@W@#@@WWWW@@@@@@@#W@#@###@@###@##@@@@WWWWWMMMxxxxnnz+**;:..```
iiiiiiii;;ii;;iii**znnnxxxMMMWWMMMM@@@@@@@@@@@@@@WWMWW@WxWWWWMMMMxxMMMMMMMMMMMWWWW@W@@@@@WW#@@@@WW@WW@@#@@W@@@@###@###@@@@@@@@@WWWWMMMxxxnzz#++i:..```
iiiiiii;;;;;::;iii#znxxxxMMxMWWWMWWWWWWWW@#@@@@WWWWxMMWMMWMMMMMMxMxMxxMMMMMMMMWWW@WW@@#@MW@W@##@@@@WW@@@@@W@#@@#########@W@@@@WWWWMMMMxxnnnnz#*i:,.```
iiiiiii;::::::;i*+#znnxxxMMWWWMMMWMMW@M@@@@@@W@@WWMMMWWWWMMMMMMMMMMxMMMMMMMMMMWWMWW@W@@@WWWW@#@@@@WWWW@@@@@@#@##########@@@@@W@@WMMMMMxxnnnnz+*i:,.```
iiiiii;:,,,::;i*+##znnxxxMMMWWWWMMMMWWM@@@@@W@W@@WMMMWWWWMMMMMMxxxMxMMMMxMMMMMMWMWW@@@@@@WMW@@@#@WWWWWW@@@@@#@@@@@@##@@@@@@@@W@@WMMMMMMxxnnnn#*i;,````
iiii;;:,,,,::;*++#zzznxnxxMMW@MMWMWWMMW@@WWWWWWWWWMMMMMMMMMMMxMMMxxMMMMMxxMMMxMWMMWWW@#@@MWW@@@@WWW@@@W@@@@@#@###@@@@@@@@@@@@WWWWWMWMMxxxxnnn#+i;,````
ii;;::,,,,::;i*##zzznxnxxMMWW@WMWWWWWWWW@@MWWWMMMMMMMxMxxxxxxxMxxxxMMMxMMxxMMxMWMMMWWW@WWWWMWWWWWMWWW@@@@@@@##@###@###@@@#@@@WWWWWWWMMxxxxxnz++i:.````
i;;::,,,,:::;i+##zznnnxxxMMMW@WMWWWWWWWW@WWWWMWMMxMMMxxxxxxxxxMxxxxMxMxMMxxMMMMMMMMWMW@WWWMMWWWWWWWWWWWW@@@@#@@###@@##@#W@@@@@WWWWWMMxxxnxnnz#+i::.```
;;;::::::::;***+##znnnxxMMMMWW@WWWWWM@@WMMWWMWWMMxMMxxnnxxxxxxxxxxxxxxxxxxxxMMMMMWMMWWWWMMMMMMWMMWWWWWW@@WW@@@@@##@##@@#@@WW@@@WWWMMMxxxxxnnnz+*i;.```
;;;::::::::;***++zzzznxxMMWxMWW@@@WMW@@WMMMMxMMMxxMxxxnnnnnxxxnznxxnxnxxxxxxxxxMMMWMMWWMMMMMMMMMMWWWWWWWW@@@#@#@######@@@@W@@WW@WWMMMxxxnnnnnzz+*;,.``
;;;;:::::::;**i++zzznxxxxMMxMMW@@WWM@@@@WWWMMMMMMxxxxxxxnnnxxnnnnnxnnnxxxMxxxxxMMMWMMWMMMMMMMMMMWWWWWWWWW@@@##########@@@@@@WWWWWWWMMMxxxnnnz##+i:,.``
;;;;::,,:::;***+#zzzznnxxMxxMWW@@@W@#@@@@@WMMMxMxxxxxnnnnnnnxxxnnnnnnnnxxxxxxxMMMMMMMMMMMMMMMMMMWWWWWWMWWW@###@#@####@#@@@@@@@WWWWMMMxxxxxnnz##+;:.```
;;;;:,,:::::;i+#zzzzznnnxMMxMWWW@@W@@@MWWxMWWMxxxxxxxnznnnznxxxnznnnnzznxxxxxxMxMMMMMMMMMMxxxMMMMMWWMWMMWWW@##@####@@@@@@@@W@@WWWMMMMxxxxxnnz#+*;:.```
::::,,,:::::;i+#znnnnxxnxMMMMM@WWMWWW@WMMMMMMMxxxxxxnnzznnznnxxnznnnnnnnnxxxxMMxxMMMMMMMMMxxMMMMMMMMMMMMWWW@@####@@##@@@@@@@W@WWWMMMMxxxxxxnnz+i;:.```
:::,,,,:::::;*+#zzz#znnnxxxMMM@WMWxMMMMMMMWMMMxxxxxnnnnnnnnzzznnnnxnnznnnxxMxMxxxxxxxxMMMMxxxxMxxMMMMMMMWWW@@@#@####@@#@@W@WWW@WWMMMMMMMxxxnnz#i;:.```
::,,,,::::::;i*#zzznnxxxxxxMMMMWWMxxxxxMMMWMMMxxxnnnzznnzzzzzzznnnnnnnzznnxxxxxxxxxxxxMMMxxxxxxxxxMMMMMMWWW@@###@@##@@##@W@WWWWWWWWMMMMxxxxnnz#+i:.```
:,,,,:::::::;;*##znnxxnxxxMWMMMMMMxMxxxxxMMMMMMxxnnnzznz####zzznnnnznzznnxxxxxxxxxnxxMxMMxxxxxxxxMMMMMMMWMWW@@@######@##@@@W@WWWWWWWMMMxxxnnnz##*,.```
:,,,,:::::::;;*+znnnnnnxxMMWxMMMMMMMMnxMxMMMMxMxnnnzzznz######znnnnznnnnnnxxxnnxxnnxxxxxxxxxxxxMMMxMMMMMMMWW@@@@#@@##@@@@WWWWWWWWWWWMMMxxxxnzzz+*:.```
:,::::::::::;;*+#znnnnxnxMMWMMxMMWMWWxxMMMMxxMMxnnnzzzzzz#####znnnnzznzznzznnnznnnxxxxxxxxxxxxxMMMxxxxMMMMMM@@##@@@@#@@@@W@WW@WWWWWWMMMMxnxnzz#+i,.```
::::::::::::;i*++#znnnxxxxMWMWMMWWWWMMxMxxMxxxxxxzzzzz#####+##zznnnnnzzzzzzznnzznnnnnxxxxnnnxxxxxxxxMxxMMMMMW@###@@@##@@#@@WWWWWMWWWMMMMMxxnnz#+i,.```
::::::::::::;i*++z#zznnxMMMWWWWMWMWMMMnxxxxxxxxxxzzzzz#######znznnnzznzzznnnnnzzznnnnxxxxnnnnnnnnxxxxxxMMMMWW@@@#@@@@@@W@@WWWWWWWWWWWMMMxxnnn###i,````
::::::::::::;i*+#zzznnxxMWMMWMWMWMWWMMxxxMMxMMxxnzzzz###+++##zzzzzzzzzzzzznnnnzzzzznnxxxxnnnnnnnnnnxxxxxxMMWW@###@@@@@@WW@@WWWMWWMWWWMMMxxxnnz#+i,.```
::::::::::::;i++#zznxxxxxMMxWMWWWWMMWWMMMMMnMxMxnnzz###++###########zzzzzznnnnzzzzznnnxMxnzznnznnnnxxxxxxxMMW@##@@#@@W@@W@@WWWWWWWWWWMMMMxxxnnz+i:.```
::::::::::::;i*+#zznnxxxxxMMMMW@WWMxWWWxMMxxxxxxxnzz##+++##+#+#++++#zz##zznnnnzzzzzznnxxnzzzzzznnnnxMMMxxxMMWW@@####@@@@@@@WWWWWWWWWWMMMMxxxnnz#*;.```
::::::::::::;i*+##znnxxMMxxMWMM@WWMMMMMMMxxxxxxxnnz###+*+###+++*++++z###zzznnnnzzzzznnnnzzzznznnxxxMMMMMMMMMMW@@###@#@@@W@@@@WWWWWWMMMMMMxxxnnz#+i,```
::::::::::::;i*zz#znnnxMMxnMWMW@WWWMMWMWMMxxxxxxnz###++*+##++++++++#######zzznnzzzzzzzzzzznnxxxMMW@@@@WWWMMMMW@@@#@@@@@WWWWWWWWWMWWWMMMMxxxxnnz#+i:.``
:;::::i*;::::i*zz#zznnxxxMxMWMMWWWWWMWWWMMxxxxxnz##+#++++#+++++*+#####++++#zznz###zzzzzzznxxWWWWW@@@@@@WWWWMWWW@W@#@WW@W@@@@WWWMWWMMWMMMMxxxnnnz#i,.``
;;;;ii++++*;;**#zzznnnnxxMMWWWWMWMMWWW@@WMxxxxxnz###+*+++++++#++#####+++++##zzn#++#zzznnxxMMWWWW@W@WWWMMMWWWWWWWW@#@WW@@@WW@MWWWMWWWWMMMMxxxnnzz#i:.``
;;;::+zz++*+ii*#zzzznnnxxWWMWW@WMMMMMMW@@MMMMxnnz##++*++++##+##zzzz##++++*++#zn#++#nnnnnxxMMMMMMMxxxxxxxMMMMMWWWWW@WWW@@WWWW@WWWMWWWMMMMMxxxnnzz#;:.``
;;;;::#nz+***i+zzznnnxxxxMMWMWWMMMMMWWWWWWMMMxxxz##++**##znznnnxxMMxzz#++*++#zn#*+#nxnnxxxxxnnnzzzzznnnnxxxMMMMMWWMWWW@@WW@MWWWMMWWMWMMMxxxxnnzz+::.``
i;;:i;:+zz+**i+znnzznnnxMxMMMWWWxWMMMWWWW@WMMxxnzz#+*++#nnnxxxMxxxxxz####+++#zn#*+#nxxnnnxnnzz#####zzznznxxMMMMMMWWWWWW@@@WMWWWMMMMMMMMMxxxnnnz#*;:.``
;;::;+;,;++#*i+zzzznznnxxMxMWWW@MMMWWWWW@WMMMMxxz##**#znnxxxxxxnnz#####+#+**+#nz++znxxnnxnnnnzzzzzznnzzzznxxxMMMWWWMW@W@@@@WMWWWMMMMMMMMxxxnnnz#i;.``
:::::*+,,:;*+i*#znnnnnnxxxMMMMMWWWWW@@MWWWMWMMxxz#+*+#nxxnzz#######+++**++***+zz##znxxxxxxMxxWW@WWWxnxxnnnnxxxxMWMMMMWWW@W@WMWWWMMMMMMMxxxnnnzz+;:.``
:::::;*i,,::;**#nnnnnxxxxxMMMMxMMWWWWWWW@WMMMMMnz#++#zz#+**i***+#zzz#+****ii*++###znnnnxMMMMWx#@xMMxMxxMxnnxxxxMMMMWWMMW@@WWMWWWMWWMMMMMxxnnnz#*:,.``
:::;::i#*:,,:;*+zznnnnnxxxMMMMWxMWWWWWMxMWWMWMMnz###z#++iii**#zxxxxnxn#+**iiii++##znnnxMWMWMMM@#WMMxMMMMxnnxxxxMMMWWWWWWWWWWWWWWWMMMMMMxxxnnz#+;::.`
;i;*;;;*#*,,,:*+zzznnxnxxxxMMxMMWM@@WWWWMMWMMMxnz##+**i;ii+#zxMM@@MMnnnz#i;;;i*+##znnxxMMWWMxWWWWMxnnnnxxxxxxxxMMMWWWWWMWMWWMMMMWMMMMMxxxxxnz#*i:,``
*ii++ii*+*;,,:i#zzznxxxxxxxMMxMMMWWWWWWWMMWMMMxzz#*iii;ii+zzn#zz@@xxnxn##+;;;;**#zznnxMxMWMMxnnzzzzzzznxxxxnnxxxxMMWMWMWMWWWWWMMWWMMMMxxxxnnz#*i.```
iii*ii****;,,:*+zzznnxxxxxxMMxMMMWWWWMWMMMMMMMxz##*i;;i*#nzn#izxWMxnnnnz*+i;;;i*+#znnxMMMMMxnz#####zznnnnnnxxxxxxMMWWWW@WWWMWWWWMMMWMMMxxnnz#+*:````
;;iiii*+**i;,:**#zzznxxxxxxMMMxMMWMWMMMWMMMWMMxz#+i;;;;*zz+****#z###zzz#+*i;;;i*+#znnnxMMMMMnz####zznnnnnnnnnnnxxMMWWWW@@WWWWWWWMMMMMMMxxnz#+*:.````
;;i;ii***iii*:;i#z#znxMxxxMMMMMMMWMMMxMWMMWWMMxz+*;:;;i*#ii;;;;**++#####+*;;;:;*+#nnnnxxxMMMxnzzzzzzzzznxxnnnnnnnxxMWW@WWWWWWWWMMMMMMMxxxnz++*;,.```
i;;iiiiiiii**::i+z#znnnxxxMxMMMMMMMMMMMMMWWWWMx#+i;:::i+*;::::;i**+#z##+*i;;;:;*+#znnnnnxxxxxxnnzzzzznnnnnnxnnnnnxMMWWW@WWWWWWWMMMMMMMxxxnz++i:,.```
;;iiiii****i;,,i*##zzznxxxxxxMMMMMxMMMMMWWMMWMn#+i;;;;;;;;;:::;**++###+*ii;;;;;*+#znnnnnnxnnnnnnnnnnnznnnnnnnnnnnnxMWW@WWWWWWWWMMMMMMMxxxnz++*;,````
iiiiii+z#**;::,;*#zzznnnxxxxxxMMMMMMMMMMMWMMMMx#*i;;::;i;;::;;i**+++++ii;;;;;;;i+#znnnnnnxxnnnnnzzz###zznnnnnznnnnxMWWWWWWWWWWWMMMMMMxxxnnz#+ii:````
iii*iii*iii;;:::*+#znnnnnnxxxxxMWMMMMMWMMMMMWWx#*i;:::;;;ii;iiiii****i;;;;iii;ii+#znnnnnnxxnnnnnzzz####zzznnnzzznnxMMWWWWWWWMWWMMMMMMxxnnnz#+ii:.`
**iii***ii*ii:;i*+#zznxnnnxxxxxMMMMMMxMMMMMMMMx#*;;:;;;;i***iii**i**ii;;iiiiiii*+znnnnnnnnxnnnnzzz#######zzzznnzznxMWWWWMMWMMMMMMMMMxxxnnz#++*;,.`
**iiiii*;iii*i;*++#znnnnnnxxxxxxMMMMMMMMMMMMMMxz*i;;;:;iii*******iiii;iiiiiiiii*+#znnnnnnnnnnnnzzz#######zzzznnzznxMMWWMMMMMMMMMMxxxxxxnnz#+*ii,.`
i*+**+**ii*i**ii+++#zzznnnnxxxxxMMMMxMMMMxMWWMxz*i;;:;;;iii***+**iiiiiiiiiiiiiii*#znnnnzzzzznzzzz########zzzzzznznxMMMWMMxMMMMMMMMMxxxnzzz#++*;,``
*+****ii*****ii;i*+**##znnnnxxxxMMMMMMMMMMMWMMxz*;;;;:::;;iii***iii;;;;;;;iiiii**#znnnnzznnnnnzzzz#######zzzzzznnznxMMMMMxxxxxxMMMMxxxnzzzz++*,.``
++i++*i+**+++ii;i*+++#znzznnxnxxxxMMMMMMMMMWWxxzi;;;;::::;;ii**iiii;:::::;;ii;i**+#znnnnnnnxxnnzzz########zzzzznnznxMMMMxxnnxMxMMxMxxnnnzzz#+i;.``
***+*+*z#+++++*ii*+*+#zznnnnxxxxxxxxMMMMWMWWWMx#i;;;;;:::;iiiiiiiiiiiii;;;;;;;ii*+#znnnnxxnnxxxnnz########zzzzzzznnxxMMxxnnnxMMxMxxxnnnnzz#**;,.`
**++*+*zz****+***i;i;+##nnxnxxnnnnxMMMMMMMWWMMxzi;;;;;:::;iiiiiiii****;;;;;;;;;ii+#znnnxxxnnnxxxnnzz#######zzzzzznnnxMxxxnnxWWMMxxxnnnnz##+**:.``
*******z#ii****ii;;;;*+znnxnnxxxxxxxxMMMMMMMMMx#i;;;;;::::;;iii***+++;;ii;;i;;;ii+#zznnnxnnznnxxxnnzz#####zzzzzzznznxMMxxnxWWWMMMMxzznnzz##+i:.``
*ii**iinz;****i;;;;;;*#nnnxxnxxxxxxMxxMMMMMMMMx#i;;;;;::,,:;;i**++##*;;iiiiiii;ii*+#zzznnnzzznnxxxnnzz####zzzzzzzzznxMMMxMWWWWMMMxxxnnzz##+*;.``
*ii*i*zMx*+*iii;:::;:;#znnxxxnxxxMxMxxMMMMMxMMx#i;;;;;;,..,;;i*++###*;;ii;;;;;;ii*+#zzzzzzzzznnxMxxnnzz###zzzzzzznnnxMMWW@@WWMMMMxxnnzz#*i*i;.``
iiiiii#nx+*iiiiiii:::;+znnnnnnnxnMxxxxMMMxMxxxx#i;;;;;:,..:;i*++#zz#*;::::::::,;***+#zzzzzzzzznnxMxxnnzzzzzzzzzzzzznxMMWW@@WWWMMMxnnnnz#*iii;.``
i;;;i*nMM+i;;;;iii;;;i+zznnnnnxxxxMMxxMMxMMMxnx#i;;;;;::,,;ii*##znn#*;:::::;::,;*++#zzzzznnnzzznnxMMxnzzzzzzzzzzzzznxMWMWWWWWWMMMxxnnnz#+*iii.``
;;;i+i*nxz*;;;;iiiii*+##znnnnxnxnxxxxxMMxMMMxnn#i;;;;;::::;i*+#znnz*ii;;;;;;;;;i*+##zznnxxnzznnnnnxMxnnzz#zzzzzznznnxMWMMWWWWWWMMxnnzzz+**ii:.`
;;i**izMMMzi;;;;;i**++###zznnnnnxxxxxxMMxznnxnn#i;;;;;;;:;i*+#znnz+i;;;iiiiiiii*+##znxMxxnnnnnnnnnxxMxnzzzzzzzzznznnxMMMWWWWWWWMxxnz#z##i;;;,.`
;;i***nxxz*ii;;;;ii**+*+#zzznnnnxxxxxxxxxz#znnzzi;;;;;;;;;i+#znnn#*;;::;;;i*+#++##znMMMxMxxxnnnnxxxxxMxxnzzzzzznnznnxMMWWWWWWMMxxxnz##*+i:::,``
*iii#xxMMnx+i;;;i+*i*+**+#znznnxxxxxxxxxxn##zzzzi;;;;;;;;i*+#znn#*i;;;;i**++#znzzzznxnxxxxxxxnnxxxxxxxxMxnzzzzznnznxxMMMMWWWMMMxxxnnzz++iii::``
iiii#nxxxxM+;;;;+#+****##zznzznnxxxxxxxxxMnzzzz#i;;;;;;;ii*+#nnn+iiiiiii###zzznnznznnnnnnnxxxxxxxMMxMMxMWxnzzzznnznxMMMWWMWWMWMxnnnnz#++i;::,``
ii;ii*nWWMx*;;;iz#+++++##zzznnnnnxxxxxxxxxxxzzzn*;;;;;;;ii*#znxz+****+*+zzznnzxxznnnnnnnnnnnxxxxxMMMMMMxWMxnnzznnnnxMMMWWM@WMMMxxnnzz#+**:,.```
**iii+xnzWMn*;;+z+++++##zxnnnnnnnnnnxxxxxxxMMxxn+i;;;;;;i*+#nxn#*++++#*#nznxnzxxnznnnnznnnznxxxxMMMMMMMxMWxnzzzxxnnnMMMWMMWWMMMMnnn#++*ii;.```
+++ii#znnMnz+*i###+#++#n##znnnnnnnnnxxxxxxxxxxxn#i;;;;;ii*#zxxz+++++##+#nznxnnxxxnznznnnnxnnnxxxxxMWMMMMMMxnzzzxxnnxMMMMMMMMMMMxnnz#++*i;:```
+##ii#nxWWxzz#+###++++#z##znnnnnznnnnnxxxxxxxxnnzii;;;;ii+zxMn#####+#+#znznxnxnxxnnznnnnnxxzxxxnxxMWMMMMMMxzzzzxxnxxMMMMMMMxxxxxn###++**,.```
+##*#nxnnxxxMn#z##+#+++###zznnnznnnnnnxxxxxxnxnnn+i;i;;i*+nMxzzz#z##+*zzzznnxxxxxnzzzznznnMnnxxM@W@@WWxMMxnzzznxxnxxMMMMMMMxxxxnnz##*+i,````
#+z#nnMnnnnnMMz#z###++##zzzznnnznnnnnnxxxxxxxxnnn#iiii;i*#nxnzzz#zz##+##zzznnnnnnz#znnnnznxxnxW@@@WMWWxxMxnzzzxxxxxMMMMMMMMxxxnnzz+i+*,`````
##zzznWMWMxxMMn##+##++###zznnnnznzznnnnnnnnxnnxnnz*iii;i*#nxzzzznnznnznzz##zzzzzzzznnnnnznnnnxW@WMMxMMxxxxnnnnMxnxxMMxMMMMxxxxnz+;::;.``````
#z#zzzxWMWxxnxn#+++++###zznzzzzxnzznnnnnnnnnnnxnnn+i**;i*+nnzzznnxxMWWn#+*+ii+*i*+#**+n##nnzxM@MMMxxMxxnxnnnnxMxnxMMMMMMMxnnnzz#;:,,.``````
z##z#zxMxMMMzzz#+++++nz#znzzzzxxzzzzznxnxxxnnxxxxn#***ii*+#zz#znzznxMWx+*;i;:i;:;i+;i*z##nnnWWMMxxxxMxxzxxnnxMMxxxMMMMxMMzz+****,.``````````
###z#nMMxMxnz++++++##nz##nzzz#nnxnnzznnnnnnnnnxnnzz+***i*+##z#nnz##zznx+*;;:,;::;i+ii*+##xxxMMxxnnnxxnxnnxnnxMxxxMMMMMMMx##+ii:,````````````
+++zxxWMxMnzn##+++++#nz+#zzzzzznxxnnnnxnnnnnznnnnnn#+**i**+##znnz#++++##zi;*:;;:;i+i**#nnxxxxxnnnnnxxxxxznnxxMxxxMMMMMMxnz++*;.```````````
+++nMxWxxxnxMMn#++++#xn++##zzzzxxnnnznnnnnnnnnnxnnzz#*+*i*+##nnnzz#+iii*+++z+**i*#zzzznnnnnnnnnnnnnxxxxnnnxnxxxxxMMMMMMnn#++;``````````````
++#nMMnxxxMMMMxMxz+*#xnz+#z#zzznxnnnxnnnnnnnnnnxnnzn#+++**+##znzzz#*i;;;;i****++#zzzz#zzzz#zznnnnnnxxxnxnnnxxxxxMMMMMMxnz#++*.`````````````
++nMxznxMWMxWMMMMx+*#xxn*##zn##znMMMxnnxnznnnnnnnnzzz#+#++##zznznz#*i;;;::;iii***++#++#####zzznnnnnxMMxxxxnxxxxMMMMMMxnn#++++;`````````````
+*##+zxW@WMMWMWWWx#*zxxn+##z###zzxMMxMxxnnnnnnznnnnzzzz####zzznnnz+*i;i;:::;;i***+++++++##zzznnnnnnxMMxxnnxMMxnxMMMMMxnz#++++*,```````````
*****+MWWMxxWMz##+**zxxn++++#z#zznxMMWWMMxnnnnnnnnzzzzz#zzzzzzznnz+*i;ii;:::ii***++++####zzznnnxxnnxxMxxnnMxMMxxMMMMxnz#+++++*i```````````
****#xMMMMxMxM#***i*zxMx#**###nzznxMMMWMxWWxnnnnxnnnnznznzz#zzzz##+*iiii;;i;ii**+*+++###zzznnznnnnxnxxxxxxxxMMMMMWMMxzz++**+++*,``````````
***+nxxMWxxMx+z*i*ii#xxxz**#zzznznnxxxxnxWWMxnnnnnznzznnz###zz#z##++*iiiiiii***+++++#zzzzznnxnznnnxxnxxxxMMxMMMMMMMxnz#++**+++*;``````````
***+xxMMMMxxxn+*iiii#xMMn+z#nznnxxnxxxxxxMMMWxnnxxnnznnnz#z#zz######*ii*i**++++#####zzznznnnnxnznxnxxxxxxMMMMWMMMMMxnz++***+*+**,```````````
i*+#xxMMnzxxMxxx#i*i+xMMM##znnnnnxxxxMMWMMWWWMxxxxxnnnnz#zzzz######++*iii*##+####z#zzzznzznnnxxxxnnxxnxxxxMMWWMMWxxxn#+*********;````````` `
+#nxMxMMnnxxxxxnn#n#zMMMMzznnzxMMMMMMMMWWWWWW@WxMxxxnnzznnzzz#####+++**i++++####zz#zzzznn#znnnxxxxxxxnnxxxMMWWMWMxnn#+***********,`````````
MMxnMMMMMMxWxMMMxxnznMxMMzzxMnxMWWMMWWWWWW@WW@@MMMxxnznznnnz###zz##++**+++++#####z#zn#zznzznxnxxMxxxxxnxxxMMMWMMMxnz+************i:``````````
z#+*#xW@@MMMMWMWxxxnnMxMMnnnxnxMMWW@@@@@WW@WW@@@@Mxxnnxnxxnz###zzz#+++*+*****+++####zz#nnnznxnxxxxxxxxnxnxxMWMMMMxz++*************+*,```````
iiiiizWWMMWWMM@@WMMMxMxnxxnnzznnnMW@W@@@@WW@WW@@@MMxxnnnxxxz##zz#z#+++++*iiiii*++##znnznnnnnnxxxxxxnnxxxnnnxWMMxxz#+***************++;``````
i;ii+nMxMW@WW@@WxWxMMxz###znnnxnzxWWW@@@@@W@WM@W@WMMMnnnxxxn#z##z#++++++*ii;iii*+#+#zzzznnnznnnxxnnnnnxxxxxnWMMnx#++***************#++i.````
;*znxxMxMMWWWW@MzMMWWx###z#zzznnznxxMWW@#@W@WM@@@WWMMnnxxxxnz##z#z#++++++*iiii*++++##zzzznzznnnxxxnnnznnxxxnMMnnz++****************##++i.```
;izxnnnxWWWWWWWMznxxMMn##z#zzzxnzznznxxW##@@@MW@W@#WWWxxxxnnz+z#z##+++****ii;**+##++#zzzzznznnnnxnnnnzznxnxxnxnn#++***************++#+++i.```
i;*#*+nMMMMWWMWWnznxxxxzz#zzzzznzxxnznnx@@#@WWM@@@@WW@MxMxnn####z##++++**+*ii**######zzzzzzzzxnnxxnnnzznxnxxnnzz++****************+#+++++i.`````
#;i+nzMWWWWWWWMMxnnxxxnz#zz#zzzzzxnnzznxMW@@WMWMWW@@@@MnMnn#zz######+++++****++#zz###zzzzzzzznnnnxnnnnzzxnnnnz##+*****************+#+++++*i````
zi+xxMMWWWMWWWWWMMMnz#z#####zxnzznnnnznnnMW@@MMWWWW#W@xnxnn#####++##+#+#**+#+#+#zzz###zznzzzznzxnnnnnnzznnnnzz#+*****************+###+++++*;```
n*#xMMMMMMMWMMWWWWM#####zzzz#zzzzznnznnnnzMxWMxWWMW@WWxnnznz##z##+z++#z#++######znz###zzznznznnnnzxnnnz#nnnn#++******************+###+++++**;``
xnMMMMMMWWWWWWMWWWWxzzz##nxn#zznnxnnnnxnnnnxMxxWWMW@#Wnnzznz#zz+++#+#zz#+#zzzz#zznnzznznznnzznznnznnzn#znnzz#+**************+***+####++++++**;``
WWMMWWW@WWWWWWWWWMWWMz#z#zzzzzznzxxnxnnnnnnMMxxWMMW@@@Wxnnzzzzn*+++#nz+###zznzzzznnnnnznznnnnnznnzznzz#znzz#++******************+####++++++***;`
WWMMMW@#W@@WWWWWWWMMn#z####znnxxznnnnnznznnMMMxMMMxWW@@xznnz#zn++#*+z####zznnznnzxxnnnznnnxnnnzznnznzz#zz##++**************+***+#####+++++++***;`
@@MMWWM@W@WWWWWW@Wxnnz#znzzzzxMxnnnnnnznxMWWxnxxWWxWW@Wnzxnnz#z++#*+##zz#znnnnxxnxxxxxnzxxxnnnnnznzzzz#zz#++******************+#####++++++++****;`
xnnW@M@WWWWWWWWWWxzzzzzznz#znxMxMnnxMnnnM@WWn#nxxMxMMMMnznxzz#z#+#+*##zz#znxnxxxxxMxMxMnnMxnnnnnzzzzz#####+*******************######++++++++*****;`
znxWWMWWWMMMMMMMMMnnnzzzz#nnnnxxxnnnnzzxWMMMnzzxxxxMMxnnnnnzz#i*+##++#zz#znxxxxMMxMMMMMxnMxxnnznzz#zz####+*******************+####++++++++++******;.
nxMWWWWWWMxnzznMWMMnznzzzznzznnxxxnnzzxMMMxxnnnxnnnMxxxxnznz#;,;*+#+####znzxxMMMMMMWxMMMxxxxnnzz#zzzzz##++*******************####+++++++***********i,`
MMWMMMWWMxzzz##nnxxnnnznzzxxnxnMxxWMzzzzznnzznnnxzxxMMMxnnnni..:;i++##z##nnnxxMMMWMWMMWMxxxnzxzz##zzzz#++*******************####+++*****************i,
xMMMMMMMxxn##zzzzzznnnnxzznnnxxxMxWMnnzzzznnnxnnnnnxMMMxnnz*...,:i**+#nzznxnxnMxxMMWWMMMxxnnnnz###z#z#++*******************+###++****i*i*************i
MMxxxxzzz#zznn#zzzzzzznnznnMxMxxMMMMxxxnzxznxnnzxnxxxxxMnn*.....,:;i+#zzzzznxnxxMMMWMMMxnnnnzzz#z####+*********************###++**iiiiiiiiiii*********
xxxnxnzz####nxnnznznznnnnMxnxxxxMMxMnzxnzxnMMnnnxnnxxxMMx+......,,,;+###znznnnxxMMMMMMxxxnnznnz#zz##++************ii*i****+##++*iii;;;iiiiiiiii*******
MxxxxxxnzzzzzznMxnnzzzznzMnxxnxxMxnnnxMxznxnxxnxxxnnnMMx#,......,,,,i*++#nzzzxxxxMMMMMnnxnnznn#zz##++***********iiiii**ii*##++*ii;;;;;;;iiiiiiii******
Mxxxxxxnzznzzzznnnnnzz#znMxxMMxnxnxMnxxxnnxznxMxnnnnnxxz,........,,,;*++#z#znznxxMMMMnnnnnnzzznn##++****i**i**iiiiiii*iii+#++*i;;;;;;;;;;iiiiiiiii****
MxxxMnzz#zznn##zzznnnnzzzxMxxxxnxxxMnxxznxxxxMxxnnnnnx#,........,,,,:i*+###nnznxxMMMxnnnnzzzzznz#+*****iiiiiiiiiiiiiiiii*##**i;;;;::::;;;;iiiiiiiii***
MMxxxnzzzzzzz##znznnnnnzznxxnnnnxnnMxnxznnxxxxxxxxnnnz,......,.,,,,,,i**+++#zznnxxxxzzz#####zz#++****iiiiiiiiiiiiiiiiiii##*i;;;:::::::;:;;;;iiiiiiii**
xxxxxnnznnzz#zznnnz#znnzzznxxxnxxnnMMnznnxxxMxnMxxxnn+;:......,,,,,,,;i**i*+#nnxxnz#+++++++###+****iiiiiiiiiiiiiiiiiiii*z+i;;:::::::::::;;;;iiiiiiii**}
end
