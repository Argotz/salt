install_common_packages:
  pkg.installed:
    - pkgs:
      - nano
      - curl
      - open-vm-tools
      - screen
service.running:
  -name: 
    - open-vm-tools