#!/bin/bash

exist=$(env | grep HELM_EXPERIMENTAL_OCI)

# Make sure that HELM_EXPERIMENTAL_OCI is set when executing the following commands.
if [[ $exist != "HELM_EXPERIMENTAL_OCI=1" ]]
then
    echo "Exporting environment variable HELM_EXPERIMENTAL_OCI=1"
    export HELM_EXPERIMENTAL_OCI=1
fi

# Pull will try to pull a Helm chart.
# $1: name    <string> Name of the chart.
# $2: version <string> Version of the chart.
Pull() {
    echo "Pulling chart $1:$2..."
    helm chart pull $1:$2
}

# Export will try to export a Helm chart.
# $1: name        <string> Name of the chart.
# $2: version     <string> Version of the chart.
# $3: destination <string> Destination where the chart should be exported to.
Export() {
    echo "Exporting chart $1:$2 to $3..."
    helm chart export $1:$2 --destination $3
}

# Save will try to save a Helm chart.
# $1: name        <string> Name of the chart.
# $2: version     <string> Version of the chart.
# $3: destination <string> Destination where the chart should be exported to.
Save() {
    echo "Saving chart $1:$2 located in $3..."
    helm chart save $3 $1:$2
}

# Push will try to push a Helm chart.
# $1: name    <string> Name of the chart.
# $2: version <string> Version of the chart.
Push() {
    echo "Pushing chart $1:$2..."
    helm chart push $1:$2
}


# Command to execute.
cmd=$1

# Version of the chart to use.
version=$2

# Is it backend or frontend.
febe=${3%/*}

# Name of the app.
app=${3#*/}

# Directory to use. Only for the `export` command.
dir=$4

# Location of the Azure registry where the Helm charts are stored.
registry="premfinaukcontainerregistry.azurecr.io/helm"

# Location where this Helm chart is located.
repository="$registry/$febe/$app"

# Let's execute the desired comand.
case $cmd in

  save)
    Save $repository $version $3
    ;;

  push)
    Push $repository $version
    ;;

  export)
    Export $repository $version $dir
    ;;

  pull)
    Pull $repository $version
    ;;

  *)
    echo -n "Unknown command"
    ;;
esac

exit 0
