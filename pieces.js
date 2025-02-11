/*
Citations for the following functions:
Date: Feb 11, 2025
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
*/


document.addEventListener('DOMContentLoaded', () => {
    const addPieceButton = document.querySelector('.add-piece-button');
    const addPieceFormDiv = document.querySelector('.add-form');

    if (addPieceButton) {
        addPieceButton.addEventListener('click', () => {
            addPieceFormDiv.style.display = 'block';
            addPieceButton.style.display = 'none';
        });
    }

    const addCancelButton = document.querySelector('#add-cancel-button');
    if (addCancelButton) {
        addCancelButton.addEventListener('click', () => {
            addPieceFormDiv.style.display = 'none';
            addPieceButton.style.display = 'block';
        });
    }
});
