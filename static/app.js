/*
Citations for the following functions:
Date: Feb 11, 2025
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
Adapted from: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/Element/closest
Adapted from: https://developer.mozilla.org/en-US/docs/Web/API/Window/confirm
Adapted from: https://www.geeksforgeeks.org/how-to-remove-the-table-row-in-a-table-using-javascript/
*/

document.addEventListener('DOMContentLoaded', () => {
    // STUDENTS page actions
    const addStudentButton = document.querySelector('.add-student-button');
    // const studentSubmitButton = document.querySelector('#add-submit-button'); this doesn't do anything right now

    // LESSONS page actions
    const addLessonButton = document.querySelector('.add-lesson-button');
    // const lessonSubmitButton = document.querySelector('#add-submit-button'); this doesn't do anything right now

    // REUSABLE ACTIONS ACROSS FORMS
    const editButtons = document.querySelectorAll('.edit-student-button');   // multiples; one each, for each row
    const deleteButtons = document.querySelectorAll('.delete-student-button');   // multiples; one each, for each row

    const addCancelButton = document.querySelector('#add-cancel-button');
    const addFormDiv = document.querySelector('.add-form');

    const editCancelButton = document.querySelector('#edit-cancel-button');
    const editFormDiv = document.querySelector('.edit-form');
    // const editSubmitButton = document.querySelector('#edit-update-button'); this doesn't do anything right now


    addStudentButton.addEventListener('click', () => {
        addFormDiv.style.display = 'block';
        addButton.style.display = 'none';
    });

    editButtons.forEach((editButton) => {
        editButton.addEventListener('click', (event) => {
            const row = event.target.closest('tr');
            const firstName = row.querySelector('td:nth-child(1)').textContent;
            const lastName = row.querySelector('td:nth-child(2)').textContent;
            const address = row.querySelector('td:nth-child(3)').textContent;
            const city = row.querySelector('td:nth-child(4)').textContent;
            const state = row.querySelector('td:nth-child(5)').textContent;
            const zip = row.querySelector('td:nth-child(6)').textContent;
            const phone = row.querySelector('td:nth-child(7)').textContent;
            const email = row.querySelector('td:nth-child(8)').textContent;
            const parentFirstName = row.querySelector('td:nth-child(9)').textContent;
            const parentLastName = row.querySelector('td:nth-child(10)').textContent;
            const isActive = row.querySelector('td:nth-child(11)').textContent;

            document.querySelector('#editFirstName').value = firstName;
            document.querySelector('#editLastName').value = lastName;
            document.querySelector('#editAddress').value = address;
            document.querySelector('#editCity').value = city;
            document.querySelector('#editState').value = state;
            document.querySelector('#editZip').value = zip;
            document.querySelector('#editPhone').value = phone;
            document.querySelector('#editEmail').value = email;
            document.querySelector('#editParentFirstName').value = parentFirstName;
            document.querySelector('#editParentLastName').value = parentLastName;
            document.querySelector('#editIsActive').value = isActive;

            if (isActive === 'Yes') {
                document.querySelector('#editIsActive').value = '1';
            } else if (isActive === 'No') {
                document.querySelector('#editIsActive').value = '0';
            }

            editFormDiv.style.display = 'block';
            addButton.style.display = 'none';
        });
    });

    deleteButtons.forEach((deleteButton) => {
        deleteButton.addEventListener('click', (event) => {
            const deleteConfirm = window.confirm('ARE YOU SURE YOU WANT TO DELETE THIS STUDENT?');
            if (deleteConfirm) {
                const row = event.target.closest('tr');
                row.remove();   // does not reflect logic that will be implemented for actual database deletion
            }
        });
    });

    addCancelButton.addEventListener('click', () => {
        addFormDiv.style.display = 'none';
        addButton.style.display = 'block';
    });

    editCancelButton.addEventListener('click', () => {
        editFormDiv.style.display = 'none';
        addButton.style.display = 'block';
    });


});
