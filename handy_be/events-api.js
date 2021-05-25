const url = 'mongodb://localhost:27017';
const { MongoClient } = require('mongodb');

dbConnect = (query) => {
  MongoClient.connect(url, { useUnifiedTopology: true }, (err, db) => {
    if (err) return console.error(err);
    var dbo = db.db('handy_events');
    query(dbo, () => {
      db.close();
    });
  });
};

exports.getAll = (req, res) => {
  dbConnect((db) => {
    const events = db
      .collection('events')
      .find(
        req.query.participantUser ? { participantUsers: { $elemMatch: { userId: req.query.participantUser } } } : {}
      )
      .project({ participantUsers: 0 })
      .toArray()
      .then((events) => {
        console.log(events);
        res.send(events);
      });
  });
};

exports.create = (req, res) => {
  const event = req.body;

  dbConnect((db) => {
    db.collection('events').insertOne(event);
    res.json({
      success: true,
      insertedEvent: req.body,
    });
  });
};

exports.subscribe = (req, res) => {
  dbConnect((db) => {
    console.log(req.params.id);
    db.collection('events').updateOne(
      { _id: req.params.id },
      {
        $push: {
          participantUsers: {
            userId: req.body.userId,
            registeredAt: (Date.now() / 1000) | 0,
            payment: null,
          },
        },
      }
    );
    res.json({
      success: true,
    });
  });
};

exports.unsubscribe = (req, res) => {
  dbConnect((db) => {
    db.collection('events').updateOne(
      { _id: req.params.id },
      {
        $pull: {
          participantUsers: {
            userId: req.body.userId,
          },
        },
      }
    );
    res.json({
      success: true,
    });
  });
};
