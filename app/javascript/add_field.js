document.addEventListener("DOMContentLoaded", function() {
  // Select all elements with the class "add-field"
  const addFieldButtons = document.querySelectorAll(".add-field");

  // Add event listener to each "Add Custom Field" button
  addFieldButtons.forEach(button => {
    button.addEventListener("click", function(event) {
      event.preventDefault();

      // Get the template content and replace the NEW_RECORD placeholder with a unique timestamp
      const template = document.getElementById("field_template").innerHTML;
      const newId = new Date().getTime();
      const newFields = template.replace(/NEW_RECORD/g, newId);

      // Append the new fields to the new_fields div
      document.getElementById("new_fields").insertAdjacentHTML("beforeend", newFields);

      // Add event listener to the remove button of the newly added fields
      const removeButtons = document.querySelectorAll(".remove-field");
      removeButtons.forEach(button => {
        button.addEventListener("click", function(event) {
          event.preventDefault();
          this.closest(".nested-fields").remove();
        });
      });
    });
  });
});
