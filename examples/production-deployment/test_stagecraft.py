#!/usr/bin/env python3
"""
Simple test script for Stagecraft dialogue generation
"""

import json
import asyncio
import urllib.request
import urllib.error

async def test_stagecraft_dialogue():
    """Test the Stagecraft dialogue generation via HTTP API"""
    
    # Test payload
    payload = {
        "function_name": "stagecraft_dialogue_exchange",
        "input": {
            "system": json.dumps({
                "role": "STAGECRAFT_SIMULATION_ENGINE",
                "rules": [
                    "Manage universe of 8 Core Archetypes: Hunter, Operator, Strategist, Void, Mark, Lost, Cog, Echo",
                    "Each archetype has fixed library of Pulse, Response, and Resolution Scripts",
                    "All social yield governed by PAYOFF MATRIX calculating Social Capital (SC)",
                    "Generate all in-character dialogue. Users only select script categories",
                    "Be neutral, cryptic, and stylistically consistent: liminal, procedural, charged with hidden meaning"
                ],
                "archetypes": ["Hunter", "Operator", "Strategist", "Void", "Mark", "Lost", "Cog", "Echo"],
                "output_requirements": [
                    "Concise, atmospheric, and game-like",
                    "Free of moralizing or external advice", 
                    "Purely descriptive of game mechanics and narrative outcomes",
                    "Structured for machine parsing when required"
                ]
            }),
            "user": json.dumps({
                "task": "GENERATE_THE_3-TURN_TEXT_EXCHANGE",
                "context": {
                    "initiator_archetype": "Hunter",
                    "target_archetype": "Mark",
                    "chosen_pulse_script": "Challenging Gaze",
                    "chosen_response_script": "Trust Response",
                    "chosen_resolution_script": "Final Strike"
                },
                "instructions": [
                    "Generate ONE compelling, in-character line of dialogue for the initiator's opening Pulse. It should embody the Challenging Gaze script.",
                    "Generate ONE compelling, in-character reply for the target, embodying the Trust Response script.",
                    "Generate the final line for the initiator, embodying the Final Strike script, which responds to the target's reply."
                ],
                "style": "Terse, psychological, loaded with subtext. Use metaphors of jungles, mazes, machines, and mirrors where appropriate. No greetings or closings. Pure transactional substance.",
                "output_format": {
                    "turn_1": "[Generated Pulse Line]",
                    "turn_2": "[Generated Response Line]", 
                    "turn_3": "[Generated Resolution Line]",
                    "tone_analysis": "[Brief note on the perceived emotional tone of the exchange]"
                }
            })
        }
    }
    
    # Make HTTP request to TensorZero gateway
    try:
        req = urllib.request.Request(
            "http://localhost:3000/inference",
            data=json.dumps(payload).encode('utf-8'),
            headers={'Content-Type': 'application/json'}
        )
        
        with urllib.request.urlopen(req) as response:
            result = json.loads(response.read().decode('utf-8'))
            print("=== STAGECRAFT DIALOGUE EXCHANGE ===")
            print(json.dumps(result, indent=2))
            
    except urllib.error.URLError as e:
        print("Error: Cannot connect to TensorZero gateway at http://localhost:3000")
        print("Make sure the gateway is running with: docker compose up")
        print(f"Connection error: {e}")
    except Exception as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    asyncio.run(test_stagecraft_dialogue())