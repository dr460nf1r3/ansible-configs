#!/usr/bin/env bash
for host in $(ls ./host_vars); do
  ansible-vault decrypt host_vars/"$host"/"$host"_vault.yml &>/dev/null || true
done

echo "[38;5;208mDecrypted all vault files![0m"
