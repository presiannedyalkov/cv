var checkbox = document.querySelector('input[name=mode]')
checkbox.addEventListener('change', function() {
    if(this.checked) {
        document.documentElement.setAttribute('data-theme', 'dark');
        document.getElementById('switch-icon').classList.add('mdi-weather-sunny');
        document.getElementById('switch-icon').classList.remove('mdi-weather-night');
    } else {
        document.documentElement.setAttribute('data-theme', 'light');
        document.getElementById('switch-icon').classList.add('mdi-weather-night');
        document.getElementById('switch-icon').classList.remove('mdi-weather-sunny');
    }
})