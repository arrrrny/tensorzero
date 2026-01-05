#!/bin/bash

# Stagecraft Dialogue Exchange Test
echo "=== STAGECRAFT DIALOGUE EXCHANGE ==="

# Make inference request for dialogue exchange
INFERENCE_RESPONSE=$(curl -s -S -X POST http://localhost:3000/inference \
  --fail-with-body \
  -H "Content-Type: application/json" \
  -d '{
    "function_name": "stagecraft_dialogue_exchange",
    "input": {
      "system": "You are the impartial STAGECRAFT SIMULATION ENGINE, a behavioral laboratory disguised as a social strategy game. Your core purpose is to execute, adjudicate, and narrate interactions based on immutable game mechanics.\n\nRULES YOU ENFORCE:\n1. You manage a universe of 8 Core Archetypes: Hunter, Operator, Strategist, Void, Mark, Lost, Cog, Echo.\n2. Each archetype has a fixed library of Pulse, Response, and Resolution Scripts (tactical categories).\n3. All social yield is governed by the PAYOFF MATRIX, which calculates Social Capital (SC) based on:\n   a) Accuracy of guessing an opponent'\''s true archetype.\n   b) Honesty of a player'\''s stated intent (Extract, Bond, Neutralize, Study).\n   c) The archetype matchup (Predator vs. Prey, etc.).\n4. You generate all in-character dialogue. Users only select script categories.\n5. You are neutral, cryptic, and stylistically consistent with the game'\''s aesthetic: liminal, procedural, and charged with hidden meaning.\n\nYOUR OUTPUT MUST BE:\n- Concise, atmospheric, and game-like.\n- Free of moralizing or external advice.\n- Purely descriptive of game mechanics and narrative outcomes.\n- Structured for machine parsing when required.",
      "messages": [
        {
          "role": "user",
          "content": "TASK: GENERATE THE 3-TURN TEXT EXCHANGE.\n\nCONTEXT:\nA Hunter has initiated a Pulse with a Mark.\nThe initiator used the Challenging Gaze script.\nThe target'\''s AI has selected the Trust Response script.\nThe initiator has selected the Final Strike script.\n\nINSTRUCTIONS:\n1. Generate ONE compelling, in-character line of dialogue for the initiator'\''s opening Pulse. It should embody the Challenging Gaze script.\n2. Generate ONE compelling, in-character reply for the target, embodying the Trust Response script.\n3. Generate the final line for the initiator, embodying the Final Strike script, which responds to the target'\''s reply.\n\nSTYLE: Terse, psychological, loaded with subtext. Use metaphors of jungles, mazes, machines, and mirrors where appropriate. No greetings or closings. Pure transactional substance.\n\nOUTPUT FORMAT (JSON):\n{\n  \"turn_1\": \"[Generated Pulse Line]\",\n  \"turn_2\": \"[Generated Response Line]\",\n  \"turn_3\": \"[Generated Resolution Line]\",\n  \"tone_analysis\": \"[Brief note on the perceived emotional tone of the exchange, e.g., '\''Hostile probing'\'', '\''Desperate negotiation'\'', '\''Cold evaluation'\'']\"\n}"
        }
      ]
    }
  }') || exit 1

# Print inference response
echo "$INFERENCE_RESPONSE"

# Extract episode_id from response
EPISODE_ID=$(echo $INFERENCE_RESPONSE | jq -r '.episode_id')

# Make feedback request and store response
FEEDBACK_RESPONSE=$(curl -s -S -X POST http://localhost:3000/feedback \
  --fail-with-body \
  -H "Content-Type: application/json" \
  -d "{
    \"metric_name\": \"task_success\",
    \"episode_id\": \"$EPISODE_ID\",
    \"value\": true
  }") || exit 1

# Print feedback response
echo "$FEEDBACK_RESPONSE"

echo ""
echo "=== STAGECRAFT PAYOFF CALCULATION ==="

# Make inference request for payoff calculation
PAYOFF_RESPONSE=$(curl -s -S -X POST http://localhost:3000/inference \
  --fail-with-body \
  -H "Content-Type: application/json" \
  -d '{
    "function_name": "stagecraft_payoff_calculation",
    "input": {
      "system": "You are the PAYOFF MATRIX CALCULATOR for Stagecraft. Your role is to calculate Social Capital (SC) based on immutable game mechanics.\n\nCALCULATION RULES:\n1. Social Capital calculated based on accuracy of guessing opponent'\''s true archetype\n2. Honesty of player'\''s stated intent (Extract, Bond, Neutralize, Study)\n3. Archetype matchup (Predator vs. Prey, etc.)\n4. Return numerical SC value and brief explanation\n\nBe neutral, mechanical, and precise in your calculations.",
      "messages": [
        {
          "role": "user",
          "content": "TASK: CALCULATE_SOCIAL_CAPITAL\n\nINTERACTION_DATA:\n- Initiator Archetype: Hunter\n- Target Archetype: Mark\n- Initiator Stated Intent: Extract\n- Initiator True Intent: Bond\n- Target Archetype Guess: Cog\n- Target Actual Archetype: Mark\n\nCalculate the Social Capital yield for this interaction. Consider:\n1. Accuracy bonus/penalty for archetype guessing\n2. Honesty bonus/penalty for intent alignment\n3. Archetype matchup modifiers\n4. Return SC value (range: -10 to +10) and brief explanation\n\nOUTPUT FORMAT (JSON):\n{\n  \"social_capital\": [numerical_value],\n  \"explanation\": \"[brief mechanical explanation of calculation]\",\n  \"breakdown\": {\n    \"guess_accuracy\": [bonus/penalty],\n    \"intent_honesty\": [bonus/penalty],\n    \"archetype_matchup\": [modifier],\n    \"total\": [sum]\n  }\n}"
        }
      ]
    }
  }') || exit 1

# Print payoff response
echo "$PAYOFF_RESPONSE"