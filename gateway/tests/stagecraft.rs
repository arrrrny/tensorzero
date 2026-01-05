#![allow(clippy::expect_used, clippy::unwrap_used, clippy::print_stdout)]

use reqwest::Client;
use serde_json::json;
use uuid::Uuid;

use crate::common::start_gateway_on_random_port;

#[tokio::test]
async fn test_stagecraft_pulse() {
    let config = r#"
[models."deepseek-chat"]
routing = ["deepseek"]

[models."deepseek-chat".providers.deepseek]
type = "deepseek"
model_name = "deepseek-chat"

[functions.stagecraft_pulse]
type = "chat"

[functions.stagecraft_pulse.variants.deepseek_baseline]
type = "chat_completion"
model = "deepseek-chat"
weight = 1
system_template = "functions/stagecraft_pulse/variants/deepseek_baseline/system_template.minijinja"
user_template = "functions/stagecraft_pulse/variants/deepseek_baseline/user_template.minijinja"
"#;

    let gateway = start_gateway_on_random_port(config, None).await;

    let client = Client::new();
    let response = client
        .post(format!("http://{}/inference", gateway.addr))
        .json(&json!({
            "function_name": "stagecraft_pulse",
            "episode_id": Uuid::now_v7(),
            "input": {
                "InitiatorArchetype": "Hunter",
                "TargetArchetype": "Operator",
                "ChosenPulseScript": "Challenging Gaze"
            },
            "stream": false
        }))
        .send()
        .await
        .unwrap();

    assert_eq!(response.status(), 200);
    let body: serde_json::Value = response.json().await.unwrap();
    assert!(body.get("inference_id").is_some());
    let content = body["content"].as_array().unwrap();
    assert!(!content.is_empty());
    let text = content[0]["text"].as_str().unwrap();
    let parsed: serde_json::Value = serde_json::from_str(text).unwrap();
    assert!(parsed.get("pulse").is_some());
}

#[tokio::test]
async fn test_stagecraft_response() {
    let config = r#"
[models."deepseek-chat"]
routing = ["deepseek"]

[models."deepseek-chat".providers.deepseek]
type = "deepseek"
model_name = "deepseek-chat"

[functions.stagecraft_response]
type = "chat"

[functions.stagecraft_response.variants.deepseek_baseline]
type = "chat_completion"
model = "deepseek-chat"
weight = 1
system_template = "functions/stagecraft_response/variants/deepseek_baseline/system_template.minijinja"
user_template = "functions/stagecraft_response/variants/deepseek_baseline/user_template.minijinja"
"#;

    let gateway = start_gateway_on_random_port(config, None).await;

    let client = Client::new();
    let response = client
        .post(format!("http://{}/inference", gateway.addr))
        .json(&json!({
            "function_name": "stagecraft_response",
            "episode_id": Uuid::now_v7(),
            "input": {
                "InitiatorArchetype": "Hunter",
                "TargetArchetype": "Operator",
                "PulseLine": "Your shadow betrays the hunt.",
                "ChosenResponseScript": "Calculated Retreat"
            },
            "stream": false
        }))
        .send()
        .await
        .unwrap();

    assert_eq!(response.status(), 200);
    let body: serde_json::Value = response.json().await.unwrap();
    assert!(body.get("inference_id").is_some());
    let content = body["content"].as_array().unwrap();
    assert!(!content.is_empty());
    let text = content[0]["text"].as_str().unwrap();
    let parsed: serde_json::Value = serde_json::from_str(text).unwrap();
    assert!(parsed.get("response").is_some());
}

#[tokio::test]
async fn test_stagecraft_resolution() {
    let config = r#"
[models."deepseek-chat"]
routing = ["deepseek"]

[models."deepseek-chat".providers.deepseek]
type = "deepseek"
model_name = "deepseek-chat"

[functions.stagecraft_resolution]
type = "chat"

[functions.stagecraft_resolution.variants.deepseek_baseline]
type = "chat_completion"
model = "deepseek-chat"
weight = 1
system_template = "functions/stagecraft_resolution/variants/deepseek_baseline/system_template.minijinja"
user_template = "functions/stagecraft_resolution/variants/deepseek_baseline/user_template.minijinja"
"#;

    let gateway = start_gateway_on_random_port(config, None).await;

    let client = Client::new();
    let response = client
        .post(format!("http://{}/inference", gateway.addr))
        .json(&json!({
            "function_name": "stagecraft_resolution",
            "episode_id": Uuid::now_v7(),
            "input": {
                "InitiatorArchetype": "Hunter",
                "ResponseLine": "The wires remain undisturbed.",
                "ChosenResolutionScript": "Final Strike"
            },
            "stream": false
        }))
        .send()
        .await
        .unwrap();

    assert_eq!(response.status(), 200);
    let body: serde_json::Value = response.json().await.unwrap();
    assert!(body.get("inference_id").is_some());
    let content = body["content"].as_array().unwrap();
    assert!(!content.is_empty());
    let text = content[0]["text"].as_str().unwrap();
    let parsed: serde_json::Value = serde_json::from_str(text).unwrap();
    assert!(parsed.get("resolution").is_some());
}

#[tokio::test]
async fn test_stagecraft_payoff_calculation() {
    let config = r#"
[models."deepseek-reasoner"]
routing = ["deepseek"]

[models."deepseek-reasoner".providers.deepseek]
type = "deepseek"
model_name = "deepseek-reasoner"

[functions.stagecraft_payoff_calculation]
type = "chat"

[functions.stagecraft_payoff_calculation.variants.deepseek_reasoner]
type = "chat_completion"
model = "deepseek-reasoner"
weight = 1
system_template = "functions/stagecraft_payoff_calculation/variants/deepseek_reasoner/system_template.minijinja"
user_template = "functions/stagecraft_payoff_calculation/variants/deepseek_reasoner/user_template.minijinja"
"#;

    let gateway = start_gateway_on_random_port(config, None).await;

    let client = Client::new();
    let response = client
        .post(format!("http://{}/inference", gateway.addr))
        .json(&json!({
            "function_name": "stagecraft_payoff_calculation",
            "episode_id": Uuid::now_v7(),
            "input": {
                "InitiatorArchetype": "Hunter",
                "TargetArchetype": "Operator",
                "GuessedTargetArchetype": "Operator",
                "StatedIntent": "Extract",
                "ActualIntent": "Extract"
            },
            "stream": false
        }))
        .send()
        .await
        .unwrap();

    assert_eq!(response.status(), 200);
    let body: serde_json::Value = response.json().await.unwrap();
    assert!(body.get("inference_id").is_some());
    let content = body["content"].as_array().unwrap();
    assert!(!content.is_empty());
    let text = content[0]["text"].as_str().unwrap();
    let parsed: serde_json::Value = serde_json::from_str(text).unwrap();
    assert!(parsed.get("social_capital").is_some());
    assert!(parsed.get("explanation").is_some());
}
