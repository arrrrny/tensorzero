#!/bin/bash

# Test script for stagecraft_resolution function

curl -X POST http://localhost:3000/inference \
  -H "Content-Type: application/json" \
  -d '{
    "function_name": "stagecraft_resolution",
    "episode_id": "0193a5b0-1234-7123-8123-123456789014",
    "input": {
      "messages": [
        {
          "role": "user",
          "content": "InitiatorArchetype: Hunter\nResponseLine: The wires remain undisturbed.\nChosenResolutionScript: Final Strike"
        }
      ]
    },
    "stream": false
  }'