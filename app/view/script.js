// script.js
document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('crimeForm');
    const resultDiv = document.getElementById('result');

    if (!form || !resultDiv) {
        console.error('Form or result div not found');
        return;
    }

    form.addEventListener('submit', async (event) => {
        event.preventDefault();

        const suspect = document.getElementById('suspect').value;
        const crime = document.getElementById('crime').value;

        if (!suspect || !crime) {
            resultDiv.textContent = 'Veuillez sélectionner un suspect et un crime.';
            resultDiv.className = 'error';
            return;
        }

        try {
            const response = await fetch('http://localhost:3001/api/analyze', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ suspect, crime }),
            });

            const data = await response.json();

            if (response.ok) {
                resultDiv.textContent = data.result;
                resultDiv.className = data.result.includes('coupable') ? 'success' : 'error';
            } else {
                resultDiv.textContent = data.error || 'Erreur lors de l\'analyse';
                resultDiv.className = 'error';
            }
        } catch (error) {
            resultDiv.textContent = 'Erreur de serveur (lancer le server en: npm start) :' + error.message ;
            resultDiv.className = 'error';
        }
    });
});