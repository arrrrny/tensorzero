#!/bin/bash

# Run all stagecraft function tests

echo "Testing stagecraft_pulse..."
./test_stagecraft_pulse.sh
echo -e "\n\n"

echo "Testing stagecraft_response..."
./test_stagecraft_response.sh
echo -e "\n\n"

echo "Testing stagecraft_resolution..."
./test_stagecraft_resolution.sh
echo -e "\n\n"

echo "Testing stagecraft_payoff_calculation..."
./test_stagecraft_payoff.sh
echo -e "\n\n"

echo "All tests completed."