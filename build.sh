sudo cp configuration.nix /etc/nixos/configuration.nix
# sudo cp hardware-configuration.nix /etc/nixos/hardware-configuration.nix
cp home.nix ~/.config/home-manager/
sudo nixos-rebuild switch -j4
