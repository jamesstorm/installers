#!/bin/bash

FUNCTIONS_URL="https://github.com/jamesstorm/installers/master/functions.sh"

# Download and source it
. /dev/stdin <<EOF
$(curl -fsSL "$FUNCTIONS_URL")
EOF

echo "Hello, World."


# Call it
get_os

# Now OS_NAME is set
echo "Detected OS: $OS_NAME"
