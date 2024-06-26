# Easy Telegram Notifications For Failed Services
Adapted from [baeldung.com](https://www.baeldung.com/linux/systemd-service-fail-notification)

Need to create a bot first using the BotFather see [here](https://core.telegram.org/bots/features#botfather)

Then get the user id of the user you want to send the message to. \
Can be done by first sending a message to the bot and then calling following API to find all messages (and user ids of them) sent to the bot. \
`https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`

## Script "Installation"
Create *config.conf* by copying the *template.conf* file and inserting the correct values.

Telegram Script can be tested/used with \
`./telegram.sh -s "Service Name"`

Keep in mind to \
`sudo chmod +x telegram.sh`

## Install the Notification Service

Edit *notify-telegram@.service* with correct path to *telegram.sh*

Then move *notify-telegram@.service* to */etc/systemd/system/* (or other suitable systemd location) \
`sudo cp notify-telegram@.service /etc/systemd/system/notify-telegram@.service`

## Add the Notification Service to a Service

Finally, add this notification to the service under the [Unit] tag (see *dummy.service*) \
`OnFailure=notify-telegram@%i.service`

And reload the daemon \
`sudo systemctl daemon-reload`
