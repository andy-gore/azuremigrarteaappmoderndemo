RESOURCE_GROUP=migrate-aks-rg
WINDOWS_USERNAME=aksadminuser
AKS_CLUSTER=akscluster
ACR=bungle

az group create --name $RESOURCE_GROUP --location westus2

az aks create \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_CLUSTER \
    --node-count 1 \
    --enable-addons monitoring \
    --generate-ssh-keys \
    --windows-admin-username $WINDOWS_USERNAME \
    --vm-set-type VirtualMachineScaleSets \
    --kubernetes-version 1.20.5 \
    --network-plugin azure

az aks nodepool add \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $AKS_CLUSTER \
    --os-type Windows \
    --name npwin \
    --node-count 1

az aks update -n $AKS_CLUSTER -g $RESOURCE_GROUP --attach-acr $ACR
