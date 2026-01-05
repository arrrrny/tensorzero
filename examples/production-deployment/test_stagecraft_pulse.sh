#!/bin/bash

# Test script for stagecraft_pulse function

curl -X POST http://localhost:3003/inference \
  -H "Content-Type: application/json" \
  -d '{
    "function_name": "stagecraft_pulse",
    "input": {
      "messages": [
        {
          "role": "user",
          "content": "InitiatorArchetype: Hunter\nTargetArchetype: Operator\nChosenPulseScript: Feigned Weakness"
        }
      ]
    },
    "stream": false
  }'
