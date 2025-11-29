#!/bin/bash

for host in node-0 node-1; do
  ssh root@${host} mkdir /var/lib/kubelet/
	scp certificates/ca.crt root@${host}:/var/lib/kubelet/

	scp certificates/${host}.crt \
		root@${host}:/var/lib/kubelet/kubelet.crt

	scp certificates/${host}.key \
		root@${host}:/var/lib/kubelet/kubelet.key
done

scp \
	certificates/ca.crt certificates/ca.key certificates/kube-api-server.crt certificates/service-accounts.key certificates/service-accounts.crt \
	root@server:~/

