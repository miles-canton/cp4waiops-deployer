
# SLACK TOKEN (User OAuth Token - must start with xoxp)
# See documentation under "Create User OAUTH Token"  -  not_configured
export SLACK_TOKEN=not_configured

# SLACK CHANNELS TO EMPTY
# Adapt to your needs
export SLACK_PROACTIVE="cp4waiops33_changerisk"


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT EDIT BELOW
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



echo "   __________  __ ___       _____    ________            "
echo "  / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____"
echo " / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/"
echo "/ /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) "
echo "\____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  "
echo "                                          /_/            "
echo ""
echo ""
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo " 🚀 CP4WAIOPS RESET SLACK CHANNELS"
echo "***************************************************************************************************************************************************"
echo " This will reset:"
echo "    - Slack Channels"
echo "***************************************************************************************************************************************************"
echo " You have to install the slack-cleaner2 module:"
echo "    pip install slack-cleaner2 or pip3 install slack-cleaner2"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"

 

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT EDIT BELOW
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


  read -p "❗ Are you really, really, REALLY sure you want to delete all messages from Slack? [y,N] " DO_COMM
  if [[ $DO_COMM == "y" ||  $DO_COMM == "Y" ]]; then
    echo "      🧞‍♂️ OK, as you wish...."
  else
    echo "      ❌ Aborted"
  fi


echo ""
echo ""
echo "--------------------------------------------------------------------------------------------------------------------------------"
echo "Empty Slack Channel $SLACK_REACTIVE $SLACK_TOKEN"
echo "--------------------------------------------------------------------------------------------------------------------------------"


  export SLACK_CHANNEL=$SLACK_PROACTIVE
  python3 ./tools/98_maintenance/scripts/slack-cleaner.py

echo " ✅ OK"



