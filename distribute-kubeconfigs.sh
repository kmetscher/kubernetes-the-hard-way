#!/bin/bash

for host in node-0 node-1; do
  ssh root@${host} "mkdir -p /var/lib/{kube-proxy,kubelet}"

  scp kubeconfigs/kube-proxy.kubeconfig \
    root@${host}:/var/lib/kube-proxy/kubeconfig \

  scp kubeconfigs/${host}.kubeconfig \
    root@${host}:/var/lib/kubelet/kubeconfig
done

scp kubeconfigs/admin.kubeconfig \
  kubeconfigs/kube-controller-manager.kubeconfig \
  kubeconfigs/kube-scheduler.kubeconfig \
  root@server:~/
