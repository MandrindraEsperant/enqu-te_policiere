const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');
const path = require("path");

const app = express();
app.use(cors());
app.use(express.json());

app.use(express.static(path.join(__dirname, "view")));

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "view", "index.html"));
});

app.post('/api/analyze', async (req, res) => {
    const { suspect, crime } = req.body;

    // Exécuter Prolog en ligne de commande
    const query = `swipl -q -s app/enquete.pl -g "main(${suspect},${crime}),halt."`;

    exec(query, (error, stdout, stderr) => {
        if (error) {
            console.error(`Erreur : ${error.message}`);
            return res.status(500).json({ error: error.message });
        }
        res.json({ result: stdout.trim() });
    });
});

app.listen(3001, () => console.log('Serveur démarré sur le port http://localhost:3001'));
