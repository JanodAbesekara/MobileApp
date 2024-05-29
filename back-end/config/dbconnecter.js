import mongoose from "mongoose";

const connect = async () => {
  mongoose.connect(process.env.MONGO_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

  const db = mongoose.connection;

  db.on("error", (error) => {
    console.error("MongoDB connection error:", error);
  });

  db.once("open", () => {
    console.log("MongoDB connected successfully");
  });

  db.once("disconnected", () => {
    console.log("MongoDB disconnected");
  });

  process.on("SIGINT", () => {
    db.close(() => {
      console.log("MongoDB connection closed due to application termination");
      process.exit(0);
    });
  });
};

export default connect;
