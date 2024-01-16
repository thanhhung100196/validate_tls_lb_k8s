#!/bin/bash

# Specify the domain to check
domain="chidoanh.com"

# Run the openssl command to check the TLS validation
if openssl s_client -connect $domain:443 -servername $domain </dev/null 2>/dev/null | openssl x509 -noout -checkend 0; then
    echo "true"
else
    echo "fail"
    # Renew the SSL certificate using Certbot
    certbot renew --cert-name $domain

    # Update the secret in Kubernetes
    kubectl create secret tls tls-secret --cert=path/to/new/certificate.crt --key=path/to/new/private.key --namespace=default --dry-run=client -o yaml | kubectl apply -f -
    certbot renew --cert-name $domain
fi



