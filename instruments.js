/*
Citations for the following functions:
Date: Feb 11, 2025
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
*/


document.addEventListener('DOMContentLoaded', () => {
    const addInstrumentButton = document.querySelector('.add-instrument-button');
    const addInstrumentFormDiv = document.querySelector('.add-form');

    if (addInstrumentButton) {
        addInstrumentButton.addEventListener('click', () => {
            addInstrumentFormDiv.style.display = 'block';
            addInstrumentButton.style.display = 'none';
        });
    }

    const addCancelButton = document.querySelector('#add-cancel-button');
    if (addCancelButton) {
        addCancelButton.addEventListener('click', () => {
            addInstrumentFormDiv.style.display = 'none';
            addInstrumentButton.style.display = 'block';
        });
    }
});
