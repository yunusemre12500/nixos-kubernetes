{ pkgs, ... }:
{
  systemd.services.kubelet = {
    serviceConfig = {
      ExecStart = ''
        ${pkgs.kubernetes}/bin/kubelet \
        --bootstrap-kubeconfig=/etc/kubernetes/kubeconfigs/kubelet-api-server-client.yaml
        --config=/etc/kubernetes/kubelet.yaml \
        --kubeconfig=/etc/kubernetes/kubeconfigs/kubelet-api-server-client.yaml
      '';
      Restart = "always";
      RestartSec = 5;
      WatchDog = "10";
    };
    wantedBy = [ "muti-user.target" ];
  };
}
