#!/bin/bash
export MSYS_NO_PATHCONV=1
export subnet_id1=$(az network vnet subnet show --resource-group rg-vnet-development-01 --vnet-name vnetsbx-spoke01 --name akssubnet --query id -o tsv)
az aks create \
    --resource-group rg-backend-development-01 \
    --name aks-saas-kubeflow-01 \
    --location canadaeast \
    --load-balancer-sku standard \
    --enable-private-cluster \
    --network-plugin azure \
    --vnet-subnet-id $subnet_id1 \
    --dns-service-ip 10.1.10.10 \
    --attach-acr saasacrmlops01 \
    --enable-managed-identity \
    --service-cidr 10.1.0.0/16 \
    --kubernetes-version 1.27.1 \
    --node-osdisk-type Managed \
    --node-osdisk-size 500 \
    --enable-blob-driver \
    --nodepool-name sysnodepool \
    --node-count 1 \
    --generate-ssh-keys \
    --network-plugin-mode overlay \
    --vm-set-type VirtualMachineScaleSets \
    --node-vm-size Standard_D4_v3 \
    --disable-public-fqdn \
    --os-sku  Ubuntu \
    --private-dns-zone system \
    --max-pods 100


az aks nodepool add --cluster-name aks-saas-kubeflow-01 --name wkrnodepool \
    --resource-group rg-backend-development-01 \
    --enable-cluster-autoscaler \
    --kubernetes-version 1.27.1 \
    --max-count 3 \
    --max-pods 100 \
    --min-count 1 \
    --vnet-subnet-id $subnet_id1 \
    --mode User \
    --node-count 2 \
    --node-osdisk-size 1000 \
    --node-osdisk-type  Managed \
    --node-vm-size Standard_F16s_v2 \
    --os-sku  Ubuntu \
    --os-type Linux \
    --scale-down-mode  Delete 



az aks nodepool update --cluster-name aks-saas-kubeflow-01 \
    --name sysnodepool  \
    --resource-group rg-backend-development-01 \
    --mode System \
    --node-taints CriticalAddonsOnly=true:NoSchedule 
             