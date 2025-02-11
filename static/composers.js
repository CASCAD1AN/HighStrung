/*
Citations for the following functions:
Date: Feb 11, 2025
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
*/


document.addEventListener('DOMContentLoaded', () => {
    const addComposerButton = document.querySelector('.add-composer-button');
    const addComposerFormDiv = document.querySelector('.add-form');

    if (addComposerButton) {
        addComposerButton.addEventListener('click', () => {
            addComposerFormDiv.style.display = 'block';
            addComposerButton.style.display = 'none';
        });
    }

    const addCancelButton = document.querySelector('#add-cancel-button');
    if (addCancelButton) {
        addCancelButton.addEventListener('click', () => {
            addComposerFormDiv.style.display = 'none';
            addComposerButton.style.display = 'block';
        });
    }
});
