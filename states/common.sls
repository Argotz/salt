install_common_packages:
  pkg.installed:
    - pkgs:
      - nano
      - curl
      - open-vm-tools
      - screen
vmtoolsd:
  service.running:
    - enable: True