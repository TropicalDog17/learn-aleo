#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

echo "
Two parties involved.

The private key and the address of the box owner.
private_key:APrivateKey1zkpDKzawHCPBaZk2Kmz9hkRdtfU3jGX5SRXSqgM7Z8rUuTn
address: aleo1medtgn2gy9knpjq2l7hrmjrpkk8umm42j94jwn67hw8eqqeg6vrs6zn9a9

The private key and the address of the suggester.
private key  APrivateKey1zkpJxeYeVYV4wqNHcWiTeFxJwMnUShdVLEeakEtiDkJRF9N
address  aleo1cvzagjpy4qvhgeal4emau8u9wqqwhl58m34eaks0j7ctawxdwcrs4m525p
"
echo "
First we will initialize the permissionless box with maximum vote of 10
echo '
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkpHtqVWT6fSHgUMNxsuVf7eaR6id2cj7TieKY1Z8CP5rCD
' > .env

leo run initialize_permissionless_box 10u64
"

# Swap in the private key to suggester
echo "
NETWORK=testnet3
PRIVATE_KEY=APrivateKey1zkpJxeYeVYV4wqNHcWiTeFxJwMnUShdVLEeakEtiDkJRF9N
" > .env

# Create a suggestion
leo run permissionless_publish "{
    box_id: 1u64,
    suggester: aleo1cvzagjpy4qvhgeal4emau8u9wqqwhl58m34eaks0j7ctawxdwcrs4m525p,
    receiver:  aleo1medtgn2gy9knpjq2l7hrmjrpkk8umm42j94jwn67hw8eqqeg6vrs6zn9a9,
    timestamp: 100000u64,
    message: 123field
}"