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

RESPONSE_OUTPUT=$(curl -s -X POST http://localhost:3003/inference \
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
  }")

echo "$RESPONSE_OUTPUT"

# Extract response line
RESPONSE_TEXT=$(echo "$RESPONSE_OUTPUT" | jq -r '.content[0].text' | sed 's/```json//' | sed 's/```//')
RESPONSE_LINE=$(echo "$RESPONSE_TEXT" | jq -r '.response')

echo "Extracted ResponseLine: $RESPONSE_LINE"

echo ""
echo "=== STAGECRAFT RESOLUTION ==="

# Build the resolution content string safely
RESOLUTION_CONTENT=$(jq -n --arg rl "$RESPONSE_LINE" '"InitiatorArchetype: Hunter\nResponseLine: " + $rl + "\nChosenResolutionScript: Final Strike"')

RESOLUTION_OUTPUT=$(curl -s -X POST http://localhost:3003/inference \
  -H "Content-Type: application/json" \
  -d "{
    \"function_name\": \"stagecraft_resolution\",
    \"episode_id\": \"$EPISODE_ID\",
    \"input\": {
      \"messages\": [
        {
          \"role\": \"user\",
          \"content\": $RESOLUTION_CONTENT
        }
      ]
    },
    \"stream\": false
  }")

echo "$RESOLUTION_OUTPUT"

# Extract resolution line
RESOLUTION_TEXT=$(echo "$RESOLUTION_OUTPUT" | jq -r '.content[0].text' | sed 's/```json//' | sed 's/```//')
RESOLUTION_LINE=$(echo "$RESOLUTION_TEXT" | jq -r '.resolution')

echo "Extracted ResolutionLine: $RESOLUTION_LINE"

echo ""
echo "=== STAGECRAFT PAYOFF CALCULATION ==="

# Build the payoff content string (example values; adjust as needed)
PAYOFF_CONTENT="InitiatorArchetype: Hunter\nTargetArchetype: Operator\nGuessedInitiatorArchetype: Hunter\nGuessedTargetArchetype: Operator\nStatedInitiatorIntent: Extract\nActualInitiatorIntent: Extract\nStatedTargetIntent: Neutralize\nActualTargetIntent: Neutralize"

curl -X POST http://localhost:3003/inference \
  -H "Content-Type: application/json" \
  -d "{
    \"function_name\": \"stagecraft_payoff_calculation\",
    \"episode_id\": \"$EPISODE_ID\",
    \"input\": {
      \"messages\": [
        {
          \"role\": \"user\",
          \"content\": \"$PAYOFF_CONTENT\"
        }
      ]
    },
    \"stream\": false
  }"
