const url =
  'mongodb://handy-app-dil:GpaIiTARyQXzYlyz6C9yzPQx3IhAJZLXDQQ2UnKUOMUhEKJMG9B7XnXZUrcA59uINv7qRLrgH67oNJbfNNV0Tw==@handy-app-dil.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@handy-app-dil@';
//const url = 'mongodb://localhost:27017/?readPreference=primary&appname=MongoDB%20Compass&ssl=false';
const { MongoClient } = require('mongodb');
const recSys = require('./recsys');

dbConnect = (query) => {
  MongoClient.connect(url, { useUnifiedTopology: true }, (err, db) => {
    if (err) return console.error(err);
    var dbo = db.db('handy_events');
    query(dbo, () => {
      db.close();
    });
  });
};

exports.try = (req, res) => {
  res.send({
    result: true,
  });
};

exports.getAll = (req, res) => {
  dbConnect((db) => {
    const events = db
      // queried collections: events
      .collection('events')
      // only events the user is not subscribed to
      .find({
        participantUsers: {
          $not: { $elemMatch: { userId: req.query.participantUser } },
        },
      })
      // ignore useless and heavy fields
      .project({ participantUsers: 0 })
      .toArray()
      .then((events) => {
        const studentDepartment = this.getDepartmentByUserId(req.query.participantUser);

        // get the sorted event categories based on recommender system
        const sortedCategoriesByDep = recSys.getSortedCategoriesByDepartment(studentDepartment);
        const sortByRecSys = (ev1, ev2) =>
          sortedCategoriesByDep[ev1.category] < sortedCategoriesByDep[ev2.category] ? 1 : -1;

        // sort events to show the user the more suitable ones first
        events.sort(sortByRecSys);

        // response
        res.send({
          result: true,
          data: events,
        });
      });
  });
};

exports.getAllMy = (req, res) => {
  dbConnect((db) => {
    const events = db
      .collection('events')
      .find({
        participantUsers: {
          $elemMatch: {
            userId: req.query.participantUser,
          },
        },
      })
      .project({ participantUsers: 0 })
      .toArray()
      .then((events) => {
        res.send({
          result: true,
          data: events,
        });
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

exports.getDepartmentByUserId = (userId) => {
  return 'architecture';
};
