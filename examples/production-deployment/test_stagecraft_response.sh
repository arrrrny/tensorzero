#!/bin/bash

# Test script for stagecraft_response function

curl -X POST http://localhost:3000/inference \
  -H "Content-Type: application/json" \
  -d '{
    "function_name": "stagecraft_response",
    "episode_id": "0193a5b0-1234-7123-8123-123456789013",
    "input": {
      "messages": [
        {
          "role": "user",
          "content": "InitiatorArchetype: Hunter\nTargetArchetype: Operator\nPulseLine: Your shadow betrays the hunt.\nChosenResponseScript: Calculated Retreat"
        }
      ]
    },
    "stream": false
  }'