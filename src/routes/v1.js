import express from "express";
const router = express.Router();

import userModule from "./modules/user.module";
router.use("/users", userModule);

module.exports = router;
