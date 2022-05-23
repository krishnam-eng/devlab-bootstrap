

# Vault Server

```shell
vault server -dev

mkdir ~hrt/pvt/vault
echo 'sample0L6TCEEA4fJvodbyv3+gtSXzdMQ9sf1dNtuecOz4Wl8=' > ~hrt/pvt/vault/unseal.key
echo 'samplehvs.9ndt39Hbpv9ksPn75ah1iP52' > ~hrt/pvt/vault/root.token
```

## Vault Client

```shell

# This will help vault client to talk to local vault server
export VAULT_ADDR='http://127.0.0.1:8200'

# This will help vault client to authenticate to local vault server
export VAULT_TOKEN='samplehvs.9ndt39Hbpv9ksPn75ah1iP52'
export VAULT_DEV_ROOT_TOKEN_ID='samplehvs.9ndt39Hbpv9ksPn75ah1iP52'
```

```shell
vault status
```
