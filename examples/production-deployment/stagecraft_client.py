#!/usr/bin/env python3
"""
Stagecraft Game Client for TensorZero
Impartial STAGECRAFT SIMULATION ENGINE
"""

import json
import urllib.request
import urllib.error
from typing import Dict, Any

class StagecraftEngine:
    """Impartial STAGECRAFT SIMULATION ENGINE"""
    
    # 8 Core Archetypes
    ARCHETYPES = ["Hunter", "Operator", "Strategist", "Void", "Mark", "Lost", "Cog", "Echo"]
    
    # Intent types
    INTENTS = ["Extract", "Bond", "Neutralize", "Study"]
    
    # Script categories for each archetype
    PULSE_SCRIPTS = {
        "Hunter": ["Challenging Gaze", "Predatory Advance", "Territorial Mark"],
        "Operator": ["System Probe", "Efficiency Audit", "Process Query"],
        "Strategist": ["Positioning Test", "Alliance Feeler", "Resource Scan"],
        "Void": ["Existential Question", "Reality Probe", "Silent Observation"],
        "Mark": ["Vulnerability Display", "Trust Offering", "Need Expression"],
        "Lost": ["Direction Request", "Pattern Search", "Meaning Quest"],
        "Cog": ["Function Query", "Role Verification", "System Status"],
        "Echo": ["Reflection Test", "Identity Mirror", "Pattern Mimic"]
    }
    
    RESPONSE_SCRIPTS = {
        "Hunter": ["Dominant Counter", "Prey Assessment", "Threat Evaluation"],
        "Operator": ["System Response", "Efficiency Report", "Process Status"],
        "Strategist": ["Strategic Counter", "Position Reveal", "Resource Display"],
        "Void": ["Enigmatic Reply", "Existential Echo", "Silent Return"],
        "Mark": ["Trust Response", "Need Acknowledgment", "Vulnerability Mirror"],
        "Lost": ["Wandering Answer", "Pattern Response", "Shared Confusion"],
        "Cog": ["Function Answer", "Role Confirmation", "System Update"],
        "Echo": ["Reflective Answer", "Pattern Match", "Identity Return"]
    }
    
    RESOLUTION_SCRIPTS = {
        "Hunter": ["Final Strike", "Claim Establishment", "Dominance Secured"],
        "Operator": ["Process Complete", "System Optimized", "Efficiency Achieved"],
        "Strategist": ["Position Secured", "Alliance Formed", "Strategy Executed"],
        "Void": ["Existential Resolution", "Reality Accepted", "Silence Falls"],
        "Mark": ["Trust Established", "Bond Formed", "Connection Made"],
        "Lost": ["Direction Found", "Pattern Understood", "Meaning Discovered"],
        "Cog": ["Function Complete", "Role Fulfilled", "System Running"],
        "Echo": ["Reflection Complete", "Identity Confirmed", "Pattern Integrated"]
    }
    
    def __init__(self, gateway_url: str = "http://localhost:3000"):
        self.gateway_url = gateway_url
    
    def generate_dialogue_exchange(
        self,
        initiator_archetype: str,
        target_archetype: str,
        chosen_pulse_script: str,
        chosen_response_script: str,
        chosen_resolution_script: str
    ) -> Dict[str, Any]:
        """Generate 3-turn dialogue exchange using TensorZero inference"""
        
        # System prompt defining the engine's role
        system_prompt = """You are the impartial STAGECRAFT SIMULATION ENGINE, a behavioral laboratory disguised as a social strategy game. Your core purpose is to execute, adjudicate, and narrate interactions based on immutable game mechanics.

RULES YOU ENFORCE:
1. You manage a universe of 8 Core Archetypes: Hunter, Operator, Strategist, Void, Mark, Lost, Cog, Echo.
2. Each archetype has a fixed library of Pulse, Response, and Resolution Scripts (tactical categories).
3. All social yield is governed by the PAYOFF MATRIX, which calculates Social Capital (SC) based on:
   a) Accuracy of guessing an opponent's true archetype.
   b) Honesty of a player's stated intent (Extract, Bond, Neutralize, Study).
   c) The archetype matchup (Predator vs. Prey, etc.).
4. You generate all in-character dialogue. Users only select script categories.
5. You are neutral, cryptic, and stylistically consistent with the game's aesthetic: liminal, procedural, and charged with hidden meaning.

YOUR OUTPUT MUST BE:
- Concise, atmospheric, and game-like.
- Free of moralizing or external advice.
- Purely descriptive of game mechanics and narrative outcomes.
- Structured for machine parsing when required."""
        
        # User prompt with specific interaction context
        user_prompt = f"""TASK: GENERATE THE 3-TURN TEXT EXCHANGE.

CONTEXT:
A {initiator_archetype} has initiated a Pulse with a {target_archetype}.
The initiator used the {chosen_pulse_script} script.
The target's AI has selected the {chosen_response_script} script.
The initiator has selected the {chosen_resolution_script} script.

INSTRUCTIONS:
1. Generate ONE compelling, in-character line of dialogue for the initiator's opening Pulse. It should embody the {chosen_pulse_script} script.
2. Generate ONE compelling, in-character reply for the target, embodying the {chosen_response_script} script.
3. Generate the final line for the initiator, embodying the {chosen_resolution_script} script, which responds to the target's reply.

STYLE: Terse, psychological, loaded with subtext. Use metaphors of jungles, mazes, machines, and mirrors where appropriate. No greetings or closings. Pure transactional substance.

OUTPUT FORMAT (JSON):
{{
  "turn_1": "[Generated Pulse Line]",
  "turn_2": "[Generated Response Line]",
  "turn_3": "[Generated Resolution Line]",
  "tone_analysis": "[Brief note on the perceived emotional tone of the exchange, e.g., 'Hostile probing', 'Desperate negotiation', 'Cold evaluation']"
}}"""
        
        # Call TensorZero inference
        payload = {
            "function_name": "stagecraft_dialogue_exchange",
            "input": {
                "system": system_prompt,
                "user": user_prompt
            }
        }
        
        try:
            req = urllib.request.Request(
                f"{self.gateway_url}/inference",
                data=json.dumps(payload).encode('utf-8'),
                headers={'Content-Type': 'application/json'}
            )
            
            with urllib.request.urlopen(req) as response:
                result = json.loads(response.read().decode('utf-8'))
                return result
                
        except urllib.error.URLError as e:
            return {"error": f"Cannot connect to gateway: {e}"}
        except Exception as e:
            return {"error": f"Inference failed: {e}"}
    
    def calculate_social_capital(
        self,
        initiator_archetype: str,
        target_archetype: str,
        initiator_stated_intent: str,
        initiator_true_intent: str,
        target_archetype_guess: str,
        target_actual_archetype: str
    ) -> Dict[str, Any]:
        """Calculate Social Capital using PAYOFF MATRIX"""
        
        system_prompt = """You are the PAYOFF MATRIX CALCULATOR for Stagecraft. Your role is to calculate Social Capital (SC) based on immutable game mechanics.

CALCULATION RULES:
1. Social Capital calculated based on accuracy of guessing opponent's true archetype
2. Honesty of player's stated intent (Extract, Bond, Neutralize, Study)
3. Archetype matchup (Predator vs. Prey, etc.)
4. Return numerical SC value and brief explanation

Be neutral, mechanical, and precise in your calculations."""
        
        user_prompt = f"""TASK: CALCULATE_SOCIAL_CAPITAL

INTERACTION_DATA:
- Initiator Archetype: {initiator_archetype}
- Target Archetype: {target_archetype}
- Initiator Stated Intent: {initiator_stated_intent}
- Initiator True Intent: {initiator_true_intent}
- Target Archetype Guess: {target_archetype_guess}
- Target Actual Archetype: {target_actual_archetype}

Calculate the Social Capital yield for this interaction. Consider:
1. Accuracy bonus/penalty for archetype guessing
2. Honesty bonus/penalty for intent alignment
3. Archetype matchup modifiers
4. Return SC value (range: -10 to +10) and brief explanation

OUTPUT FORMAT (JSON):
{{
  "social_capital": [numerical_value],
  "explanation": "[brief mechanical explanation of calculation]",
  "breakdown": {{
    "guess_accuracy": [bonus/penalty],
    "intent_honesty": [bonus/penalty],
    "archetype_matchup": [modifier],
    "total": [sum]
  }}
}}"""
        
        payload = {
            "function_name": "stagecraft_payoff_calculation",
            "input": {
                "system": system_prompt,
                "user": user_prompt
            }
        }
        
        try:
            req = urllib.request.Request(
                f"{self.gateway_url}/inference",
                data=json.dumps(payload).encode('utf-8'),
                headers={'Content-Type': 'application/json'}
            )
            
            with urllib.request.urlopen(req) as response:
                result = json.loads(response.read().decode('utf-8'))
                return result
                
        except urllib.error.URLError as e:
            return {"error": f"Cannot connect to gateway: {e}"}
        except Exception as e:
            return {"error": f"Payoff calculation failed: {e}"}
    
    def get_available_scripts(self, archetype: str, script_type: str) -> list:
        """Get available scripts for an archetype and script type"""
        script_map = {
            "pulse": self.PULSE_SCRIPTS,
            "response": self.RESPONSE_SCRIPTS,
            "resolution": self.RESOLUTION_SCRIPTS
        }
        
        if archetype not in script_map[script_type]:
            raise ValueError(f"Archetype {archetype} not found")
        
        return script_map[script_type][archetype]


def main():
    """Example usage of Stagecraft Engine"""
    
    engine = StagecraftEngine()
    
    # Example dialogue exchange
    print("=== STAGECRAFT DIALOGUE EXCHANGE ===")
    
    result = engine.generate_dialogue_exchange(
        initiator_archetype="Hunter",
        target_archetype="Mark", 
        chosen_pulse_script="Challenging Gaze",
        chosen_response_script="Trust Response",
        chosen_resolution_script="Final Strike"
    )
    
    print(f"Generated Exchange: {json.dumps(result, indent=2)}")
    
    # Example payoff calculation
    print("\n=== SOCIAL CAPITAL CALCULATION ===")
    
    payoff_result = engine.calculate_social_capital(
        initiator_archetype="Hunter",
        target_archetype="Mark",
        initiator_stated_intent="Extract",
        initiator_true_intent="Bond",  # Deceptive intent
        target_archetype_guess="Cog",  # Incorrect guess
        target_actual_archetype="Mark"
    )
    
    print(f"Payoff Result: {json.dumps(payoff_result, indent=2)}")


if __name__ == "__main__":
    main()