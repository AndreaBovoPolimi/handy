var express = require('express');
var app = express.Router();
const apiEvents = require('./events-api');

app.use(express.json());

// get suggested upcoming events
app.get('/events', apiEvents.getAll);

// get events I'm subscribed to
app.get('/events/my', apiEvents.getAllMy);

// create a new event
app.post('/events', apiEvents.create);

// user subscribe to event
app.put('/events/:id/subscribe', apiEvents.subscribe);

// user unsubscribe to event
app.put('/events/:id/unsubscribe', apiEvents.unsubscribe);

/* GET home page (just a test). */
app.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

// app.get('/try', apiEvents.try);

module.exports = app;
