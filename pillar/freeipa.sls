freeipa:
  client:
    enabled: true
    server: freeipa.carhan.net
    domain: {{ salt['grains.get']('domain', '') }}
    realm: {{ salt['grains.get']('domain', '').upper() }}
    hostname: {{ salt['grains.get']('fqdn', '') }}
