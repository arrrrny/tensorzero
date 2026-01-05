#!/bin/bash

# Test script for stagecraft_payoff_calculation function

curl -X POST http://localhost:3000/inference \
  -H "Content-Type: application/json" \
  -d '{
    "function_name": "stagecraft_payoff_calculation",
    "episode_id": "0193a5b0-1234-7123-8123-123456789015",
    "input": {
      "messages": [
        {
          "role": "user",
          "content": "InitiatorArchetype: Hunter\nTargetArchetype: Operator\nGuessedTargetArchetype: Operator\nStatedIntent: Extract\nActualIntent: Extract"
        }
      ]
    },
    "stream": false
  }'