document.addEventListener('DOMContentLoaded', function() {
  const regionInput = document.getElementById('region');
  const errorSlider = document.getElementById('errorSlider');
  const errorText = document.getElementById('errorText');
  const seedInput = document.getElementById('seed');
  const randomButton = document.getElementById('randomButton');

  regionInput.value = '<%= cookies[:region] %>';
  errorText.value = '<%= cookies[:error] %>';
  seedInput.value = '<%= cookies[:seed] %>';

  async function updateText() {
    const region = regionInput.value;
    const error = errorText.value;
    const seed = seedInput.value;
  
    const response = await fetch(`/update_data?region=${region}&error=${error}&seed=${seed}`);
    const data = await response.json();

    const tableBody = document.getElementById('user-table-body');
    
    while (tableBody.firstChild) {
      tableBody.removeChild(tableBody.firstChild);
    }

    data.forEach(({ id, identifier, name, address, phone_number }) => {
      const row = document.createElement('tr');
      row.innerHTML = `
        <td>${id}</td>
        <td>${identifier}</td>
        <td>${name}</td>
        <td>${address}</td>
        <td>${phone_number}</td>
      `;
      tableBody.appendChild(row);
    });
  }
  function errorSliderChange(){
    errorText.value = errorSlider.value * 100;
    updateText()
  }
  function errorTextChange(){
    errorSlider.value = errorText.value / 100;
    updateText()
  }
  // Event listeners for form elements
  regionInput.addEventListener('change', updateText);
  errorSlider.addEventListener('input', errorSliderChange);
  seedInput.addEventListener('input', updateText);
  errorText.addEventListener('input', errorTextChange);

  // Event listener for random button
  randomButton.addEventListener('click', function() {
    // Generate a random value for seed (e.g., between 1 and 100)
    const randomSeed = Math.floor(Math.random() * 100) + 1;
    
    // Update the value of @seed (you can replace this with an AJAX call to update it on the server)
    seedInput.value = randomSeed;

    // Update paragraph text
    updateText()
  });
  
});
