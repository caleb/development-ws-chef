# This is required to use Brave on Debian
bash 'enable userns' do
  code <<-BASH
    echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/00-local-userns.conf
    service procps restart
  BASH
end