#!/bin/bash

# Telegram bot token obtained from BotFather
BOT_TOKEN="YOUR_BOT_TOKEN"

# URL for the Telegram Bot API
API_URL="https://api.telegram.org/bot$BOT_TOKEN"

# Function to send a message
send_message() {
    local chat_id="$1"
    local message="$2"
    curl -s -X POST "$API_URL/sendMessage" -d "chat_id=$chat_id" -d "text=$message" > /dev/null
}

# Main function to handle incoming updates
main() {
    # Get updates from the bot
    updates=$(curl -s "$API_URL/getUpdates")

    # Extract chat ID, message text, and command from the updates
    chat_id=$(echo "$updates" | jq -r '.result[0].message.chat.id')
    message_text=$(echo "$updates" | jq -r '.result[0].message.text')
    command=$(echo "$message_text" | awk '{print $1}')

    # Check if the command is "/start"
    if [ "$command" = "/start" ]; then
        # Send a welcome message
        send_message "$chat_id" "Welcome to the Bot! You can use /help to see available commands."
    fi

    # Check if the command is "/help"
    if [ "$command" = "/help" ]; then
        # Send a help message
        send_message "$chat_id" "This is a simple check bot.
        Available commands:
        /start - Start the bot
        /help - Display this help message
        /about - Display information about the bot
        /info - Display information about the bot and commands"
    fi

    # Check if the command is "/about"
    if [ "$command" = "/about" ]; then
        # Send information about the bot
        send_message "$chat_id" "This is a simple check bot created using Shell script.
        It provides basic functionality for checking commands."
    fi

    # Check if the command is "/info"
    if [ "$command" = "/info" ]; then
        # Send information about the bot and commands
        send_message "$chat_id" "This bot provides basic functionality for checking commands.
        It supports the following commands:
        /start - Start the bot
        /help - Display help message
        /about - Display information about the bot
        /info - Display information about the bot and commands"
    fi
}

# Call the main function
main
