import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import bodyParser from "body-parser";
import dbConnect from "./config/dbconnecter.js";
import authAPI from "./apis/authAPI.js";
import emailAPI from "./apis/emailAPI.js";
import userAPI from "./apis/userAPI.js";
import QuiseAPI from "./apis/QuiseAPI.js";
import EnrolAPI from "./apis/EnrolAPI.js";
import { app, io, server } from "./Socket-io/Socketiosever.js";
import videoAPI from "./apis/videoAPI.js";
import assignmentAPI from "./apis/assignmentAPI.js";
import TestAPI from "./apis/TestAPI.js";

dotenv.config();

// Connection to the database
dbConnect();

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
app.use(express.json());

// Routes
app.get("/", (req, res) => {
  res.send("It's mern");
});

// APIs
app.use("/api/auth", authAPI);
app.use("/api/email", emailAPI);
app.use("/api/user", userAPI);
app.use("/api/video", videoAPI);
app.use("/api/Quise", QuiseAPI);
app.use("/api/Enrol", EnrolAPI);
app.use("/api/assignment", assignmentAPI);
app.use("/api/Test", TestAPI);

// Port

const port = process.env.PORT || 5000;
server.listen(port, () => console.log(`Server port ${port}`));
