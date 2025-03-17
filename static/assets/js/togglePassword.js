function togglePassword() {
    let passwordField = document.getElementById("yourPassword");
    let toggleIcon = document.getElementById("toggleEye");

    if (passwordField.type === "password") {
    passwordField.type = "text";
    toggleIcon.classList.remove("bi-eye");
    toggleIcon.classList.add("bi-eye-slash");
    } else {
    passwordField.type = "password";
    toggleIcon.classList.remove("bi-eye-slash");
    toggleIcon.classList.add("bi-eye");
    }
}
