username = node[:username]
uid = node['etc']['passwd'][username]['uid']
dbus_path = "/run/user/#{uid}/bus"
dbus_address = "unix:path=#{dbus_path}"

gsettings_set = -> (name, schema, key, value) do
  bash "#{name} if dbus isn't running" do
    code <<-BASH
      sudo -u #{username} bash -c 'eval `dbus-launch --auto-syntax`; gsettings set #{schema} #{key} \"#{value}\"; kill $DBUS_SESSION_BUS_PID'
    BASH

    not_if { ::File.exist?(dbus_path) }
  end


  bash "#{name} if dbus is running" do
    environment({'DBUS_SESSION_BUS_ADDRESS' => dbus_address})
    code <<-BASH
      sudo -u #{username} --preserve-env=DBUS_SESSION_BUS_ADDRESS bash -c 'gsettings set #{schema} #{key} \"#{value}\"'
    BASH

    only_if { ::File.exist?(dbus_path) }
  end
end

gsettings_set.('use a tree view for the nautilus list view', 'org.gnome.nautilus.list-view', 'use-tree-view', 'true')
gsettings_set.('change the nautilus list-view zoom level to small', 'org.gnome.nautilus.list-view', 'default-zoom-level', 'small')
gsettings_set.('change the gtk-theme to Adwaita-dark', 'org.gnome.desktop.interface', 'gtk-theme', 'Adwaita-dark')
gsettings_set.('change the clock format to 12h', 'org.gnome.desktop.interface', 'clock-format', '12h')
gsettings_set.('add a keybinding to reset and clear gnome terminal', 'org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/', 'reset-and-clear', '<Control><Shift>k')

bash 'set the default browser to dissenter' do
  code <<-BASH
    sudo -u #{username} xdg-settings set default-web-browser dissenter-browser.desktop
  BASH
end
