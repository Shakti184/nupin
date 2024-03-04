const express = require('express');
const router = express.Router();
const DegreeProgram = require('../models/degreeProgram');
const Course = require('../models/course');

// Create a new degree program
router.post('/programs', async (req, res) => {
    try {
        // Create degree program
        const degreeProgram = await DegreeProgram.create(req.body);

        // Associate existing courses with the program
        const courseIds = req.body.courseIds; // Assuming courseIds is an array of existing course IDs
        if (courseIds && courseIds.length > 0) {
            // Update degree program with course IDs
            degreeProgram.courses = courseIds;
            await degreeProgram.save();
        }

        res.status(201).json(degreeProgram);
    } catch (err) {
        console.error(err); // Log the error
        res.status(400).json({ message: err.message });
    }
});

// Get all degree programs with populated courses
router.get('/programs', async (req, res) => {
    try {
        const degreePrograms = await DegreeProgram.find().populate('courseIds');
        res.json(degreePrograms);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Create a new course
router.post('/courses', async (req, res) => {
    try {
        const course = await Course.create(req.body);
        res.status(201).json(course);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

// Get all courses
router.get('/courses', async (req, res) => {
    try {
        const courses = await Course.find();
        res.json(courses);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

module.exports = router;
