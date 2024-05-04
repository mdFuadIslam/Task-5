document.addEventListener('DOMContentLoaded', function() {
  const regionInput = document.getElementById('region');
  const errorSlider = document.getElementById('errorSlider');
  const errorText = document.getElementById('errorText');
  const seedInput = document.getElementById('seed');
  const randomButton = document.getElementById('randomButton');

  
  function updateText() {
    const region = regionInput.value;
    const error = errorText.value;
    const seed = seedInput.value;

    $.post('/update_data', { region: region, error: error, seed: seed })
  .done(function(response) {
    console.log('Data updated:', response);
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    console.error('Error updating data:', errorThrown);
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
