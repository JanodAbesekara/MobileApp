import Chat from "../models/Chatmodels.js";
import Messagemodels from "../models/Messagemodels.js";

const createChatController = async (req, res) => {
  const newChat = new Chat({
    members: [req.body.senderId, req.body.receiverId],
  });
  try {
    const savedChat = await newChat.save();
    res.status(200).json(savedChat);
  } catch (err) {
    res.status(500).json(err);
  }
};

const userChatController = async (req, res) => {
  try {
    const chat = await Chat.find({
      members: { $in: [req.params.userId] },
    });
    res.status(200).json(chat);
  } catch (err) {
    res.status(500).json(err);
  } 
};

const findChatController = async (req, res) => {
  try {
    const chat = await Chat.findOne({
      members: { $all: [req.params.firstId, req.params.secondId] },
    });
    res.status(200).json(chat);
  } catch (err) {
    res.status(500).json(err);
  }
};

const addmessageController = async (req, res) => {
  const { chatId, senderId, message } = req.body;
  const newMessage = new Messagemodels({ chatId, senderId, message });

  try {
    const savedMessage = await newMessage.save();
    res.status(200).json(savedMessage);
  } catch (err) {
    res.status(500).json(err);
  }
};

const getmessageController = async (req, res) => {
    const { chatId } = req.params;
  try {
    const messages = await Messagemodels.find({ chatId });
    res.status(200).json(messages);
  } catch (err) {
    res.status(500).json(err);
  }
};

export {
  createChatController,
  userChatController,
  findChatController,
  addmessageController,
  getmessageController,
};
