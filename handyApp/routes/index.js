var express = require('express');
var app = express.Router();
const apiEvents = require('./events-api');

app.use(express.json());

/* GET home page. */
app.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

app.get('/try', apiEvents.try);

// get all upcoming events
app.get('/events', apiEvents.getAll);

app.get('/events/my', apiEvents.getAllMy);

// create a new event
app.post('/events', apiEvents.create);

// user subscribe to event
app.put('/events/:id/subscribe', apiEvents.subscribe);

// user unsubscribe to event
app.put('/events/:id/unsubscribe', apiEvents.unsubscribe);


module.exports = app;



