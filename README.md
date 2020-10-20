# Electric Imp Studio Demo

## About

This project was created for a Twilio Releases webinar. It shows how [Twilio Electric Imp](https://electricimp.com) can interact with [Twilio Studio](https://www.twilio.com/studio).

A Studio flow handles incoming text messages and when a message contains the keyword "coffee" it will trigger some logic on the Electric Imp board to turn on an LED.

When a button, attached to the board, gets pressed it will trigger a different Studio flow to send out an SMS.

## Requirements

- Electric Imp board like the ImpExplorer
- A grove-connector button
- Electric Imp account - [Sign up here](https://impcentral.electricimp.com/)
- Twilio account - [Sign up here](https://www.twilio.com/try-twilio)
- A Twilio phone number

## Setup

### Electric Imp Board

1. Walk through the [Electric Imp getting started guide](https://developer.electricimp.com/gettingstarted/developer/account)
2. [Configure the environment variables](https://developer.electricimp.com/tools/impcentral/impcentral-user-guide#product-and-device-group-settings) for your Electric Imp board:

```
{
    "AUTH_TOKEN": "<your_twilio_auth_token>",
    "ACCOUNT_SID": "<your_twilio_account_sid>",
    "MY_PHONE_NUMBER": "<your_phone_number>",
    "TWILIO_PHONE_NUMBER": "<your_twilio_phone_number>"
}
```

3. Connect the Grove Button to the Grove connector that has the `Pin 5` label on it.
4. Copy the code from the `src/device.nut` into the device code section of your board
5. Copy the code from the `src/agent.nut` into the agent code section of your board.
6. Deploy the code changes and copy the Agent URL that has been logged when you deployed the code changes. It should look something like this:
   > `https://agent.electricimp.com/...?led=1`

### Studio Flow

1. Change the JSON from `flows/IncomingOrder.json` by replacing `<AGENTURL>` with the URL you copied int he previous step.
2. [Create a new Studio Flow](https://www.twilio.com/console/studio/dashboard) from the copied JSON and call it something like "Incoming Order".
3. Configure your Twilio phone number to use the Studio flow for incoming messages.
4. Copy the JSON from `flows/OrderReady.json` and create a new Studio flow with a name like `Order Ready`.
5. Click on the "Trigger" in the Studio UI and copy the `REST API URL` field on the right. It should look something like this:
   > `https://studio.twilio.com/v2/Flows/FW.../Executions`
6. Go into the Agent code of your board and set the `url` value to the URL you just copied.
7. Redeploy your Electric Imp code.

## Usage

1. Text your Twilio phone number anything. You should be prompted to text something else.
2. Text `coffee` and the LED on your board should turn red.
3. Press the button attached to your board and it should send an SMS back to you.

## License

MIT
