#!/bin/bash
# Reset
nc='\033[0m'       # Text Reset

#Regular Colors
blck='\033[0;30m'        # Black
red='\033[0;31m'          # Red
gr='\033[0;32m'        # Green
yw='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purp='\033[0;35m'       # Purple
cy='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

# Bold
bb='\033[1;30m'       # Black
br='\033[1;31m'         # Red
bg='\033[1;32m'       # Green
by='\033[1;33m'      # Yellow
bb='\033[1;34m'        # Blue
bp='\033[1;35m'      # Purple
bc='\033[1;36m'        # Cyan
bw='\033[1;37m'       # White
####################################
log="log.out"
get_em(){
    echo -e  "${bg}Checking${nc} for required langs...."
    checkgo=$(command -v go)
    if [ -z $checkgo ]; then
      echo -e "${bc}Go Lang not found${ne}!";echo -e "${by}Installing Go Lang${nc}"
      apt-get install golang -y > $log;echo -e "\t\t${bg}Finished!${nc}"
    else
      echo -e "${bb}Go lang${nc} already installed."
    fi
    checkruby=$(command -v ruby)
    
    if [ -z $checkruby ];  then
      echo -e "${bc}Ruby not found!${ne}"; echo -e "${by}Installing Ruby${nc}"
      (apt-get install ruby > $log)
    else
      echo -e "${br}Ruby${nc} already installed."
    fi
    
    echo -e  "${bg}Checking${nc} tools.."
    sleep 1
    echo -e "${bg}Checking for${nc} ${bw}Sublist3r${nc}"
    
    if [ -d sublist3r ]; then
      echo -e "${br}Sublist3r present.${nc} Checking others.."; sleep 1
    else
      echo -e "${bg}Installing${nc} ${bc}sublist3r${nc}"
      (git clone https://github.com/OffXec/Sublist3r.git sublist3r > $log)
    fi
    echo -e "${bg}Checking for${nc} ${bw}subjack${nc}";sleep 1
    dir="${HOME}/go/src/github.com/haccer/subjack/subjack/"
    if [ -d $dir ]; then
      echo -e "${bw}subjack already accuqired.${nc}....${br}skipped${nc}";sleep 1
    else
      echo -e "${bg}Installing${nc} ${bc}subjack${nc}"
      (go get github.com/haccer/subjack > $log)
    fi
    sleep 1
    clear
    ascii
    takeitbitch

}

takeitbitch(){
  echo -e "${yellow}Enter the domain(NO HTTP/S)${nc}:\t${bb}"
  read -r target
  echo -e "${cy}###############################################${nc}"
  clear
  ascii
  echo -e "${by}Mapping out the heist..${nc}..\\r"
  SECONDS=0
  subs="subs_${target}.txt"
  taken="takeovers_${target}.txt"
  touch $subs;touch $taken
  (python sublist3r/sublist3r.py --domain $target -o "$subs" -t 20 > $log);sleep 1
  echo ""
  echo -e "${br}Executing the plan..${nc}\\r"
  (subjack -w "$subs" -t 30 -o $taken -ssl > $log)
  end=$(date +%s)
  ascii
################
    
  loot=$( cat $taken | wc -l )
  ttl=$( cat $subs | wc -l)
  rtime="$(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
  echo -e "${by}HEIST COMPLETED${nc}!"
  echo -e "${bc}Target:${nc} $target"
  echo -e "${bw}Gathered:${nc} $ttl\n${by}Loot taken:${nc} $loot\n${bc}Completed in${nc}: $rtime${nc}"
  echo -e "${br}Results stored${nc}: $taken, $subs & $log"

}
###################################
ascii(){
  clear
  cat<<"EOF"

                        .=======.=============.
                       //_______\\             \
                      //IIIIIIIII\\ Sub domains \
                     // |_______| \\		 \
                    //| [_SCOPE_] |\\_____________\
                      | |  _ _  | |              |
      (you)           | | | | | | |   _   _   _  |
       O__,           | | |'|'| | |  [_] [_] [_] |
       /\($)          | |_| | |_| |              |
     ($)/\__          | |=======| |  PerilGroup  |
       _\   `         |_|=======|_|______________|
EOF
  echo -e "${yw}Thief 1.0${nc} - By ${by}Peril Group${nc}"
  echo -e "${cy}###############################################${nc}"
}
ascii
echo -e "${bb}Automated Sudomain collection & takeover scanner.${nc}"
echo -e "${bw}<3 Sublist3r & subjack."
echo -e "${cy}###############################################${nc}"
first="uno.txt"
if [ ! -f $first ]; then
touch $first
get_em
else
takeitbitch
fi
