import express from "express";
const router = express.Router();
import fs from "fs";

let users = [];

router.get("/", (req, res) => {
  res.json(require("./../../../src/user-post-api/users.json"));
});

router.get("/:id", (req, res) => {
  const userId = req.params.id;
  const users = require("./../../../src/user-post-api/users.json");
  const user = users.find((user) => user.id == userId);
  if (!user) {
    res.status(404).json({ message: `User with id ${userId} not found` });
  } else {
    res.json(user);
  }
});

router.post("/", (req, res) => {
  const newUser = req.body;
  const users = require("./../../../src/user-post-api/users.json");
  const maxId = Math.max(...users.map((user) => user.id));
  const user = {
    id: maxId + 1,
    ...newUser,
  };
  users.push(user);
  console.log(users);
  fs.writeFileSync(
    __dirname + "/../../../src/user-post-api/users.json",
    JSON.stringify(users)
  );
  res.json(users);
});

router.delete("/:id", (req, res) => {
  const userId = req.params.id;
  const users = require("./../../../src/user-post-api/users.json");
  const newUsers = users.filter((user) => user.id != userId);
  if (newUsers.length == users.length) {
    res.status(404).json({ message: `User with id ${userId} not found` });
  } else {
    fs.writeFileSync(
      __dirname + "/../../../src/user-post-api/users.json",
      JSON.stringify(newUsers, null, 2)
    );
    res.json(newUsers);
  }
});

router.put("/:id", (req, res) => {
  const userId = req.params.id;
  const users = require("./../../../src/user-post-api/users.json");
  const userIndex = users.findIndex((user) => user.id == userId);
  if (userIndex == -1) {
    res.status(404).json({ message: `User with id ${userId} not found` });
  } else {
    users[userIndex] = {
      ...req.body,
      id: userId,
    };
    fs.writeFileSync(
      __dirname + "/../../../src/user-post-api/users.json",
      JSON.stringify(users, null, 2)
    );
    res.json(users);
  }
});

router.get("/:id/posts", (req, res) => {
  const userId = req.params.id;
  const users = require("./../../../src/user-post-api/users.json");
  console.log(users);
  const user = users.find((user) => user.id == userId);
  if (!user) {
    res.status(404).json({ message: `User with id ${userId} not found` });
  } else {
    const userPosts = require("./../../../src/user-post-api/posts.json").filter(
      (post) => post.userId == userId
    );
    res.json(userPosts);
  }
});

module.exports = router;
