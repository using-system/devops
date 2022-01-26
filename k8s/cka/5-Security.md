# Authentication

- Static password file
- Static token file
- Certificates
- Identity services (ldap...)

## Static password file

Csv file with 3 column : password, username, userid. (one Optional column groupname)

Pass the file to the kube-api-server option `--basic-auth-file`.

## Static token file

Csv file with 3 column : token, username, userid. (one Optional column groupname)

Pass the file to the kube-api-server option `--token-auth-file`.

# Cluster certificates
