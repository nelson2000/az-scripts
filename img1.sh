#!/bin/bash

imageResourceGroup=rg-image-development
location=canadacentral
imageName=customImageU2204
runOutputName=aibCustLinManImg01ro
vnetName=vnetsbx-spoke02
subnetName='/subscriptions/eff8023d-71cc-4be2-bb62-46d0b7658eeb/resourceGroups/rg-vnet-development-02/providers/Microsoft.Network/virtualNetworks/vnetsbx-spoke02/subnets/imgbuilder-subnet'
vnetRgName=rg-vnet-development-02
nsgName=saasNSG01
iden='/subscriptions/eff8023d-71cc-4be2-bb62-46d0b7658eeb/resourceGroups/rg-image-development/providers/Microsoft.ManagedIdentity/userAssignedIdentities/Imagebuilder-iden0'
sigName=saasImagegallery
subscriptionID=eff8023d-71cc-4be2-bb62-46d0b7658eeb
imageDefName=saasImagedef1

scripts="https://raw.githubusercontent.com/nelson2000/az-scripts/master/install.sh"
imagesource="Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest"

# shared image gallery

az sig image-definition create \
   -g $sigResourceGroup \
   --gallery-name $sigName \
   --gallery-image-definition $imageDefName \
   --publisher Canonical \
   --offer '0001-com-ubuntu-server-jammy' \
   --sku 22_04-lts-gen2 \
   --os-type Linux

az image builder create --name \
    --resource-group $imageResourceGroup \
    --build-timeout 80 \
    --identity $iden \
    --image-source $imagesource \
    --location $location \
    --os-disk-size 0 \
    --proxy-vm-size Standard_D2ds_v4 \
    --scripts $scripts \
    --shared-image-destinations $sigName/$imageDefName=canadacentral,canadaeast \
    --subnet $subnetName \
    --tags Environment=Sandbox Admininstrator='Nelson Nwajie' Project=Retail-SaaS ImageType=Ubuntu22.04 \
    --vm-size Standard_D4s_v3 



# az image builder output add --artifact-tags Architecture=64 ImageType=Ubuntu22.04 \
#     --gallery-image-definition $imageDefName \
#     --gallery-name $sigName \
#     --gallery-replication-regions eastus canadaeast \
#     --ids 
#     --name
#     --output-name saasimageoutput \
#     --resource-group $imageResourceGroup \
#     --subscription $subscriptionID \
#     --versioning Source \
#     --defer
                            