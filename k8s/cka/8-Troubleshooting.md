## Control Plane failure

## With kubeadm

`kubectl get pod -n kube-system`

Then

`kubectl logs pod_name -n kube_system`

## With services

`service kube-proxy status`

`sudo journalctl -u kube-apiserver`

## Kubelet

`service kubelet status`

`sudo journalctl -u kubelet`

`systemctl start kubelet`

`vi /var/lib/kubelet/config.yaml`

View kubelet config file : `cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf`