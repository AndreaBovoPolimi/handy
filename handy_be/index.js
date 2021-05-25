const express = require('express');
const app = express();
const port = 3000;

const apiEvents = require('./events-api');

app.use(express.json());

// get all upcoming events
app.get('/events', apiEvents.getAll);

// create a new event
app.post('/events', apiEvents.create);

// user subscribe to event
app.put('/events/:id/subscribe', apiEvents.subscribe);

// user unsubscribe to event
app.put('/events/:id/unsubscribe', apiEvents.unsubscribe);

app.listen(port, () => console.log(`Handy backend listening at http://localhost:${port}`));
