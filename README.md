# CareRev Event Receiving App

The application is hosted at https://jli-care-rev-challenge.herokuapp.com/.

This is my Event Receiving App coding challenge from CareRev! The stack uses Ruby and Ruby on Rails. 

The directions are as follows: Build an app that has an endpoint to receive POSTed JSON blobs. The JSON blob contains infromation to represent a “user event” that happens on some client app (EG: a web app or a native mobile app). 

Events have two fields: `name` and `event_type`, e.g. 

```
{
  "name": "like button click",
  "event_type": "click"
}
```


# HOW-TO 
## 1. Sending an event
Sending an event to the API 

```
curl --request POST 'https://jli-care-rev-challenge.herokuapp.com/events' \
--header 'Content-Type: application/json' \
--data-raw '{
    "event": {
        "name": "Commented on status",
        "event_type": "comment"
    }
}'
```
You should recive a response of the event created, e.g. 
```

{"id":3,"name":"Commented on status","event_type":"comment","created_at":"2021-09-09T00:17:31.710Z","updated_at":"2021-09-09T00:17:31.710Z"}% 
```
## 2. Getting Today's stats
This retrieves the counts of all event types that were recieved on the current date 

```
curl --location --request GET 'https://jli-care-rev-challenge.herokuapp.com/todays_stats' 
```
The response would look like this 

```

{"todays_stats":[{"click":1},{"comment":1}]}
```