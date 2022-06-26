#!/usr/bin/env bash
for host in $(ls ./host_vars); do
  ansible-vault encrypt host_vars/"$host"/"$host"_vault.yml &>/dev/null || true
done

for group in $(ls ./group_vars); do
  [ -f "group_vars/$group/${group}_vault.yml" ] && ansible-vault encrypt "group_vars/$group/${group}_vault.yml" >/dev/null || true
done

echo "[38;5;208mEncrypted all vaults![0m"
