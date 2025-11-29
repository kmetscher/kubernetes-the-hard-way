#!/bin/bash

for host in node-0 node-1; do
  kubectl config set-cluster kubernetes-the-hard-way \
		--certificate-authority=certificates/ca.crt \
		--embed-certs=true \
		--server=https://server.kubernetes.local:6443 \
		--kubeconfig=kubeconfigs/${host}.kubeconfig

	kubectl config set-credentials system:node:${host} \
		--client-certificate=certificates/${host}.crt \
		--client-key=certificates/${host}.key \
		--embed-certs=true \
		--kubeconfig=kubeconfigs/${host}.kubeconfig

	kubectl config set-context default \
		--cluster=kubernetes-the-hard-way \
		--user=system:node:${host} \
		--kubeconfig=kubeconfigs/${host}.kubeconfig

	kubectl config use-context default \
		--kubeconfig=kubeconfigs/${host}.kubeconfig
done

kubectl config set-cluster kubernetes-the-hard-way \
	--certificate-authority=certificates/ca.crt \
	--embed-certs=true \
	--server=https://server.kubernetes.local:6443 \
	--kubeconfig=kubeconfigs/kube-proxy.kubeconfig

kubectl config set-credentials system:kube-proxy \
  --client-certificate=certificates/kube-proxy.crt \
	--client-key=certificates/kube-proxy.key \
  --embed-certs=true \
  --kubeconfig=kubeconfigs/kube-proxy.kubeconfig

kubectl config set-context default \
	--cluster=kubernetes-the-hard-way \
	--user=system:kube-proxy \
	--kubeconfig=kubeconfigs/kube-proxy.kubeconfig

kubectl config use-context default \
	--kubeconfig=kubeconfigs/kube-proxy.kubeconfig

kubectl config set-cluster kubernetes-the-hard-way \
	--certificate-authority=certificates/ca.crt \
	--embed-certs=true \
	--server=https://server.kubernetes.local:6443 \
	--kubeconfig=kubeconfigs/kube-scheduler.kubeconfig

kubectl config set-credentials system:kube-scheduler \
	--client-certificate=certificates/kube-scheduler.crt \
	--client-key=certificates/kube-scheduler.key \
	--embed-certs=true \
	--kubeconfig=kubeconfigs/kube-scheduler.kubeconfig

kubectl config set-context default \
	--cluster=kubernetes-the-hard-way \
	--user=system:kube-scheduler \
	--kubeconfig=kubeconfigs/kube-scheduler.kubeconfig

kubectl config use-context default \
	--kubeconfig=kubeconfigs/kube-scheduler.kubeconfig

kubectl config set-cluster kubernetes-the-hard-way \
  --certificate-authority=certificates/ca.crt \
  --embed-certs=true \
  --server=https://127.0.0.1:6443 \
  --kubeconfig=kubeconfigs/admin.kubeconfig

kubectl config set-credentials admin \
  --client-certificate=certificates/admin.crt \
  --client-key=certificates/admin.key \
  --embed-certs=true \
  --kubeconfig=kubeconfigs/admin.kubeconfig

kubectl config set-context default \
  --cluster=kubernetes-the-hard-way \
  --user=admin \
  --kubeconfig=kubeconfigs/admin.kubeconfig

kubectl config use-context default \
  --kubeconfig=kubeconfigs/admin.kubeconfig
