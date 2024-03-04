const mongoose = require('mongoose');

const degreeProgramSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    description: String,
    courseIds: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Courses' // Refers to the Course model
    }]
}, { versionKey: false });

const DegreeProgram = mongoose.model('DegreeProgrammes', degreeProgramSchema);

module.exports = DegreeProgram;
