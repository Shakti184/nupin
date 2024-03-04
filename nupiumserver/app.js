const express = require('express');
const mongoose = require('mongoose');
const apiRouter = require('./routes/api');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

// Connect to MongoDB
mongoose.connect('mongodb+srv://shaktimad646:7qOTvIjantwYNxwf@cluster0.opmjarp.mongodb.net/nupiumAccademy?retryWrites=true&w=majority', {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Error connecting to MongoDB:', err));

// Routes
app.use('/api', apiRouter);

// Start server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
