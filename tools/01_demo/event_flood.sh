
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# SIMULATE INCIDENT ON ROBOTSHOP
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



export APP_NAME=robot-shop
export LOG_TYPE=elk   # humio, elk, splunk, ...
export EVENTS_TYPE=noi
export EVENTS_SKEW="-120M"
export LOGS_SKEW="-90M"
export METRICS_SKEW="+5M"

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT MODIFY BELOW
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
clear

echo ""
echo ""
echo ""
echo ""
echo ""
echo "   __________  __ ___       _____    ________            "
echo "  / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____"
echo " / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/"
echo "/ /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) "
echo "\____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  "
echo "                                          /_/            "
echo ""
echo ""
echo ""
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo ""
echo " 🚀  CP4WAIOPS Simulate Event Flood for $APP_NAME"
echo ""
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
if [ "${OS}" == "darwin" ]; then
      echo "OK"
else
      echo "❗ This tool currently only runs on Mac OS due to shell limitations."
      echo "❗ Please use the Demo Web UI for Incident simulation."
      echo "❌ Exiting....."
      exit 1 
fi

# Get Namespace from Cluster 
echo "   ------------------------------------------------------------------------------------------------------------------------------"
echo "    🔬 Getting Installation Namespace"
echo "   ------------------------------------------------------------------------------------------------------------------------------"

export WAIOPS_NAMESPACE=$(oc get po -A|grep aiops-orchestrator-controller |awk '{print$1}')
echo "       ✅ OK - AI Manager:    $WAIOPS_NAMESPACE"



# Define Log format
export log_output_path=/dev/null 2>&1
export TYPE_PRINT="📝 "$(echo $TYPE | tr 'a-z' 'A-Z')


#------------------------------------------------------------------------------------------------------------------------------------
#  Check Defaults
#------------------------------------------------------------------------------------------------------------------------------------

if [[ $APP_NAME == "" ]] ;
then
      echo " ⚠️ AppName not defined. Launching this script directly?"
      echo "    Falling back to $DEFAULT_APP_NAME"
      export APP_NAME=$DEFAULT_APP_NAME
fi

if [[ $LOG_TYPE == "" ]] ;
then
      echo " ⚠️ Log Type not defined. Launching this script directly?"
      echo "    Falling back to humio"
      export LOG_TYPE=elk
fi

if [[ $EVENTS_TYPE == "" ]] ;
then
      echo " ⚠️ Event Type not defined. Launching this script directly?"
      echo "    Falling back to noi"
      export LOG_TYPE=noi
fi

oc project $WAIOPS_NAMESPACE  >/tmp/demo.log 2>&1  || true


export USER_PASS="$(oc get secret aiops-ir-core-ncodl-api-secret -o jsonpath='{.data.username}' | base64 --decode):$(oc get secret aiops-ir-core-ncodl-api-secret -o jsonpath='{.data.password}' | base64 --decode)"
oc apply -n $WAIOPS_NAMESPACE -f ./tools/01_demo/scripts/datalayer-api-route.yaml >/tmp/demo.log 2>&1  || true
sleep 2
export DATALAYER_ROUTE=$(oc get route  -n $WAIOPS_NAMESPACE datalayer-api  -o jsonpath='{.status.ingress[0].host}')


#------------------------------------------------------------------------------------------------------------------------------------
#  Get Credentials
#------------------------------------------------------------------------------------------------------------------------------------
echo " "
echo "   ------------------------------------------------------------------------------------------------------------------------------"
echo "   🚀  Initializing..."
echo "   ------------------------------------------------------------------------------------------------------------------------------"





echo "     📥 Get Working Directories"
export WORKING_DIR_EVENTS="./tools/01_demo/INCIDENT_FILES/$APP_NAME/events_rest"

echo " "

echo "     📥 Get Date Formats"


OS=$(uname -s | tr '[:upper:]' '[:lower:]')
if [ "${OS}" == "darwin" ]; then
      # Suppose we're on Mac
      export DATE_FORMAT_EVENTS="-v$EVENTS_SKEW +%Y-%m-%dT%H:%M:%S"
      #export DATE_FORMAT_EVENTS="+%Y-%m-%dT%H:%M"
else
      # Suppose we're on a Linux flavour
      export DATE_FORMAT_EVENTS="-d$EVENTS_SKEW +%Y-%m-%dT%H:%M:%S" 
      #export DATE_FORMAT_EVENTS="+%Y-%m-%dT%H:%M" 
fi

echo " "






echo "   ----------------------------------------------------------------------------------------------------------------------------------------"
echo "     🔎  Parameters for Incident Simulation for $APP_NAME"
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"
echo "     "
echo "     "
echo "       📝 Events Type                 : $EVENTS_TYPE"
echo "       📅 Date Format Events          : $DATE_FORMAT_EVENTS"
echo "     "
echo "       📂 Directory for Events        : $WORKING_DIR_EVENTS"
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"
echo "   "
echo "   "

echo "   ----------------------------------------------------------------------------------------------------------------------------------------"
echo "     🗄️  Event Files to be loaded"
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"
ls -1 $WORKING_DIR_EVENTS | grep "json"
echo "     "
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"



#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# RUNNING Injection
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Inject the Events Inception files


      for i in {1..1000}
      do
            # Inject the Events Inception files
            echo "   "
            echo " "
            echo " "
            echo " "
            echo " ----------------------------------------------------------------------------------------------------------------------------------------"
            echo "  🚀  Launching Event Injection Iteration: $i" 
            echo " ----------------------------------------------------------------------------------------------------------------------------------------"

            ./tools/01_demo/scripts/simulate-events-rest.sh
      done



echo " "
echo " "
echo " "
echo " "
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo ""
echo " 🚀  CP4WAIOPS Simulate Event Flood for $APP_NAME"
echo "  ✅  Done..... "
echo ""
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
