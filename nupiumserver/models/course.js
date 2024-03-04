const mongoose = require('mongoose');

const courseSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    description: String,
    price: {
        type: Number,
        required: true
    },
    duration: {
        type: Number,
        required: true
    }
}, { versionKey: false });

const Course = mongoose.model('Courses', courseSchema);

module.exports = Course;
