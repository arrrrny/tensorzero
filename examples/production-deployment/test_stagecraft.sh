#!/bin/bash

# Stagecraft Pulse Test
echo "=== STAGECRAFT PULSE ==="

PULSE_RESPONSE=$(curl -s -X POST http://localhost:3003/inference \
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
  }')

echo "$PULSE_RESPONSE"

# Extract episode_id and pulse line
EPISODE_ID=$(echo "$PULSE_RESPONSE" | jq -r '.episode_id')
TEXT=$(echo "$PULSE_RESPONSE" | jq -r '.content[0].text' | sed 's/```json//' | sed 's/```//')
PULSE_LINE=$(echo "$TEXT" | jq -r '.pulse')

echo "Episode ID: $EPISODE_ID"
echo "Extracted PulseLine: $PULSE_LINE"

echo ""
echo "=== STAGECRAFT RESPONSE ==="

# Build the response content string safely
RESPONSE_CONTENT=$(jq -n --arg pl "$PULSE_LINE" '"InitiatorArchetype: Operator\nTargetArchetype: Hunter\nPulseLine: " + $pl + "\nChosenResponseScript: Calculated Retreat"')

curl -X POST http://localhost:3003/inference \
  -H "Content-Type: application/json" \
  -d "{
    \"function_name\": \"stagecraft_response\",
    \"episode_id\": \"$EPISODE_ID\",
    \"input\": {
      \"messages\": [
        {
          \"role\": \"user\",
          \"content\": $RESPONSE_CONTENT
        }
      ]
    },
    \"stream\": false
  }"
