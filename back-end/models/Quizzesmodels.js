import mongoose from 'mongoose';

const { Schema } = mongoose;

const QuizSchema = new Schema({
    TeacherEmail:{
        type: String,
        required: true
    },
    TeacherSubject:{
        type: String,
        required: true
    },
    submedium:{
        type: String,
        required: true
    },
    QuizeNumber:{
        type: Number,
        required: true
    },
    question: [
        {
            Question: {
                type: String,
                required: true
            },
            answers: {
                type: [String],
                required: true
            },
            correctAnswerIndex: {
                type: Number,
                required: true
            }
        }
    ],
    TimeRanges:{
        type:Number,
        required: true
    },
});

const Quiz = mongoose.model('Quiz', QuizSchema);
export default Quiz;