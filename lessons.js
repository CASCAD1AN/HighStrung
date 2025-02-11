/*
Citations for the following functions:
Date: Feb 11, 2025
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
*/


document.addEventListener('DOMContentLoaded', () => {
    const addLessonButton = document.querySelector('.add-lesson-button');
    const addLessonFormDiv = document.querySelector('.add-form');

    if (addLessonButton) {
        addLessonButton.addEventListener('click', () => {
            addLessonFormDiv.style.display = 'block';
            addLessonButton.style.display = 'none';
        });
    }

    const addCancelButton = document.querySelector('#add-cancel-button');
    if (addCancelButton) {
        addCancelButton.addEventListener('click', () => {
            addLessonFormDiv.style.display = 'none';
            addLessonButton.style.display = 'block';
        });
    }
});

