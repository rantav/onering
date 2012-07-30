# Realtime Updates

This is a description of how to send realtime messages to onering to update chef and glu information.

## Introduction
Onering updates chef and glu in a cron job every hour or so. It then scans the entire configuratin of chef or glu (and potentially other plugins) 
to update it's entire tree.
If, however, there are small updates within the hour, you may send messages to a topic (message queue broadcast) so that they would be fetched imediatily.

## Queue setup
Onering uses ActieMQ (amq) for messaging and the Stomp protocol.
When installing amq you have to make sure that it is stomp enabled.
For instructions see [http://activemq.apache.org/stomp.html](http://activemq.apache.org/stomp.html)
In short, this looks like this:

    <transportConnectors>
    	<transportConnector name="stomp" uri="stomp://localhost:61613"/>
    </transportConnectors>

## Topic name
By default onering listenes for messages on the topic named `onering`. You may configure that in the /settings page.
So in amq jargon this would be `/topic/onering`

## Message format
The messages should be plain JSON strings

	{"source": "chef", "host": "ob1049.nydc1.outbrain.com"}

There are two mandatory fields, the `source` (glu or chef) and the `host`.

## Examples:
From curl (assuming amq is installed locally). Upate chef info for host ob1049

	curl -D - -X POST -H "Content-Type: text/xml" -d '{"source": "chef", "host": "ob1049.nydc1.outbrain.com"}' "http://localhost:8161/admin/send/onering?type=topic&JMSDeliveryMode=nonpersistent"

Upate chef info for host ob1049

	curl -D - -X POST -H "Content-Type: text/xml" -d '{"source": "chef", "host": "ob1049.nydc1.outbrain.com"}' "http://localhost:8161/admin/send/onering?type=topic&JMSDeliveryMode=nonpersistent"